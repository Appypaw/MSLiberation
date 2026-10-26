// Server-local read-only preflight against the actually loaded mod configuration.
if (!isServer || {isRemoteExecuted}) exitWith {};
private _missing = [];
private _classes = militia_squad + KPLIB_o_inf_classes + opfor_vehicles + opfor_vehicles_low_intensity + opfor_battlegroup_vehicles + opfor_battlegroup_vehicles_low_intensity + opfor_choppers + opfor_air;
{if (!isClass (configFile >> "CfgVehicles" >> _x)) then {_missing pushBackUnique _x;};} forEach _classes;
{diag_log format ["[MSL PREFLIGHT MISSING VEHICLE/UNIT] %1", _x];} forEach _missing;
{
    _x params ["_label","_pool"];
    private _valid = _pool select {isClass (configFile >> "CfgVehicles" >> _x)};
    diag_log format ["[MSL PREFLIGHT] %1: %2", _label, _valid];
} forEach [["CAS",MSL_airCAS],["CAP",MSL_airCAP],["TRANSPORT",MSL_transportHelos],["SUPPLY",MSL_supplyPlaneCandidates]];
diag_log format ["[MSL PREFLIGHT] free kits=%1; market classes=%2; tower sites=%3; air spawns=%4", count MSL_freeKits, count MSL_shopClasses, count sectors_tower, count sectors_airspawn];
systemChat format ["MSL preflight: %1 missing configured unit/vehicle classes. See RPT.", count _missing];
