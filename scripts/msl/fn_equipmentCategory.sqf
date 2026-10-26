// Stable catalog grouping; cached because large mod catalogs have many variants.
params ["_entry"];
_entry params ["_class","_name","_price","_level","_kind"];
private _key = "MSL_category_" + _class;
private _cached = missionNamespace getVariable [_key,""];
if (_cached != "") exitWith {_cached};
private _category = "gear";
if (_kind == "weapon") then {
    _category = switch ((_class call BIS_fnc_itemType) param [1,""]) do {
        case "AssaultRifle": {"rifle"};
        case "Rifle": {"rifle"};
        case "SubmachineGun": {"smg"};
        case "MachineGun": {"mg"};
        case "SniperRifle": {"sniper"};
        case "Handgun": {"pistol"};
        case "Shotgun": {"shotgun"};
        default {"launcher"};
    };
};
if (_kind == "magazine") then {
    _category = "magazine";
    private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _class >> "ammo");
    if (toLower getText (_ammo >> "simulation") in ["shotgrenade","shotmine","shotdirectionalbomb","shotboundingmine","shotpipebomb","shotexplosive"]) then {_category = "explosive";};
};
if (_kind == "item" && {getNumber (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "type") in [101,201,301,302]}) then {_category = "attachment";};
missionNamespace setVariable [_key,_category];
_category
