// Called by trusted KP capture code or the server's FOB observer, never by players.
if (!isServer) exitWith {false};
if (isRemoteExecuted && {!(remoteExecutedOwner in ([2] + ((entities "HeadlessClient_F") apply {owner _x})))}) exitWith {false};
params ["_kind","_target","_pos"];
if (!MSL_defenseEnabled || {!(missionNamespace getVariable ["MSL_ready",false])}) exitWith {false};
if (MSL_defenseActive || {!(MSL_scenarioQueue isEqualTo [])} || {time < MSL_nextScenario}) exitWith {false};
if !(_kind in ["city","fob"]) exitWith {false};
private _chance = [MSL_cityCounterChance,MSL_fobCounterChance] select (_kind == "fob");
private _key = format ["MSL_scenario_%1_%2",_kind,_target];
if (time < (missionNamespace getVariable [_key,0])) exitWith {false};
missionNamespace setVariable [_key,time + MSL_defenseSectorCooldown];
private _enemySites = (sectors_military + sectors_capture + sectors_bigtown) select {!(_x in blufor_sectors) && {markerPos _x distance2D _pos > 1200} && {markerPos _x distance2D _pos < 6500}};
if (_enemySites isEqualTo [] || {random 1 >= _chance * ([] call MSL_fnc_supportFactor)}) exitWith {false};
private _range = [MSL_cityCounterDelay,MSL_fobCounterDelay] select (_kind == "fob");
private _due = time + (_range select 0) + random ((_range select 1) - (_range select 0));
MSL_scenarioQueue pushBack [_kind,_target,_pos,_due,_due + 180];
true
