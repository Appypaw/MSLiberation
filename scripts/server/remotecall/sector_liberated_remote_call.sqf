params ["_liberated_sector"];
if (!isServer || {_liberated_sector in blufor_sectors}) exitWith {};
if (isRemoteExecuted && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}) exitWith {};
if (missionNamespace getVariable ["MSL_ready", false]) then {
    if (isNil "MSL_captureClaims") then {MSL_captureClaims = [];};
};
if (missionNamespace getVariable ["MSL_ready", false] && {_liberated_sector in MSL_captureClaims}) exitWith {};
if (missionNamespace getVariable ["MSL_ready", false]) then {
    MSL_captureClaims pushBack _liberated_sector;
    {
        if (alive _x && {side group _x == GRLIB_side_friendly} && {_x distance2D markerPos _liberated_sector < GRLIB_capture_size * 2}) then {
            private _a = [getPlayerUID _x] call MSL_fnc_account;
            _a set [1, (_a select 1) + MSL_captureCash]; _a set [2, (_a select 2) + MSL_captureXP]; _a set [5, (_a select 5) + 1];
            [_x, format ["지역 확보 보상: $%1 / XP %2", MSL_captureCash, MSL_captureXP]] call MSL_fnc_publish;
        };
    } forEach (allPlayers - entities "HeadlessClient_F");
    [] call MSL_fnc_persist;
};

private _combat_readiness_increase = 0;
switch (true) do {
    case (_liberated_sector in sectors_bigtown):    {_combat_readiness_increase = floor (random 10) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_capture):    {_combat_readiness_increase = floor (random 6) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_military):   {_combat_readiness_increase = 5 + (floor (random 11)) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_factory):    {_combat_readiness_increase = 3 + (floor (random 7)) * GRLIB_difficulty_modifier;};
    case (_liberated_sector in sectors_tower):      {_combat_readiness_increase = floor (random 4);};
};

combat_readiness = combat_readiness + _combat_readiness_increase;
if (combat_readiness > 100.0 && GRLIB_difficulty_modifier <= 2.0) then {combat_readiness = 100.0};
stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;

[_liberated_sector, 0] remoteExecCall ["remote_call_sector"];
blufor_sectors pushback _liberated_sector; publicVariable "blufor_sectors";
stats_sectors_liberated = stats_sectors_liberated + 1;
private _mslCityHandled = false;
if (missionNamespace getVariable ["MSL_ready",false] && {MSL_defenseEnabled} && {_liberated_sector in sectors_bigtown}) then {
    _mslCityHandled = true;
    ["city",_liberated_sector,markerPos _liberated_sector] call MSL_fnc_queueScenario;
};

reset_battlegroups_ai = true; publicVariable "reset_battlegroups_ai";

if (_liberated_sector in sectors_factory) then {
    {
        if (_liberated_sector in _x) exitWith {KP_liberation_production = KP_liberation_production - [_x];};
    } forEach KP_liberation_production;

    private _sectorFacilities = (KP_liberation_production_markers select {_liberated_sector == (_x select 0)}) select 0;
    KP_liberation_production pushBack [
        markerText _liberated_sector,
        _liberated_sector,
        1,
        [],
        _sectorFacilities select 1,
        _sectorFacilities select 2,
        _sectorFacilities select 3,
        3,
        KP_liberation_production_interval,
        0,
        0,
        0
    ];
};

[_liberated_sector] spawn F_cr_liberatedSector;

if ((random 100) <= KP_liberation_cr_wounded_chance || (count blufor_sectors) == 1) then {
    [_liberated_sector] spawn civrep_wounded_civs;
};

asymm_blocked_sectors pushBack [_liberated_sector, time];
publicVariable "asymm_blocked_sectors";

[] spawn check_victory_conditions;

sleep 1;

[] spawn KPLIB_fnc_doSave;

sleep 45;

if (GRLIB_endgame == 0 && {!_mslCityHandled}) then {
    if (
        !(_liberated_sector in sectors_tower)
        && {
            (random (150 / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity))) < (combat_readiness - 15)
            || _liberated_sector in sectors_bigtown
        }
        && {[] call KPLIB_fnc_getOpforCap < GRLIB_battlegroup_cap}
    ) then {
        [_liberated_sector, (random 100) < 45] spawn spawn_battlegroup;
    };
};
