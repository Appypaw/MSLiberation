if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal", false])} && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}}) exitWith {};
params ["_unit", ["_message", ""]];
private _a = [getPlayerUID _unit] call MSL_fnc_account;
_unit setVariable ["MSL_dogtags",_a param [10,0],true];
_unit setVariable ["MSL_sellCredits",_a select 8,true];
_unit setVariable ["MSL_stats", _a select [1, 6], true];
if (_message != "") then {[_message] remoteExecCall ["systemChat", owner _unit];};
