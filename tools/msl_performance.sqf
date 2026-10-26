/* Read-only, bounded performance sample. Execute locally on the server or HC:
   [] execVM "tools\msl_performance.sqf";
   Samples FPS/counts for 60 seconds and compares old/new capture candidates.
   No capture timers, accounts, profiles, equipment or objects are changed.
   Query timings are microbenchmarks, not an estimate of FPS gained.
*/
if (isRemoteExecuted || {hasInterface && {!isServer}} || {!(missionNamespace getVariable ["MSL_ready",false])}) exitWith {};
if ((productVersion select 2) < 218) exitWith {diag_log "[MSL PERF] area query comparison requires 2.18+; mission uses legacy capture scans on this version";};
private _fps = [];
for "_sample" from 1 to 12 do {
    _fps pushBack diag_fps;
    diag_log format ["[MSL PERF] fps=%1 minFPS=%2 units=%3 vehicles=%4 activeSectors=%5 players=%6",diag_fps,diag_fpsMin,count allUnits,count vehicles,count active_sectors,count allPlayers];
    sleep 5;
};
private _average = 0;
{_average = _average + _x;} forEach _fps;
diag_log format ["[MSL PERF] 60s average sampled FPS=%1 minimum sampled FPS=%2",_average / count _fps,selectMin _fps];
{
    private _sector = _x;
    private _pos = markerPos _sector;
    private _radius = MSL_captureClearanceRadius max GRLIB_capture_size;
    // Run both reads in one unscheduled block, so scheduler delays do not
    // masquerade as query time or movement differences between the queries.
    isNil {
        private _start = diag_tickTime;
        private _oldUnits = allUnits select {_x distance2D _pos < _radius};
        private _oldArmor = vehicles select {alive _x && {_x isKindOf "Tank" || {_x isKindOf "Wheeled_APC_F"}} && {_x distance2D _pos < _radius}};
        private _oldMS = (diag_tickTime - _start) * 1000;
        _start = diag_tickTime;
        private _area = [_pos,_radius,_radius,0,false,-1];
        private _newUnits = (_area nearEntities [["Man"],false,true,true]) select {_x distance2D _pos < _radius};
        private _newArmor = (_area nearEntities [["Tank","Wheeled_APC_F"],false,true,false]) select {_x distance2D _pos < _radius};
        private _newMS = (diag_tickTime - _start) * 1000;
        diag_log format ["[MSL PERF QUERY] sector=%1 oldMS=%2 newMS=%3 missingUnits=%4 extraUnits=%5 missingArmor=%6 extraArmor=%7",_sector,_oldMS,_newMS,_oldUnits - _newUnits,_newUnits - _oldUnits,_oldArmor - _newArmor,_newArmor - _oldArmor];
    };
    sleep 0.1;
} forEach (+active_sectors);
diag_log "[MSL PERF] completed; review query differences before multiplayer acceptance";
