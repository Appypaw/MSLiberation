// Rear-area extraction. Players board a real helicopter; no teleport/eject shortcuts.
if (!isServer || {isRemoteExecuted}) exitWith {};
params ["_requester"];
if (isNull _requester || {!alive _requester} || {vehicle _requester != _requester}) exitWith {};
private _tell = {params ["_message"]; if (!isNull _requester && {isPlayer _requester}) then {[_message] remoteExecCall ["systemChat",owner _requester];};};
if (MSL_evacActive || {time < MSL_nextEvac}) exitWith {[format ["Evac 대기: %1초",ceil ((MSL_nextEvac - time) max 0)]] call _tell;};
private _requestPos = getPosATL _requester;
private _rear = true;
if ([_requester] call MSL_fnc_atBase) then {_rear = false;};
{if (!(_x in MSL_isolated) && {_requestPos distance2D markerPos _x < 1200}) exitWith {_rear = false;};} forEach blufor_sectors;
private _enemy = (sectors_capture + sectors_bigtown + sectors_military) select {!(_x in blufor_sectors) && {markerPos _x distance2D _requestPos < 2000}};
if (!_rear || {_enemy isEqualTo []}) exitWith {["후방 Evac은 적 지역 인근에서, 연결된 아군 지역과 본진을 벗어났을 때 요청할 수 있습니다."] call _tell;};
private _team = (units group _requester) select {alive _x && {side group _x == GRLIB_side_friendly} && {_x distance2D _requester < 250}};
private _pool = MSL_evacHelos select {isClass (configFile >> "CfgVehicles" >> _x) && {getNumber (configFile >> "CfgVehicles" >> _x >> "transportSoldier") >= count _team}};
if (_pool isEqualTo []) exitWith {["현재 분대를 수송할 수 있는 Evac 헬기가 없습니다. 분대 규모를 줄이거나 기체 설정을 확인하세요."] call _tell;};
private _lz = [_requestPos,20,180,12,0,0.25,0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
private _base = [] call MSL_fnc_basePosition;
private _baseLZ = [_base,0,200,12,0,0.25,0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
_lz set [2,0]; _baseLZ set [2,0];
if (_lz distance2D _requestPos > 200 || {_baseLZ distance2D _base > 250} || {surfaceIsWater _lz} || {surfaceIsWater _baseLZ}) exitWith {["안전한 착륙장을 찾지 못했습니다. 평탄하고 트인 곳으로 이동해 재요청하세요."] call _tell;};
MSL_evacActive = true; MSL_nextEvac = time + MSL_evacCooldown;
private _pads = [];
{private _pad = createVehicle ["Land_HelipadEmpty_F",_x,[],0,"CAN_COLLIDE"]; _pads pushBack _pad;} forEach [_lz,_baseLZ];
private _marker = createMarker ["MSL_evac_lz",_lz]; _marker setMarkerType "mil_pickup"; _marker setMarkerColor "ColorWEST"; _marker setMarkerText "EVAC / 착륙장 확보";
["후방 Evac 접수. 지도 착륙장을 확보하고 분대를 집결시키세요. 헬기 도착 후 직접 탑승해야 합니다."] call _tell;
private _delay = (MSL_evacApproachDelay select 0) + random ((MSL_evacApproachDelay select 1) - (MSL_evacApproachDelay select 0));
private _until = time + _delay;
waitUntil {sleep 2; time >= _until || {!alive _requester} || {GRLIB_endgame != 0}};
private _helicopter = objNull; private _crew = []; private _g = grpNull; private _returned = false;
if (alive _requester && {GRLIB_endgame == 0}) then {
    private _result = [_baseLZ vectorAdd [0,0,100],_baseLZ getDir _lz,_pool select 0,GRLIB_side_friendly] call BIS_fnc_spawnVehicle;
    _result params ["_helo","_pilots","_group"]; _helicopter = _helo; _crew = _pilots; _g = _group;
    _helo lockDriver true; _helo flyInHeight 100; _g setBehaviour "CARELESS"; _g setCombatMode "BLUE";
    {_x disableAI "AUTOTARGET";} forEach _crew;
    private _wp = _g addWaypoint [_lz,0]; _wp setWaypointType "MOVE"; _wp setWaypointCompletionRadius 100;
    private _arriveBy = time + MSL_evacFlightTimeout;
    ["Evac 이륙. 착륙장 주변을 방어하세요."] call _tell;
    [_lz,false,_helo,1,4] spawn MSL_fnc_investigate;
    waitUntil {sleep 2; _helo distance2D _lz < 250 || {!alive _helo} || {!alive driver _helo} || {time > _arriveBy} || {GRLIB_endgame != 0}};
    if (alive _helo && {alive driver _helo} && {_helo distance2D _lz < 250}) then {
        _helo land "GET IN";
        private _landBy = time + 120;
        waitUntil {sleep 1; !alive _helo || {!alive driver _helo} || {(_helo distance2D _lz < 80) && {getPosATL _helo select 2 < 3} && {abs speed _helo < 5}} || {time > _landBy}};
        if (alive _helo && {alive driver _helo} && {_helo distance2D _lz < 80} && {getPosATL _helo select 2 < 3}) then {
            _marker setMarkerText "EVAC / 탑승";
            [format ["헬기 착륙. %1초 이내 탑승하세요. 부상자와 분대원을 확인하세요.",MSL_evacBoardTime]] call _tell;
            {if (!isPlayer _x && {alive _x}) then {_x assignAsCargo _helo; [_x] orderGetIn true;};} forEach _team;
            private _boardBy = time + MSL_evacBoardTime;
            waitUntil {
                sleep 1;
                private _living = _team select {alive _x};
                time > _boardBy || {!alive _helo} || {!alive driver _helo} || {_living isEqualTo []} || {{vehicle _x == _helo} count _living == count _living}
            };
            private _aboard = _team select {alive _x && {vehicle _x == _helo}};
            if !(_aboard isEqualTo []) then {
                ["Evac 출발. 미탑승 인원은 자동 이동하지 않습니다."] call _tell;
                while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
                _helo land "NONE";
                _wp = _g addWaypoint [_baseLZ,0]; _wp setWaypointType "MOVE"; _wp setWaypointCompletionRadius 100;
                private _returnBy = time + MSL_evacFlightTimeout;
                waitUntil {sleep 2; !alive _helo || {!alive driver _helo} || {_helo distance2D _baseLZ < 250} || {time > _returnBy}};
                if (alive _helo && {alive driver _helo} && {_helo distance2D _baseLZ < 250}) then {
                    _helo land "LAND";
                    private _landBy = time + 120;
                    waitUntil {sleep 1; !alive _helo || {(_helo distance2D _baseLZ < 100) && {getPosATL _helo select 2 < 3} && {abs speed _helo < 5}} || {time > _landBy}};
                    _returned = alive _helo && {_helo distance2D _baseLZ < 100} && {getPosATL _helo select 2 < 3} && {abs speed _helo < 5};
                    if (_returned) then {
                        {
                            if (isPlayer _x && {alive _x} && {vehicle _x == _helo}) then {
                                private _a = [getPlayerUID _x] call MSL_fnc_account;
                                _a set [1,(_a select 1) + MSL_evacCash]; _a set [2,(_a select 2) + MSL_evacXP];
                                [_x,format ["후방 철수 완료: $%1 / XP %2. 헬기에서 하차하세요.",MSL_evacCash,MSL_evacXP]] call MSL_fnc_publish;
                            };
                        } forEach _aboard;
                        [] call MSL_fnc_persist;
                    };
                };
            };
        };
    };
};
if (!_returned) then {["Evac 종료: 미탑승·착륙 실패·기체 손실 또는 비행 제한시간 초과. 안전을 확인하세요."] call _tell;};
deleteMarker _marker;
// Never delete a helicopter with a human aboard, including crash/timeout paths.
if (!isNull _helicopter) then {
    if (alive _helicopter && {crew _helicopter findIf {isPlayer _x} < 0} && {alive driver _helicopter}) then {
        _helicopter land "NONE";
        while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
        private _wp = _g addWaypoint [_baseLZ,0]; _wp setWaypointType "MOVE";
    };
    [_helicopter,_crew,_g,_pads] spawn {
        params ["_helo","_crew","_g","_pads"];
        private _end = time + 600;
        waitUntil {sleep 5; isNull _helo || {time > _end} || {(crew _helo findIf {isPlayer _x} < 0) && {allPlayers findIf {_x distance2D _helo < 500} < 0}}};
        if (!isNull _helo && {crew _helo findIf {isPlayer _x} < 0}) then {
            {if (!isPlayer _x) then {deleteVehicle _x;};} forEach _crew;
            if (alive _helo) then {deleteVehicle _helo;}; deleteGroup _g;
        } else {
            if (!isNull _helo) then {
                _helo setVariable ["MSL_cleanupPending",true];
                _helo setVariable ["MSL_cleanupCrew",_crew]; _helo setVariable ["MSL_cleanupGroup",_g];
            };
        };
        {deleteVehicle _x;} forEach _pads;
    };
} else {{deleteVehicle _x;} forEach _pads;};
MSL_evacActive = false;
