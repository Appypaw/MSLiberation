// Tablet controls backed by the existing KPPLM client settings/profile schema.
if (!hasInterface || {isRemoteExecuted}) exitWith {};
disableSerialization;
params ["_d","_mk","_button"];
(_d displayCtrl 8004) ctrlSetText (["플레이어 설정","Player settings"] call MSL_fnc_text);
["RscText",[0.23,0.19,0.71,0.05],(["개인 화면과 음향 설정","Personal display and audio"] call MSL_fnc_text)] call _mk;
["RscText",[0.23,0.27,0.34,0.045],(["시야 거리 / 미터","View distance / meters"] call MSL_fnc_text)] call _mk;
private _distances = [];
{
    _x params ["_label","_value"];
    private _y = 0.33 + _forEachIndex * 0.075;
    ["RscText",[0.23,_y,0.17,0.055],_label] call _mk;
    private _input = ["RscEdit",[0.41,_y,0.17,0.055],str _value] call _mk;
    _input ctrlSetTooltip (["미터 단위 · 0은 기본값 1600m로 적용됩니다.","Meters · Enter 0 for the default 1600 m."] call MSL_fnc_text);
    _distances pushBack _input;
} forEach [
    [(["보병","On foot"] call MSL_fnc_text),KPPLM_viewFoot],
    [(["차량 / 함정","Land / Sea"] call MSL_fnc_text),KPPLM_viewVeh],
    [(["항공기","Aircraft"] call MSL_fnc_text),KPPLM_viewAir]
];
private _choices = [];
{
    _x params ["_label","_options","_selected"];
    private _y = 0.27 + _forEachIndex * 0.13;
    ["RscText",[0.62,_y,0.32,0.045],_label] call _mk;
    private _combo = ["RscCombo",[0.62,_y + 0.055,0.32,0.055]] call _mk;
    {_combo lbAdd (_x call MSL_fnc_text);} forEach _options;
    _combo lbSetCurSel _selected;
    _choices pushBack _combo;
} forEach [
    [(["지형 상세도","Terrain detail"] call MSL_fnc_text),[["낮음","Low"],["표준","Standard"],["높음","High"],["매우 높음","Very high"],["최고","Ultra"]],KPPLM_terrain],
    [(["자동 3인칭","Auto third person"] call MSL_fnc_text),[["사용 안 함","Disabled"],["항공기","Aircraft"],["지상 / 함정","Land / Sea"],["모든 차량","All vehicles"]],KPPLM_tpv],
    [(["무전 음성 숨기기","Suppress radio chatter"] call MSL_fnc_text),[["숨기지 않음","Keep all"],["음성만 숨김","Hide voices"],["전체 숨김","Hide all"]],KPPLM_radio]
];
["RscText",[0.23,0.58,0.35,0.045],(["차량 내 음량","In-vehicle volume"] call MSL_fnc_text)] call _mk;
private _sound = ["RscXSliderH",[0.23,0.645,0.28,0.045]] call _mk;
private _value = ["RscText",[0.52,0.64,0.075,0.05],format ["%1%2",round (KPPLM_soundVeh * 100),"%"]] call _mk;
_sound sliderSetRange [0,100]; _sound sliderSetSpeed [1,1]; _sound sliderSetPosition (KPPLM_soundVeh * 100);
_sound setVariable ["MSL_value",_value];
_sound ctrlAddEventHandler ["SliderPosChanged",{
    params ["_slider","_position"];
    (_slider getVariable "MSL_value") ctrlSetText format ["%1%2",round _position,"%"];
}];
_d setVariable ["MSL_settingsControls",[_distances,_choices,_sound]];
[[0.23,0.77,0.71,0.07],(["적용 및 저장","Apply and save"] call MSL_fnc_text),{[ctrlParent (_this select 0)] call MSL_fnc_savePlayerSettings;}] call _button;
private _status = ["RscText",[0.23,0.855,0.71,0.045],""] call _mk;
_d setVariable ["MSL_settingsStatus",_status];
["RscText",[0.23,0.92,0.71,0.045],(["기존 KP 설정에 저장 · 3인칭은 서버 난이도 설정을 따릅니다.","Uses your KP profile · Third person follows server difficulty."] call MSL_fnc_text),[0.62,0.65,0.71,1]] call _mk;
