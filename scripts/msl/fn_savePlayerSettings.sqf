if (!hasInterface || {isRemoteExecuted} || {!alive player}) exitWith {};
disableSerialization;
params ["_d"];
if (isNull _d || {(_d getVariable ["MSL_mode",""]) != "settings"} || {!(missionNamespace getVariable ["KPPLM_CBA",false])} || {!(missionNamespace getVariable ["KP_liberation_playermenu",false])}) exitWith {};
private _controls = _d getVariable ["MSL_settingsControls",[]];
if (count _controls != 3) exitWith {};
_controls params ["_distances","_choices","_sound"];
private _values = _distances apply {
    private _value = round parseNumber ctrlText _x;
    if (_value == 0) then {1600} else {_value}
};
private _indices = _choices apply {lbCurSel _x};
private _status = _d getVariable ["MSL_settingsStatus",controlNull];
if (_values findIf {!finite _x || {_x < 0}} >= 0 || {!((_indices select 0) in [0,1,2,3,4])} || {!((_indices select 1) in [0,1,2,3])} || {!((_indices select 2) in [0,1,2])}) exitWith {
    _status ctrlSetText (["시야 거리는 양수로 입력하세요. 0은 기본값으로 적용됩니다.","Use positive view distances, or 0 for the default."] call MSL_fnc_text);
};
KPPLM_viewFoot = _values select 0;
KPPLM_viewVeh = _values select 1;
KPPLM_viewAir = _values select 2;
KPPLM_terrain = _indices select 0;
KPPLM_tpv = _indices select 1;
KPPLM_radio = _indices select 2;
KPPLM_soundVeh = ((round sliderPosition _sound) / 100) max 0 min 1;
profileNamespace setVariable ["KPPLM_Settings",[KPPLM_viewFoot,KPPLM_viewVeh,KPPLM_viewAir,KPPLM_terrain,KPPLM_tpv,KPPLM_radio,KPPLM_soundVeh]];
saveProfileNamespace;
[] call KPPLM_fnc_apply;
_status ctrlSetText (["설정을 적용하고 저장했습니다.","Settings applied and saved."] call MSL_fnc_text);
