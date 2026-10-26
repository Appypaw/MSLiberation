// Clear all defenders, or maintain sector suppression before accepting residual stragglers.
params ["_sector", "_radius"];
private _pos = markerPos _sector;
_radius = _radius max MSL_captureClearanceRadius;
private _key = "MSL_hold_" + _sector;
private _able = {
    alive _x && {getPosATL _x select 2 < 80} && {!(vehicle _x isKindOf "Air") || {getPosATL vehicle _x select 2 < 10}} && {!captive _x} && {!(_x getVariable ["ACE_isUnconscious",false])} && {!(_x getVariable ["ais_unconscious",false])} && {lifeState _x != "INCAPACITATED"}
};
private _near = allUnits select {_x distance2D _pos < _radius && {call _able}};
private _friendly = _near select {side group _x == GRLIB_side_friendly};
private _enemy = _near select {side group _x == GRLIB_side_enemy};
private _core = _friendly select {_x distance2D _pos < MSL_captureCoreRadius};
private _coreEnemy = {_x distance2D _pos < MSL_captureCoreRadius} count _enemy;
private _armor = vehicles findIf {
    alive _x && {canMove _x || {canFire _x}} && {_x isKindOf "Tank" || {_x isKindOf "Wheeled_APC_F"}} && {_x distance2D _pos < _radius} && {crew _x findIf {side group _x == GRLIB_side_enemy && {call _able}} >= 0}
};
private _suppressed = !(_friendly isEqualTo []) && {count _enemy <= MSL_captureResidual} && {_armor < 0};
private _since = missionNamespace getVariable [_key + "_suppressed",-1];
if (!_suppressed) then {_since = -1;} else {if (_since < 0) then {_since = time;};};
missionNamespace setVariable [_key + "_suppressed",_since];
private _coreSince = missionNamespace getVariable [_key,-1];
if (!_suppressed || {_core isEqualTo []} || {_coreEnemy > 0}) then {_coreSince = -1;} else {if (_coreSince < 0) then {_coreSince = time;};};
missionNamespace setVariable [_key,_coreSince];
private _clear = count _enemy == 0;
private _secureTime = if (_since < 0) then {0} else {time - _since};
private _coreTime = if (_coreSince < 0) then {0} else {time - _coreSince};
if (!_suppressed) exitWith {false};
if (time >= (missionNamespace getVariable [_key + "_notice",0])) then {
    private _text = format ["%1 | 잔적 %2명 | 제압 유지 %3/%4초 | 중심 확보 %5/%6초",markerText _sector,count _enemy,floor _secureTime, [MSL_captureSuppression,0] select _clear,floor _coreTime,MSL_captureHold];
    {if (isPlayer _x) then {[_text] remoteExecCall ["systemChat",owner _x];};} forEach _friendly;
    missionNamespace setVariable [_key + "_notice",time + 20];
};
[count _enemy,_coreEnemy,!(_core isEqualTo []),_armor >= 0,_secureTime,_coreTime] call MSL_fnc_capturePolicy
