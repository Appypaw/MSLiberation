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
        if (_it == 201) then {_price = 700; _level = 2; _unlockKey = "optic";};
        if (_it == 101) then {_price = 800; _level = 3; _unlockKey = "suppressor";};
        if (_it == 616) then {_price = 2500; _level = 5; _unlockKey = "nvg";};
        if (_it in [701, 801]) then {_price = 650; _level = 2; _unlockKey = "armor";};
    };
};
if (_root == "CfgVehicles" && {getNumber (_cfg >> "isBackpack") != 1}) then {_kind = "invalid";};
if (_kind == "invalid") exitWith {[]};
if (_kind == "magazine") then {_price = 60;};
if (_kind == "backpack") then {_price = 400;};
{if ((_x select 0) == _unlockKey) then {_level = _x select 1;};} forEach MSL_unlockRules;
{if ((_x select 0) == _class) then {_level = _x select 1;};} forEach MSL_unlockRules;
{if ((_x select 0) == _class) exitWith {_price = _x select 1; _level = _x select 2;};} forEach MSL_priceOverrides;
[_class, getText (_cfg >> "displayName"), _price, _level, _kind]
