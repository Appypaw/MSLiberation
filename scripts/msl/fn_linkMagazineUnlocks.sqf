// Derive ammunition unlocks from server-owned weapon configs and catalog levels.
// Preserve ammunition prices; only the ordinary default magazine follows each weapon.
if (!isServer || {isRemoteExecuted}) exitWith {};
MSL_magazineUnlocks = [];
private _weapons = MSL_shopEntries select {(_x select 4) == "weapon"};
// Indexed lookups avoid scanning the full 12,000-entry catalog per magazine.
{
    if ((_x select 4) == "magazine") then {
        private _name = toLower (_x select 0);
        missionNamespace setVariable ["MSL_magAllowed_" + _name,true];
        missionNamespace setVariable ["MSL_magWeaponLevel_" + _name,-1];
        missionNamespace setVariable ["MSL_magBasicLevel_" + _name,-1];
    };
} forEach MSL_shopEntries;
{
    private _weapon = _x select 0;
    private _level = _x select 3;
    private _compatible = (compatibleMagazines _weapon) apply {toLower _x};
    {
        private _mag = _x;
        private _key = "MSL_magWeaponLevel_" + _mag;
        private _previous = missionNamespace getVariable [_key,-1];
        missionNamespace setVariable [_key,if (_previous < 0) then {_level} else {_previous min _level}];
    } forEach _compatible;
    // Prefer config's first ordinary main-muzzle magazine, then magazine-well entries.
    private _cfg = configFile >> "CfgWeapons" >> _weapon;
    private _muzzles = getArray (_cfg >> "muzzles");
    private _muzzle = _muzzles param [0,"this"];
    if ("this" in _muzzles) then {_muzzle = "this";};
    private _mainCfg = if (_muzzle == "this") then {_cfg} else {_cfg >> _muzzle};
    private _main = (compatibleMagazines [_weapon,_muzzle]) apply {toLower _x};
    private _candidates = (getArray (_mainCfg >> "magazines")) apply {toLower _x};
    {_candidates pushBackUnique _x;} forEach _main;
    _candidates = _candidates select {
        private _name = _x;
        private _mc = configFile >> "CfgMagazines" >> _name;
        _name in _main && {missionNamespace getVariable ["MSL_magAllowed_" + _name,false]}
    };
    private _ordinary = _candidates select {
        private _mc = configFile >> "CfgMagazines" >> _x;
        private _ac = configFile >> "CfgAmmo" >> getText (_mc >> "ammo");
        getNumber (_mc >> "tracersEvery") == 0 && {getNumber (_ac >> "indirectHit") == 0} && {getNumber (_ac >> "explosive") == 0} && {toLower getText (_ac >> "simulation") == "shotbullet"} && {private _n = _x; ["_ap","_api","_apds","_m993","_m995","_mk211","tracer"] findIf {(_n find _x) >= 0} < 0}
    };
    // Non-bullet weapons retain their configured default round as their basic ammunition.
    private _basic = if (_ordinary isEqualTo []) then {_candidates param [0,""]} else {_ordinary select 0};
    // Prefer the smallest ordinary magazine over larger-capacity variants.
    {
        if (getNumber (configFile >> "CfgMagazines" >> _x >> "count") < getNumber (configFile >> "CfgMagazines" >> _basic >> "count")) then {_basic = _x;};
    } forEach _ordinary;
    if (_basic != "") then {
        private _key = "MSL_magBasicLevel_" + _basic;
        private _previous = missionNamespace getVariable [_key,-1];
        missionNamespace setVariable [_key,if (_previous < 0) then {_level} else {_previous min _level}];
        diag_log format ["[MSL BASIC MAG] weapon=%1 level=%2 magazine=%3",_weapon,_level,_basic];
    } else {diag_log format ["[MSL BASIC MAG MISSING] weapon=%1",_weapon];};
} forEach _weapons;
{
    if ((_x select 4) == "magazine") then {
        private _name = toLower (_x select 0);
        private _level = _x select 3;
        private _weaponLevel = missionNamespace getVariable ["MSL_magWeaponLevel_" + _name,-1];
        if (_weaponLevel >= 0) then {_level = _level max _weaponLevel;};
        private _basicLevel = missionNamespace getVariable ["MSL_magBasicLevel_" + _name,-1];
        if (_basicLevel >= 0) then {_level = _level min _basicLevel;};
        _x set [3,_level];
        MSL_magazineUnlocks pushBack [_name,_level];
    };
} forEach MSL_shopEntries;
publicVariable "MSL_magazineUnlocks";
