if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal", false])} && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}}) exitWith {};
params ["_unit", ["_force", false]];
private _a = [getPlayerUID _unit] call MSL_fnc_account;
private _p = _a param [9, []];
if (_p isEqualTo []) exitWith {};
if (!_force && {!(_unit getVariable ["MSL_ack", false])}) exitWith {};
// Acknowledgements alone never credit money: observe the authoritative proposed loadout.
if !((getUnitLoadout _unit) isEqualTo (_p select 2)) exitWith {};
_p params ["_token", "_started", "_new", "_delta", "_op", ["_class", ""]];
private _credits = _a select 8;
private _i = _credits findIf {(_x select 0) == _class};
if (_op == "free") then {_credits = [];};
if (_op == "buy") then {
    if (_i < 0) then {_credits pushBack [_class, 1];} else {(_credits select _i) set [1, ((_credits select _i) select 1) + 1];};
};
if (_op == "sell") then {
    if (_i >= 0) then {(_credits select _i) set [1, (((_credits select _i) select 1) - 1) max 0];};
    _a set [1, (_a select 1) + _delta];
    _a set [6, (_a select 6) + _delta];
};
_a set [8, _credits select {(_x select 1) > 0}];
_a set [7, _new]; _a set [9, []];
_unit setVariable ["MSL_pending", []]; _unit setVariable ["MSL_econBusy", false, true]; _unit setVariable ["MSL_ack", false];
[false] call MSL_fnc_persist;
[_unit, "장비 정산 완료"] call MSL_fnc_publish;
diag_log format ["[MSL TRANSACTION] %1 %2 %3 delta=%4", getPlayerUID _unit, _op, _class, _delta];
