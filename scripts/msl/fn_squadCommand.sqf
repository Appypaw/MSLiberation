// One leader-only workspace for logistics requests and KP group management.
if (!hasInterface || {isRemoteExecuted}) exitWith {};
disableSerialization;
params ["_d","_mk","_button"];
(_d displayCtrl 8004) ctrlSetText (["분대 지휘","Squad command"] call MSL_fnc_text);
if (!([player] call MSL_fnc_canRequestSupport)) exitWith {
    ["RscText",[0.23,0.35,0.71,0.08],(["분대장만 지휘 기능을 사용할 수 있습니다.","Only the current squad leader can use command functions."] call MSL_fnc_text)] call _mk;
};
private _page = _d getVariable ["MSL_commandPage","supply"];
{
    _x params ["_label","_pageKey","_xPos"];
    private _tab = [[_xPos,0.19,0.34,0.065],_label,{
        if (!([player] call MSL_fnc_canRequestSupport)) exitWith {};
        private _control = _this select 0;
        private _d = ctrlParent _control;
        _d setVariable ["MSL_commandPage",_control getVariable "MSL_page"];
        [_d] call MSL_fnc_terminalRender;
    }] call _button;
    _tab setVariable ["MSL_page",_pageKey];
    if (_pageKey == _page) then {
        _tab setVariable ["MSL_idleColor",[0.12,0.27,0.46,1]];
        _tab ctrlSetBackgroundColor [0.12,0.27,0.46,1];
    };
} forEach [[(["보급 요청","Supply requests"] call MSL_fnc_text),"supply",0.23],[(["분대 관리","Group management"] call MSL_fnc_text),"groups",0.60]];
if (_page == "groups") exitWith {
    if (!(missionNamespace getVariable ["KPPLM_CBA",false]) || {!(missionNamespace getVariable ["KP_liberation_playermenu",false])}) exitWith {
        ["RscText",[0.23,0.35,0.71,0.08],(["이 미션에서 KP Player Menu가 활성화되어 있지 않습니다.","KP Player Menu is not enabled for this mission."] call MSL_fnc_text)] call _mk;
    };
    [_d,_mk,_button] call MSL_fnc_playerGroups;
};
["RscText",[0.23,0.30,0.71,0.05],(["보급 종류를 선택하세요.","Choose a supply type."] call MSL_fnc_text)] call _mk;
{
    _x params ["_label","_kind","_hint"];
    private _y = 0.40 + _forEachIndex * 0.15;
    private _request = [[0.23,_y,0.34,0.10],_label,{
        if (!([player] call MSL_fnc_canRequestSupport)) exitWith {};
        private _control = _this select 0;
        [player,"airdrop",[_control getVariable "MSL_supplyKind"]] remoteExecCall ["MSL_fnc_request",2];
        (ctrlParent _control) closeDisplay 1;
    }] call _button;
    _request setVariable ["MSL_supplyKind",_kind];
    _request setVariable ["MSL_supportRequest",["airdrop",[_kind]]];
    _request ctrlSetTooltip (["클릭하면 즉시 지원을 요청합니다.","Click to submit this support request."] call MSL_fnc_text);
    ["RscText",[0.60,_y,0.34,0.10],_hint,[0.62,0.65,0.71,1]] call _mk;
} forEach [
    [(["탄약 보급","Ammunition"] call MSL_fnc_text),"ammo",(["전투 탄약 보충","Resupply combat ammunition"] call MSL_fnc_text)],
    [(["의료품 보급","Medical supplies"] call MSL_fnc_text),"medical",(["의료 물자 보충","Resupply medical equipment"] call MSL_fnc_text)],
    [(["팀 자원 보급","Team resources"] call MSL_fnc_text),"resources",(["팀 공용 자원 보충","Resupply shared team resources"] call MSL_fnc_text)]
];
["RscText",[0.23,0.90,0.71,0.05],(["보급 요청 후 연막 / 야간 플레어로 위치를 표시하세요.","Mark the drop with smoke by day or flares at night."] call MSL_fnc_text),[0.62,0.65,0.71,1]] call _mk;
