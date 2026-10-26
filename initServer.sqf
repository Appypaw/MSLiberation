// Server-local diagnostics for the Windows dedicated deployment.
[] spawn {
    private _deadline = diag_tickTime + 600;
    waitUntil {sleep 1; (missionNamespace getVariable ["MSL_ready", false]) || diag_tickTime > _deadline};
    diag_log format ["[MSL BOOT] world=%1 KP=%2 saveLoaded=%3 MSL=%4 sectors=%5 players=%6",
        worldName, missionNamespace getVariable ["KPLIB_init", false],
        missionNamespace getVariable ["save_is_loaded", false],
        missionNamespace getVariable ["MSL_ready", false],
        count (missionNamespace getVariable ["sectors_allSectors", []]), count allPlayers];
    if !(missionNamespace getVariable ["MSL_ready", false]) exitWith {diag_log "[MSL BOOT FAILED] Initialization timed out; inspect earlier RPT errors.";};
    [] execVM "tools\msl_preflight.sqf";
    if ((serverName find "[TEST]") == 0 && {allPlayers isEqualTo []}) then {
        [] execVM "tools\msl_selftest.sqf";
    };
    while {true} do {
        diag_log format ["[MSL HEALTH] fps=%1 minFPS=%2 units=%3 groups=%4 players=%5 activeSectors=%6",
            diag_fps, diag_fpsMin, count allUnits, count allGroups, count allPlayers,
            count (missionNamespace getVariable ["active_sectors", []])];
        sleep 60;
    };
};
