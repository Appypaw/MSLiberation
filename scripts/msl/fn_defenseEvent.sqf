// Server-owned, one active defense event, real enemy origins and bounded lifetime.
if (!isServer || {isRemoteExecuted}) exitWith {};
params ["_kind","_target","_pos"];
private _sector = _target;
private _valid = {
    if (_kind == "city") exitWith {_target in blufor_sectors};
    GRLIB_all_fobs findIf {_x distance2D _pos < 80} >= 0
};
if (!MSL_defenseEnabled || {missionNamespace getVariable ["MSL_defenseActive",false]} || {!(call _valid)}) exitWith {};
private _label = if (_kind == "city") then {markerText _target} else {"신설 FOB"};
private _sites = (sectors_military + sectors_capture + sectors_bigtown) select {
    !(_x in blufor_sectors) && {markerPos _x distance2D _pos > 1200} && {markerPos _x distance2D _pos < 6500}
};
_sites = _sites select {private _p = markerPos _x; allPlayers findIf {alive _x && {_x distance2D _p < 900}} < 0};
if (_sites isEqualTo []) exitWith {};
MSL_defenseActive = true;
MSL_nextScenario = time + MSL_scenarioCooldown;
private _hold = (MSL_defenseHoldRange select 0) + random ((MSL_defenseHoldRange select 1) - (MSL_defenseHoldRange select 0));
missionNamespace setVariable ["MSL_defenseCooldown_" + _sector,time + MSL_defenseSectorCooldown];
private _marker = createMarker ["MSL_defense_event",_pos];
_marker setMarkerType "mil_objective"; _marker setMarkerColor "ColorRed"; _marker setMarkerText "방어 작전 / 적 공격 준비";
private _notify = {
    params ["_text"];
    {if (isPlayer _x && {_x distance2D _pos < 1500}) then {[_text] remoteExecCall ["systemChat",owner _x];};} forEach allPlayers;
};
[format ["%1: 적 반격 징후. 60초 후부터 약 %2분간 거점을 유지하세요.",_label,ceil (_hold / 60)]] call _notify;
private _groups = [];
private _participants = []; // UID and seconds present, no rewards for transient arrivals.
private _wave = 0;
private _nextWave = time + 60;
private _holdStart = time + 60;
private _deadline = _holdStart + _hold;
private _lastPresence = time;
private _lastTick = time;
private _success = false;
while {time < _deadline && {call _valid} && {GRLIB_endgame == 0}} do {
    private _now = time;
    private _present = allPlayers select {alive _x && {side group _x == GRLIB_side_friendly} && {_x distance2D _pos < 600} && {getPosATL _x select 2 < 20}};
    if !(_present isEqualTo []) then {_lastPresence = _now;};
    if (_now - _lastPresence > 180) exitWith {};
    {
        private _uid = getPlayerUID _x;
        private _i = _participants findIf {(_x select 0) == _uid};
        if (_i < 0) then {_participants pushBack [_uid,0]; _i = count _participants - 1;};
        private _row = _participants select _i; _row set [1,(_row select 1) + (_now - _lastTick)];
    } forEach _present;
    _lastTick = _now;
    private _pressure = 0;
    {{if (alive _x && {!captive _x}) then {_pressure = _pressure + 1;};} forEach units _x;} forEach _groups;
    if (_pressure < MSL_defenseAliveLimit && {_now >= _nextWave} && {diag_fps > 15} && {[] call KPLIB_fnc_getOpforCap < GRLIB_battlegroup_cap}) then {
        private _origins = _sites select {!(_x in blufor_sectors)};
        _origins = _origins select {private _p = markerPos _x; allPlayers findIf {alive _x && {_x distance2D _p < 900}} < 0};
        if (_origins isEqualTo []) exitWith {_nextWave = _deadline + 1;};
        private _source = markerPos selectRandom _origins;
        private _g = createGroup [GRLIB_side_enemy,true];
        private _type = ["army","specops"] select (_wave >= 2 && {random 1 < 0.25});
        private _squad = [_type] call KPLIB_fnc_getSquadComp;
        private _amount = (ceil ((6 + count _present * 2) * ([] call MSL_fnc_supportFactor))) max 3 min 10;
        for "_i" from 1 to (_amount min (MSL_defenseAliveLimit - _pressure)) do {
            if ([] call KPLIB_fnc_getOpforCap < GRLIB_battlegroup_cap) then {[selectRandom _squad,_source,_g,"PRIVATE",15] call KPLIB_fnc_createManagedUnit;};
        };
        if (count units _g > 0) then {
            _groups pushBack _g;
            private _wp = _g addWaypoint [_pos,60]; _wp setWaypointType "SAD"; _wp setWaypointSpeed "FULL";
            if (_type == "specops") then {[_g,_pos] spawn MSL_fnc_specopsAI;};
            _wave = _wave + 1;
            [format ["%1: 적 증원 %2차 접근 중. 남은 방어 시간 %3초",_label,_wave,ceil (_deadline - time)]] call _notify;
            _marker setMarkerText format ["%1 방어 / %2분",_label,ceil ((_deadline - time) / 60)];
        } else {deleteGroup _g;};
        _nextWave = _now + (MSL_defenseWaveGap select 0) + random ((MSL_defenseWaveGap select 1) - (MSL_defenseWaveGap select 0));
    };
    private _alive = 0;
    {{if (alive _x && {!captive _x} && {!(_x getVariable ["ais_unconscious",false])} && {!(_x getVariable ["ACE_isUnconscious",false])}) then {_alive = _alive + 1;};} forEach units _x;} forEach _groups;
    _marker setMarkerText format ["%1 방어 / 남은 %2분",_label,ceil (((_deadline - time) max 0) / 60)];
    MSL_defenseState = [_sector,"HOLD",_wave,ceil ((_deadline - time) max 0),_alive]; publicVariable "MSL_defenseState";
    sleep (10 min ((_deadline - time) max 0.1));
};
_success = time >= _deadline && {call _valid} && {time - _lastPresence <= 30} && {GRLIB_endgame == 0} && {_wave > 0};
if (_success) then {
    {
        private _unit = _x; private _uid = getPlayerUID _unit;
        private _record = _participants select {(_x select 0) == _uid};
        if (alive _unit && {_unit distance2D _pos < 600} && {!(_record isEqualTo [])} && {((_record select 0) select 1) >= 120}) then {
            private _a = [_uid] call MSL_fnc_account;
            _a set [1,(_a select 1) + MSL_defenseCash]; _a set [2,(_a select 2) + MSL_defenseXP];
            [_unit,format ["방어 성공: $%1 / XP %2",MSL_defenseCash,MSL_defenseXP]] call MSL_fnc_publish;
        };
    } forEach allPlayers;
    [] call MSL_fnc_persist;
    ["거점 유지 완료. 적 공격 중단, 방어 작전 성공."] call _notify;
} else {["방어 작전 종료: 거점 상실·이탈·제한시간 또는 적 출발 거점 상실."] call _notify;};
MSL_defenseState = [_sector,["ENDED","SUCCESS"] select _success,_wave,0,0]; publicVariable "MSL_defenseState";
MSL_defenseActive = false;
deleteMarker _marker;
// Retreat survivors; do not delete units in front of players or keep an unbounded cleanup thread.
{
    private _g = _x;
    _g setVariable ["MSL_stopSpecops",true,true];
    if (!isNull _g && {count units _g > 0}) then {
        while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
        _g move (markerPos (_sites select 0));
        [_g] spawn {
            params ["_g"]; private _end = time + 1200;
            waitUntil {sleep 20; time > _end || {count units _g == 0} || {private _p = getPos leader _g; allPlayers findIf {_x distance2D _p < 1000} < 0}};
            if (count units _g == 0 || {private _p = getPos leader _g; allPlayers findIf {_x distance2D _p < 1000} < 0}) then {{deleteVehicle _x;} forEach units _g; deleteGroup _g;};
        };
    };
} forEach _groups;
