if (!hasInterface || {isRemoteExecuted}) exitWith {};
params [["_mode","progress"]];
if (_mode == "buy") exitWith {[] call MSL_fnc_arsenal;};
if (_mode == "sell" && {!([player] call MSL_fnc_atBase)}) exitWith {systemChat "보급소 또는 본진에서 이용하세요.";};
if (_mode == "transfer" && {!([player] call MSL_fnc_atTerminal)}) exitWith {systemChat "송금은 본진 단말기에서만 이용할 수 있습니다.";};
disableSerialization;
if (dialog || {!isNull (uiNamespace getVariable ["MSL_shopDisplay",displayNull])}) exitWith {};
private _d = findDisplay 46 createDisplay "RscDisplayEmpty";
uiNamespace setVariable ["MSL_shopDisplay",_d];
_d setVariable ["MSL_mode",_mode];
private _level = (([(player getVariable ["MSL_stats",[0,0]]) select 1] call MSL_fnc_progress) select 0);
_d setVariable ["MSL_browserPage",0];
_d setVariable ["MSL_make",{
    params ["_d","_class","_id","_rect",["_text",""],["_color",[1,1,1,1]]];
    private _c = _d ctrlCreate [_class,_id];
    _rect params ["_x","_y","_w","_h"];
    _c ctrlSetPosition [safeZoneX + safeZoneW * (0.08 + 0.84 * _x),safeZoneY + safeZoneH * (0.08 + 0.84 * _y),safeZoneW * 0.84 * _w,safeZoneH * 0.84 * _h];
    _c ctrlSetText _text; _c ctrlSetTextColor _color;
    if (_class in ["RscText","RscButton","RscEdit","RscCombo","RscListbox"]) then {_c ctrlSetFontHeight (safeZoneH * 0.84 * 0.025);};
    if (_class == "RscButton") then {_c ctrlSetBackgroundColor [0.08,0.11,0.14,1];};
    _c ctrlCommit 0; _c
}];
private _mk = _d getVariable "MSL_make";
private _bg = [_d,"RscText",8000,[0,0,1,1]] call _mk; _bg ctrlSetBackgroundColor [0.012,0.019,0.027,0.99];
private _rail = [_d,"RscText",8001,[0,0,0.19,1]] call _mk; _rail ctrlSetBackgroundColor [0.03,0.046,0.058,1];
[_d,"RscText",8002,[0.025,0.025,0.17,0.055],"FIELDNET",[0.86,0.72,0.43,1]] call _mk;
[_d,"RscText",8003,[0.025,0.09,0.16,0.04],"개인 / 분대 태블릿",[0.5,0.6,0.66,1]] call _mk;
[_d,"RscText",8004,[0.22,0.02,0.73,0.065],"",[0.94,0.95,0.92,1]] call _mk;
[_d,"RscText",8005,[0.22,0.09,0.73,0.045],"",[0.55,0.65,0.69,1]] call _mk;
private _line = [_d,"RscText",8006,[0.22,0.15,0.73,0.003]] call _mk; _line ctrlSetBackgroundColor [0.79,0.63,0.32,1];
{
    _x params ["_label","_tab"];
    private _b = [_d,"RscButton",8010 + _forEachIndex,[0.02,0.21 + _forEachIndex * 0.095,0.15,0.065],_label] call _mk;
    _b setVariable ["MSL_tab",_tab];
    if (_tab == "transfer" && {!([player] call MSL_fnc_atTerminal)}) then {_b ctrlEnable false;};
    _b ctrlAddEventHandler ["ButtonClick",{
        private _b = _this select 0; private _d = ctrlParent _b;
        if ((_b getVariable "MSL_tab") == "buy") exitWith {_d closeDisplay 1; [] call MSL_fnc_arsenal;};

        _d setVariable ["MSL_mode",_b getVariable "MSL_tab"];
        [_d] call MSL_fnc_terminalRender;
    }];
} forEach [["장비 도감","progress"],["무기고","buy"],["장비 판매","sell"],["지원 요청","support"],["아군 송금","transfer"]];
[_d,"RscText",8020,[0.025,0.78,0.15,0.05],"SECURE / ONLINE",[0.42,0.75,0.63,1]] call _mk;
private _close = [_d,"RscButton",8021,[0.02,0.89,0.15,0.06],"태블릿 닫기"] call _mk;
_close ctrlAddEventHandler ["ButtonClick",{(ctrlParent (_this select 0)) closeDisplay 1;}];
[_d] call MSL_fnc_terminalRender;
[_d] spawn {
    disableSerialization; params ["_d"];
    while {!isNull _d} do {
        if (!alive player || {(_d getVariable ["MSL_mode",""]) == "sell" && {!([player] call MSL_fnc_atBase)}} || {(_d getVariable ["MSL_mode",""]) == "transfer" && {!([player] call MSL_fnc_atTerminal)}}) exitWith {_d closeDisplay 2;};
        private _stats = player getVariable ["MSL_stats",[0,0,0,0,0,0]];
        (_d displayCtrl 8005) ctrlSetText format ["%1   /   잔고 $%2   /   %3",name player,_stats select 0,["FIELD SUPPLY","BASE NETWORK"] select ([player] call MSL_fnc_atTerminal)];
        { _x ctrlEnable ([player] call MSL_fnc_canRequestSupport); } forEach ((_d getVariable ["MSL_body",[]]) select {!((_x getVariable ["MSL_supportRequest",[]]) isEqualTo [])});
        private _mode = _d getVariable ["MSL_mode", ""];
        private _signature = str (if (_mode == "progress") then {[_stats,player getVariable ["MSL_dogtags",0]]} else {
            [_mode, _stats select 0, ([_stats select 1] call MSL_fnc_progress) select 0, player getVariable ["MSL_sellCredits",[]]]
        });
        if (_signature != (_d getVariable ["MSL_signature",_signature])) then {
            _d setVariable ["MSL_signature",_signature];
            if ((_d getVariable ["MSL_mode",""]) in ["progress","buy","sell"]) then {[_d] call MSL_fnc_terminalRender;};
        };
        _d setVariable ["MSL_signature",_signature];
        sleep 0.5;
    };
};
