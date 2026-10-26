// The server sends a complete inventory, never executable client-supplied code.
if (!hasInterface || {!isRemoteExecuted} || {remoteExecutedOwner != 2}) exitWith {};
params ["_unit", "_loadout", "_token"];
if (_unit != player || {!local _unit} || {!alive _unit}) exitWith {};
if (!isNull findDisplay 602) then {(findDisplay 602) closeDisplay 2;};
_unit setUnitLoadout [_loadout, false];
[_unit, "ack", [_token]] remoteExecCall ["MSL_fnc_request", 2];
