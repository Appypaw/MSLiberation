// Server-only scheduled flight. Requests are validated before this function is spawned.
if (!isServer || {isRemoteExecuted}) exitWith {};
params ["_unit", ["_kind", "ammo"]];
if (!([_unit] call MSL_fnc_canRequestSupport)) exitWith {};
if (isNull _unit || {!alive _unit} || {GRLIB_endgame != 0}) exitWith {};
if !(_kind in ["ammo", "medical", "resources"]) exitWith {};
private _tell = {params ["_text"]; [_text] remoteExecCall ["systemChat", owner _unit];};
if (MSL_dropActive || {time < MSL_nextDrop}) exitWith {[format ["공중보급 대기 중. 다음 요청까지 %1초", ceil ((MSL_nextDrop - time) max 0)]] call _tell;};
private _pool = MSL_supplyPlaneCandidates select {isClass (configFile >> "CfgVehicles" >> _x)};
if (_pool isEqualTo []) exitWith {["사용 가능한 아군 수송기 클래스가 없습니다."] call _tell;};
MSL_dropActive = true; MSL_nextDrop = time + MSL_supplyCooldown;
private _requestPos = getPosATL _unit;
private _heading = random 360;
private _origin = _requestPos getPos [6500, _heading + 180]; _origin set [2, 600];
private _spawn = [_origin, _heading, _pool select 0, GRLIB_side_friendly] call BIS_fnc_spawnVehicle;
_spawn params ["_plane", "_crew", "_g"];
_plane flyInHeight 450; _g setSpeedMode "NORMAL";
_g setBehaviour "CARELESS"; _g setCombatMode "BLUE";
{_x disableAI "AUTOTARGET"; _x disableAI "TARGET";} forEach _crew;
private _wp = _g addWaypoint [_requestPos vectorAdd [0,0,450], 0]; _wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 100;
["수송기 접근 중. 요청 지점 120m 이내에 주간 연막 / 야간 플레어·케미라이트를 사용하세요."] call _tell;
_unit setVariable ["MSL_signalWindow", [time, _requestPos]];
_unit setVariable ["MSL_signal", objNull];
private _deadline = time + MSL_supplySignalTimeout;
private _signal = objNull;
waitUntil {
    sleep 1;
    _signal = _unit getVariable ["MSL_signal", objNull];
    !isNull _signal || {time > _deadline} || {!alive _plane} || {!alive driver _plane} || {!alive _unit} || {GRLIB_endgame != 0}
};

