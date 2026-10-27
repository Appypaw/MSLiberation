if (!hasInterface || {isRemoteExecuted}) exitWith {};
params [["_mode","overview"]];
private _commandPage = if (_mode == "groups") then {"groups"} else {"supply"};
if (_mode in ["support","groups"]) then {_mode = "command";};
if (_mode == "buy") exitWith {[] call MSL_fnc_arsenal;};
if (_mode == "sell" && {!([player] call MSL_fnc_atBase)}) exitWith {systemChat (["보급소 또는 본진에서 이용하세요.","Available at base or an FOB supply point."] call MSL_fnc_text);};
if (_mode == "transfer" && {!([player] call MSL_fnc_atTerminal)}) exitWith {systemChat (["송금은 본진 단말기에서만 이용할 수 있습니다.","Transfers are available at the main base terminal."] call MSL_fnc_text);};
disableSerialization;
if (dialog || {!isNull (uiNamespace getVariable ["MSL_shopDisplay",displayNull])}) exitWith {};
private _d = findDisplay 46 createDisplay "RscDisplayEmpty";
uiNamespace setVariable ["MSL_shopDisplay",_d];
_d setVariable ["MSL_mode",_mode];
_d setVariable ["MSL_commandPage",_commandPage];
// Physical 3:2 tablet, sized by height rather than monitor width (21:9 / 32:9 safe).
private _frameH = safeZoneH * 0.78;
private _frameW = _frameH * 1.5 * pixelW / pixelH;
if (_frameW > safeZoneW * 0.92) then {
    _frameW = safeZoneW * 0.92;
    _frameH = _frameW / 1.5 * pixelH / pixelW;
};
private _frameX = safeZoneX + (safeZoneW - _frameW) / 2;
private _frameY = safeZoneY + (safeZoneH - _frameH) / 2;
_d setVariable ["MSL_frame",[_frameX,_frameY,_frameW,_frameH]];
// Inset to match the generated bezel's actual black display aperture.
_d setVariable ["MSL_layout",[_frameX + _frameW * 0.08,_frameY + _frameH * 0.11,_frameW * 0.84,_frameH * 0.78]];
_d setVariable ["MSL_browserPage",0];
_d setVariable ["MSL_make",{
    params ["_d","_class","_id","_rect",["_text",""],["_color",[1,1,1,1]]];
    private _c = _d ctrlCreate [_class,_id];
    _rect params ["_x","_y","_w","_h"];
    (_d getVariable "MSL_layout") params ["_left","_top","_width","_height"];
    _c ctrlSetPosition [_left + _width * _x,_top + _height * _y,_width * _w,_height * _h];
    _c ctrlSetText _text; _c ctrlSetTextColor _color;
    if (_class in ["RscText","RscStructuredText","RscButton","RscEdit","RscCombo","RscListbox"]) then {_c ctrlSetFontHeight (_height * 0.031);};
    if (_class in ["RscEdit","RscCombo","RscListbox"]) then {_c ctrlSetBackgroundColor [0.10,0.11,0.135,1];};
    if (_class == "RscButton") then {
        _c ctrlSetBackgroundColor [0.12,0.13,0.16,1];
        _c ctrlAddEventHandler ["MouseEnter",{(_this select 0) ctrlSetBackgroundColor [0.12,0.27,0.46,1];}];
        _c ctrlAddEventHandler ["MouseExit",{
            private _c = _this select 0;
            _c ctrlSetBackgroundColor (_c getVariable ["MSL_idleColor",[0.12,0.13,0.16,1]]);
        }];
    };
    _c ctrlCommit 0; _c
}];
private _mk = _d getVariable "MSL_make";
private _bezel = _d ctrlCreate ["RscPicture",7999];
_bezel ctrlSetPosition (_d getVariable "MSL_frame");
_bezel ctrlSetText "res\tablet\fieldnet_tablet_v2_ca.paa";
_bezel ctrlCommit 0;
private _bg = [_d,"RscText",8000,[0,0,1,1]] call _mk; _bg ctrlSetBackgroundColor [0.055,0.06,0.075,1];
_d displayAddEventHandler ["KeyDown",{
    params ["_display","_key"];
    if (_key == 1) exitWith {_display closeDisplay 2; true};
    false
}];
_d displayAddEventHandler ["Unload",{uiNamespace setVariable ["MSL_shopDisplay",displayNull];}];
private _rail = [_d,"RscText",8001,[0,0,0.19,1]] call _mk; _rail ctrlSetBackgroundColor [0.075,0.08,0.095,1];
[_d,"RscText",8002,[0.025,0.025,0.17,0.055],"Fieldnet",[0.94,0.95,0.98,1]] call _mk;
[_d,"RscText",8003,[0.025,0.09,0.16,0.04],(["개인 태블릿","Personal tablet"] call MSL_fnc_text),[0.5,0.6,0.66,1]] call _mk;
[_d,"RscText",8004,[0.23,0.025,0.71,0.06],"",[0.94,0.95,0.98,1]] call _mk;
[_d,"RscText",8005,[0.22,0.09,0.73,0.045],"",[0.55,0.65,0.69,1]] call _mk;
private _line = [_d,"RscText",8006,[0.23,0.15,0.71,0.001]] call _mk; _line ctrlSetBackgroundColor [0.18,0.19,0.22,1];
{
    _x params ["_label","_tab"];
    private _b = [_d,"RscButton",8010 + _forEachIndex,[0.02,0.18 + _forEachIndex * 0.069,0.15,0.059],_label] call _mk;
    _b setVariable ["MSL_tab",_tab];
    _b ctrlSetTooltip (switch (_tab) do {
        case "buy": {(["본진 / FOB에서 장비를 선택하고 수령합니다.","Select and collect equipment at base or an FOB."] call MSL_fnc_text)};
        case "sell": {(["본진 / FOB에서 구매·노획 장비를 정산합니다.","Sell purchased or captured equipment at base or an FOB."] call MSL_fnc_text)};
        case "transfer": {(["본진에서 접속 중인 아군에게 송금합니다.","Transfer funds to online allies at the main base."] call MSL_fnc_text)};
        default {""};
    });
    _b ctrlAddEventHandler ["ButtonClick",{
        private _b = _this select 0; private _d = ctrlParent _b;
        if ((_b getVariable "MSL_tab") == "command" && {!([player] call MSL_fnc_canRequestSupport)}) exitWith {};
        if ((_b getVariable "MSL_tab") == "buy") exitWith {_d closeDisplay 1; [] call MSL_fnc_arsenal;};

        _d setVariable ["MSL_mode",_b getVariable "MSL_tab"];
        [_d] call MSL_fnc_terminalRender;
    }];
} forEach [[(["요약","Overview"] call MSL_fnc_text),"overview"],[(["개인 기록","Career"] call MSL_fnc_text),"career"],[(["장비 도감","Catalog"] call MSL_fnc_text),"progress"],[(["무기고","Arsenal"] call MSL_fnc_text),"buy"],[(["장비 판매","Sell gear"] call MSL_fnc_text),"sell"],[(["분대 지휘","Command"] call MSL_fnc_text),"command"],[(["아군 송금","Transfers"] call MSL_fnc_text),"transfer"],[(["설정","Settings"] call MSL_fnc_text),"settings"]];
[_d,"RscText",8020,[0.025,0.745,0.15,0.035],(["연결됨","Connected"] call MSL_fnc_text),[0.62,0.65,0.71,1]] call _mk;
// Local profile setting: choosing English never changes another player's UI.
private _language = [_d,"RscCombo",8023,[0.02,0.805,0.15,0.05]] call _mk;
_language lbAdd "한국어";
_language lbAdd "English";
_language ctrlSetTooltip "언어 / Language";
_language lbSetCurSel ([0,1] select ((profileNamespace getVariable ["MSL_language","ko"]) == "en"));
_language ctrlAddEventHandler ["LBSelChanged",{
    params ["_control","_index"];
    if !(_index in [0,1]) exitWith {};
    private _language = ["ko","en"] select _index;
    profileNamespace setVariable ["MSL_language",_language];
    saveProfileNamespace;
    player setVariable ["MSL_language",_language,true];
    {
        _x params ["_id","_ko","_en"];
        player setUserActionText [_id,[_ko,_en] call MSL_fnc_text];
    } forEach (player getVariable ["MSL_actionLabels",[]]);
    [ctrlParent _control] call MSL_fnc_terminalRender;
}];
private _close = [_d,"RscButton",8021,[0.02,0.89,0.15,0.06],(["닫기","Close"] call MSL_fnc_text)] call _mk;
_close ctrlAddEventHandler ["ButtonClick",{(ctrlParent (_this select 0)) closeDisplay 1;}];
private _home = [_d,"RscText",8022,[0.455,0.985,0.09,0.004]] call _mk;
_home ctrlSetBackgroundColor [0.55,0.57,0.62,1];
[_d] call MSL_fnc_terminalRender;
[_d] spawn {
    disableSerialization; params ["_d"];
    while {!isNull _d} do {
        if (!alive player) exitWith {_d closeDisplay 2;};
        private _stats = player getVariable ["MSL_stats",[0,0,0,0,0,0]];
        (_d displayCtrl 8005) ctrlSetText format ["%1  /  $%2  /  %3",name player,_stats select 0,[(["야전","Field"] call MSL_fnc_text),(["본진 연결","Base network"] call MSL_fnc_text)] select ([player] call MSL_fnc_atTerminal)];
        { _x ctrlEnable ([player] call MSL_fnc_canRequestSupport); } forEach ((_d getVariable ["MSL_body",[]]) select {!((_x getVariable ["MSL_supportRequest",[]]) isEqualTo [])});
        private _mode = _d getVariable ["MSL_mode", ""];
        private _signature = str [_mode,
            if (_mode in ["overview","career","progress"]) then {_stats} else {[_stats select 0]},
            if (_mode == "sell") then {player getVariable ["MSL_sellCredits",[]]} else {[]},
            [player] call MSL_fnc_atBase,[player] call MSL_fnc_atTerminal,[player] call MSL_fnc_canRequestSupport,
            missionNamespace getVariable ["MSL_ready",false]];
        if (_signature != (_d getVariable ["MSL_signature",_signature])) then {
            _d setVariable ["MSL_signature",_signature];
            if ((_d getVariable ["MSL_mode",""]) in ["overview","career","progress","buy","sell","command","transfer"]) then {[_d] call MSL_fnc_terminalRender;};
        };
        _d setVariable ["MSL_signature",_signature];
        sleep 0.5;
    };
};
