// Recheck the selected live group; UI enablement alone does not grant permission.
if (!hasInterface || {isRemoteExecuted} || {!alive player}) exitWith {};
disableSerialization;
params ["_d","_operation"];
if (!([player] call MSL_fnc_canRequestSupport)) exitWith {};
if (isNull _d || {(_d getVariable ["MSL_commandPage",""]) != "groups"} || {(_d getVariable ["MSL_mode",""]) != "command"} || {_d getVariable ["MSL_groupBusy",false]} || {!(missionNamespace getVariable ["KPPLM_CBA",false])} || {!(missionNamespace getVariable ["KP_liberation_playermenu",false])}) exitWith {};
private _tell = {
    params ["_ko","_en"];
    _d setVariable ["MSL_groupMessage",[_ko,_en]];
    (_d getVariable ["MSL_groupStatus",controlNull]) ctrlSetText ([_ko,_en] call MSL_fnc_text);
};
private _group = grpNull;
if (_operation in ["join","rename"]) then {
    private _list = _d getVariable ["MSL_groupList",controlNull];
    private _groups = _list getVariable ["MSL_groups",[]];
    private _index = lbCurSel _list;
    if (_index >= 0 && {_index < count _groups}) then {_group = _groups select _index;};
};
if (_operation == "rename") exitWith {
    if (isNull _group || {leader _group != player}) exitWith {(["본인 분대의 분대장만 이름을 변경할 수 있습니다.","Only the leader can rename their own group."]) call _tell;};
    private _name = ctrlText (_d getVariable ["MSL_groupName",controlNull]);
    if (count _name > 32 || {(toArray _name) findIf {_x > 32} < 0}) exitWith {(["분대 이름을 1~32자로 입력하세요.","Enter a group name of 1–32 characters."]) call _tell;};
    _group setGroupIdGlobal [_name];
    _d setVariable ["MSL_groupMessage",["분대 이름을 변경했습니다.","Group renamed."]];
    [_d] call MSL_fnc_terminalRender;
};
if (_operation == "create") then {_group = createGroup [side group player,true];};
if !(_operation in ["join","create"]) exitWith {};
if (isNull _group || {side _group != side group player} || {_operation == "join" && {!isPlayer leader _group}}) exitWith {(["분대가 변경되었습니다. 새로고침 후 다시 선택하세요.","Group changed. Refresh and select it again."]) call _tell;};
_d setVariable ["MSL_groupBusy",true];
[player] join _group;
[_d,_group,player] spawn {
    disableSerialization;
    params ["_d","_group","_unit"];
    private _timeout = diag_tickTime + 5;
    waitUntil {sleep 0.1; isNull _d || {player != _unit} || {!alive _unit} || {group _unit == _group} || {diag_tickTime >= _timeout}};
    if (!isNull _d) then {
        _d setVariable ["MSL_groupBusy",false];
        _d setVariable ["MSL_groupMessage",if (group _unit == _group) then {["분대 참가를 완료했습니다.","Joined the group."]} else {["분대 참가를 확인하지 못했습니다. 새로고침하세요.","Group join not confirmed. Refresh the list."]}];
        if ((_d getVariable ["MSL_mode",""]) == "command" && {(_d getVariable ["MSL_commandPage",""]) == "groups"}) then {[_d] call MSL_fnc_terminalRender;};
    };
};
