if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal", false])} && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}}) exitWith {};
params ["_unit", ["_message", ""]];
private _a = [getPlayerUID _unit] call MSL_fnc_account;
{
    _x params ["_key", "_value"];
    if !((_unit getVariable [_key, []]) isEqualTo _value) then {
        _unit setVariable [_key, _value, true];
    };
} forEach [["MSL_dogtags", _a param [10,0]],
    ["MSL_sellCredits", (_a select 8) apply {+_x}],
    ["MSL_stats", _a select [1,6]]];
if (_message != "") then {[_message] remoteExecCall ["systemChat", owner _unit];};
