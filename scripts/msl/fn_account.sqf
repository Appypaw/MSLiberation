// Server-only account lookup; schema [uid,cash,xp,kills,deaths,captures,sales,gear,credits].
if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal", false])} && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}}) exitWith {[]};
params ["_uid"];
if (_uid == "") exitWith {[]};
private _i = MSL_accounts findIf {(_x select 0) == _uid};
if (_i < 0) then {
    MSL_accounts pushBack [_uid, MSL_startingCash, 0, 0, 0, 0, 0, [], [], []];
    _i = (count MSL_accounts) - 1;
};
MSL_accounts select _i
