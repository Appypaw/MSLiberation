// Runs on server before publishing the paid catalog. Never import vehicle ammunition.
[] call compileFinal preprocessFileLineNumbers "presets\msl\imported_equipment.sqf";
GRLIB_arsenal_weapons = [];
GRLIB_arsenal_items = [];
GRLIB_arsenal_backpacks = [];
GRLIB_arsenal_magazines = [];
private _ammo = [];
{
    private _cfg = configFile >> "CfgWeapons" >> _x;
    private _entry = [_x] call MSL_fnc_catalog;
    if (!(_entry isEqualTo [])) then {
        if ((_entry select 4) == "weapon") then {
            GRLIB_arsenal_weapons pushBackUnique _x;
            private _weapon = _x;
            private _muzzles = getArray (_cfg >> "muzzles");
            if (_muzzles isEqualTo []) then {_muzzles = ["this"];};
            {{_ammo pushBackUnique (toLower _x);} forEach compatibleMagazines [_weapon, _x];} forEach _muzzles;
        } else {GRLIB_arsenal_items pushBackUnique _x;};
    };
} forEach MSL_import_weapons;
// Throw/Put include mod grenades, mines, satchels and remote charges.
{
    private _weapon = _x;
    {
        {_ammo pushBackUnique (toLower _x);} forEach compatibleMagazines [_weapon, _x];
    } forEach getArray (configFile >> "CfgWeapons" >> _weapon >> "muzzles");
} forEach ["Throw", "Put"];
{
    if ((toLower _x) in _ammo && {getNumber (configFile >> "CfgMagazines" >> _x >> "scope") == 2}) then {
        GRLIB_arsenal_magazines pushBackUnique _x;
    };
} forEach MSL_import_magazines;
{
    if (getNumber (configFile >> "CfgVehicles" >> _x >> "isBackpack") == 1) then {GRLIB_arsenal_backpacks pushBackUnique _x;};
} forEach MSL_import_backpacks;
{GRLIB_arsenal_items pushBackUnique _x;} forEach MSL_import_goggles;
diag_log format ["[MSL IMPORT] weapons=%1 items=%2 magazines=%3 backpacks=%4", count GRLIB_arsenal_weapons, count GRLIB_arsenal_items, count GRLIB_arsenal_magazines, count GRLIB_arsenal_backpacks];
