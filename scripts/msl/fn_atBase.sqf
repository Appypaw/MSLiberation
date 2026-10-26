params [["_unit", objNull, [objNull]]];
if (isNull _unit || {!alive _unit} || {getPosATL _unit select 2 > 10}) exitWith {false};
private _cached = _unit getVariable ["MSL_baseCheck", []];
if (!isServer && {!(_cached isEqualTo [])} && {diag_tickTime < (_cached select 0)}) exitWith {_cached select 1};
private _near = (getMarkerColor GRLIB_respawn_marker != "") && {_unit distance2D ([] call MSL_fnc_basePosition) < 100};
{if (_unit distance2D _x < 50) exitWith {_near = true;};} forEach (missionNamespace getVariable ["GRLIB_all_fobs", []]);
if (!isServer) then {_unit setVariable ["MSL_baseCheck", [diag_tickTime + 0.5, _near]];};
_near
