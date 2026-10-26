// Returns [class, label, price, level, kind] or [] for internal/non-handheld classes.
params [["_class", "", [""]], ["_sale", false, [false]]];
private _root = "CfgWeapons";
private _kind = "item";
if (isClass (configFile >> "CfgMagazines" >> _class)) then {_root = "CfgMagazines"; _kind = "magazine";};
if (isClass (configFile >> "CfgVehicles" >> _class)) then {_root = "CfgVehicles"; _kind = "backpack";};
if (isClass (configFile >> "CfgGlasses" >> _class)) then {_root = "CfgGlasses"; _kind = "goggles";};
private _cfg = configFile >> _root >> _class;
if (!isClass _cfg || {!_sale && {getNumber (_cfg >> "scope") < 2}}) exitWith {[]};
private _lower = toLower _class;
if (!_sale && {(_lower find "folded") >= 0 || {(_lower find "_base") >= 0} || {(_lower find "_used") >= 0}}) exitWith {[]};
private _price = 120; private _level = 1; private _unlockKey = _kind;
if (_root == "CfgWeapons") then {
    private _type = getNumber (_cfg >> "type");
    if (_type in [1, 2, 4]) then {
        _kind = "weapon";
        _unlockKey = ["weapon_rifle","weapon_pistol","weapon_launcher"] select ([1,2,4] find _type);
        _price = [1200, 500, 2500] select ([1, 2, 4] find _type);
        _level = [2, 1, 4] select ([1, 2, 4] find _type);
        if (!_sale && {(_class call BIS_fnc_baseWeapon) != _class}) exitWith {_kind = "invalid";};
        if (!_sale && {count ("true" configClasses (_cfg >> "LinkedItems")) > 0}) then {_kind = "invalid";};
    } else {
        private _it = getNumber (_cfg >> "ItemInfo" >> "type");
        if (_it == 0 && {_type != 4096}) then {_kind = "invalid";};
        if (_it == 201) then {
            _unlockKey = "optic";
            {
                private _zoom = getNumber (_x >> "opticsZoomMin");
                if (_zoom > 0 && {_zoom < 0.0625} && {_unlockKey == "optic"}) then {_unlockKey = "optic_medium";};
                if (_zoom > 0 && {_zoom < 0.025} && {_unlockKey in ["optic","optic_medium"]}) then {_unlockKey = "optic_long";};
                private _vision = getArray (_x >> "visionMode");
                if ("NVG" in _vision && {_unlockKey != "optic_thermal"}) then {_unlockKey = "optic_night";};
                if ("Ti" in _vision) then {_unlockKey = "optic_thermal";};
            } forEach ("true" configClasses (_cfg >> "ItemInfo" >> "OpticsModes"));
        };
        if (_it == 101) then {
            _unlockKey = "muzzle";
            if (getNumber (_cfg >> "ItemInfo" >> "AmmoCoef" >> "audibleFire") < 1 && {isNumber (_cfg >> "ItemInfo" >> "AmmoCoef" >> "audibleFire")}) then {_unlockKey = "suppressor";};
        };
        if (_it == 301) then {_unlockKey = "pointer";};
        if (_it == 302) then {_unlockKey = "bipod";};
        if (_it == 616) then {
            _unlockKey = "nvg";
            if ("Ti" in getArray (_cfg >> "visionMode")) then {_unlockKey = "nvg_thermal";};
        };
        if (_it == 801) then {
            _unlockKey = "uniform";
            if ((toLower getText (_cfg >> "ItemInfo" >> "uniformClass") find "ghillie") >= 0 || {(_lower find "ghillie") >= 0}) then {_unlockKey = "ghillie";};
            if ((_lower find "wetsuit") >= 0) then {_unlockKey = "wetsuit";};
        };
        if (_it in [605,701]) then {
            private _armor = getNumber (_cfg >> "ItemInfo" >> "armor");
            {_armor = _armor max getNumber (_x >> "armor");} forEach ("true" configClasses (_cfg >> "ItemInfo" >> "HitpointsProtectionInfo"));
            if (_it == 605) then {
                _unlockKey = "headgear";
                if (_armor > 0) then {_unlockKey = "helmet";};
                if (_armor >= 10) then {_unlockKey = "helmet_heavy";};
            } else {
                _unlockKey = "vest";
                if (_armor > 0) then {_unlockKey = "armor_light";};
                if (_armor >= 12) then {_unlockKey = "armor";};
                if (_armor >= 20) then {_unlockKey = "armor_heavy";};
            };
        };
        if (_type == 4096) then {
            _unlockKey = "binocular";
            if (getNumber (_cfg >> "distanceZoomMin") > 0) then {_unlockKey = "rangefinder";};
            if (getNumber (_cfg >> "Laser") > 0) then {_unlockKey = "designator";};
        };
        if (_it == 621) then {_unlockKey = "uav_terminal";};
        if (_class in ["ItemGPS"]) then {_unlockKey = "navigation";};
        if (_class == "ItemRadio" || {(_lower find "tfar_") == 0}) then {_unlockKey = "radio";};
        if (_class == "Medikit") then {_unlockKey = "medical";};
        if (_class == "ToolKit") then {_unlockKey = "toolkit";};
        if (_class in ["MineDetector","DroneDetector"]) then {_unlockKey = "detector";};
    };
};
if (_root == "CfgVehicles" && {getNumber (_cfg >> "isBackpack") != 1}) then {_kind = "invalid";};
if (_kind == "invalid") exitWith {[]};
if (_kind == "magazine") then {_price = 60;};
if (_kind == "backpack") then {
    private _load = getNumber (_cfg >> "maximumLoad");
    if (_load > 160) then {_unlockKey = "backpack_medium";};
    if (_load > 280) then {_unlockKey = "backpack_large";};
    if (getNumber (_cfg >> "tf_hasLRradio") > 0) then {_unlockKey = "radio_pack";};
    if (isClass (_cfg >> "assembleInfo") && {getText (_cfg >> "assembleInfo" >> "assembleTo") != ""}) then {_unlockKey = "static_pack";};
};
{if ((_x select 0) == _unlockKey) exitWith {_price = _x select 1; _level = _x select 2;};} forEach MSL_equipmentTiers;
{if ((_x select 0) == _unlockKey) then {_level = _x select 1;};} forEach MSL_unlockRules;
{if ((_x select 0) == _class) then {_level = _x select 1;};} forEach MSL_unlockRules;
{if ((_x select 0) == _class) exitWith {_price = _x select 1; _level = _x select 2;};} forEach MSL_weaponPreset;
{if ((_x select 0) == _class) exitWith {_price = _x select 1; _level = _x select 2;};} forEach MSL_attachmentPreset;
{if ((_x select 0) == _class) exitWith {_price = _x select 1; _level = _x select 2;};} forEach MSL_priceOverrides;
// Ordinary uniforms are free to acquire and have no resale value.
if (_unlockKey == "uniform") then {_price = 0; _level = 1;};
[_class, getText (_cfg >> "displayName"), _price, _level, _kind]