if (!isNull _signal && {alive _plane} && {alive driver _plane} && {alive _unit}) then {
    // Let thrown smoke settle; a flare's horizontal position identifies the ground LZ.
    sleep 3;
    private _lz = getPosATL _signal; _lz set [2, 0];
    if (!isNull _signal && {!surfaceIsWater _lz} && {_lz distance2D _requestPos <= MSL_supplySignalRadius}) then {
        ["표식 확인. 투하 지점으로 접근합니다. 주변을 확보하세요."] call _tell;
        [_lz, false, _plane] spawn MSL_fnc_investigate;
        // Build a fresh straight run to avoid dropping on a turn/overshoot.
        while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
        private _dir = _plane getDir _lz;
        private _approach = _lz getPos [2500, _dir + 180]; _approach set [2,450];
        _wp = _g addWaypoint [_approach, 0]; _wp setWaypointType "MOVE"; _wp setWaypointCompletionRadius 300;
        private _exit = _lz getPos [6000, _dir]; _exit set [2,450];
        private _run = _g addWaypoint [_exit, 0]; _run setWaypointType "MOVE";
        _g setCurrentWaypoint _wp;
        private _until = time + 240;
        private _closest = 99999;
        waitUntil {
            sleep 0.2;
            private _distance = _plane distance2D _lz;
            _closest = _closest min _distance;
            _distance < 180 || {(_closest < 450) && {_distance > _closest + 30}} || {time > _until} || {!alive _plane} || {!alive driver _plane}
        };
        if (alive _plane && {alive driver _plane} && {_plane distance2D _lz < 450} && {getPosATL _plane select 2 > 100}) then {
            private _dropPos = getPosATL _plane; _dropPos set [2, (_dropPos select 2) - 15];
            private _chute = createVehicle ["B_Parachute_02_F", _dropPos, [], 0, "FLY"];
            private _box = createVehicle [MSL_supplyCrate, _dropPos, [], 0, "NONE"];
            clearWeaponCargoGlobal _box; clearMagazineCargoGlobal _box; clearItemCargoGlobal _box; clearBackpackCargoGlobal _box;
            _box attachTo [_chute, [0,0,-1.3]];
            switch (_kind) do {
                case "ammo": {
                    private _magazines = (primaryWeaponMagazine _unit) + (handgunMagazine _unit);
                    if (_magazines isEqualTo []) then {_magazines = ["30Rnd_556x45_Stanag"];};
                    {_box addMagazineCargoGlobal [_x, 12];} forEach (_magazines arrayIntersect _magazines);
                    _box addMagazineCargoGlobal ["SmokeShellGreen", 6];
                    _box addMagazineCargoGlobal ["Chemlight_green", 6];
                    _box addMagazineCargoGlobal ["UGL_FlareWhite_F", 6];
                };
                case "medical": {
                    _box addItemCargoGlobal ["FirstAidKit", 30]; _box addItemCargoGlobal ["Medikit", 2];
                    {if (isClass (configFile >> "CfgWeapons" >> _x)) then {_box addItemCargoGlobal [_x, 20];};} forEach ["ACE_fieldDressing", "ACE_elasticBandage", "ACE_tourniquet", "ACE_morphine", "ACE_salineIV_500"];
                };
                case "resources": {};
            };

            private _marker = createMarker [format ["MSL_drop_%1", floor time], _lz];
            _marker setMarkerType "mil_box"; _marker setMarkerColor "ColorWEST"; _marker setMarkerText "아군 공중보급";
            ["보급품 투하. 접근하는 적을 경계하세요."] call _tell;
            [_box, _chute, _marker, _kind] spawn {
                params ["_box", "_chute", "_marker", "_kind"];
                private _until = time + 180;
                waitUntil {sleep 0.5; isNull _box || {getPosATL _box select 2 < 2.5} || {time > _until}};
                if (!isNull _box) then {
                    detach _box;
                    if (getPosATL _box select 2 < 5) then {
                        private _p = getPosATL _box; _p set [2,0.2]; _box setPosATL _p;
                        if (_kind == "resources") then {
                            // Real KP crates enter the existing resource/storage/logistics system.
                            {[_x, 100, getPosATL _box vectorAdd [(_forEachIndex - 1) * 3, 2, 0]] call KPLIB_fnc_createCrate;} forEach [KP_liberation_supply_crate, KP_liberation_ammo_crate, KP_liberation_fuel_crate];
                        };
                    };
                    _marker setMarkerPos getPosATL _box;
                };
                deleteVehicle _chute;
                sleep 900; deleteMarker _marker;
                waitUntil {sleep 30; isNull _box || {allPlayers findIf {_x distance _box < 100} < 0}};
                if (!isNull _box) then {deleteVehicle _box;};
            };
        };
    } else {["투하 불가: 표식이 물 위이거나 요청 구역을 벗어났습니다. 재요청 시 새 표식을 사용하세요."] call _tell;};
} else {["보급 취소: 유효한 표식이 없거나 수송 임무가 중단되었습니다."] call _tell;};
_unit setVariable ["MSL_signalWindow", []]; _unit setVariable ["MSL_signal", objNull];
if (alive _plane && {alive driver _plane}) then {
    while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
    _wp = _g addWaypoint [_origin, 0]; _wp setWaypointType "MOVE";
    private _until = time + 180;
    waitUntil {sleep 5; !alive _plane || {_plane distance2D _origin < 600} || {time > _until}};
};
{deleteVehicle _x;} forEach crew _plane;
if (alive _plane) then {deleteVehicle _plane;}; deleteGroup _g;
MSL_dropActive = false;
