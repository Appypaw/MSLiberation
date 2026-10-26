if (!isServer || {isRemoteExecuted}) exitWith {};
private _knownFOBs = +GRLIB_all_fobs; // Loaded campaign FOBs are not new construction.
while {GRLIB_endgame == 0} do {
    {
        private _new = _x;
        if (_knownFOBs findIf {_x distance2D _new < 80} < 0) then {
            ["fob",str _new,_new] call MSL_fnc_queueScenario;
        };
    } forEach GRLIB_all_fobs;
    _knownFOBs = +GRLIB_all_fobs;
    if !(MSL_scenarioQueue isEqualTo []) then {
        private _event = MSL_scenarioQueue select 0;
        _event params ["_kind","_target","_pos","_due","_expiry"];
        if (time > _expiry || {time < MSL_nextScenario} || {MSL_defenseActive}) then {MSL_scenarioQueue deleteAt 0;} else {
            if (time >= _due) then {
                private _present = allPlayers findIf {alive _x && {side group _x == GRLIB_side_friendly} && {_x distance2D _pos < 600}} >= 0;
                if (_present) then {
                    MSL_scenarioQueue deleteAt 0;
                    [_kind,_target,_pos] spawn MSL_fnc_defenseEvent;
                };
            };
        };
    };
    if !(MSL_evacRequests isEqualTo []) then {(MSL_evacRequests deleteAt 0) spawn MSL_fnc_evac;};
    // A passenger who remains aboard past the initial cleanup deadline is never deleted.
    // Once disembarked, return the support aircraft and then release its crew/group.
    {
        private _helo = _x;
        if (crew _helo findIf {isPlayer _x} < 0) then {
            private _started = _helo getVariable ["MSL_cleanupStarted",-1];
            if (_started < 0) then {
                _helo setVariable ["MSL_cleanupStarted",time];
                if (alive _helo && {alive driver _helo}) then {
                    _helo land "NONE";
                    private _exit = (getPosATL _helo) getPos [2000,random 360]; _exit set [2,150];
                    (_helo getVariable ["MSL_cleanupGroup",grpNull]) move _exit;
                };
            } else {
                if (time - _started > 180 || {allPlayers findIf {_x distance2D _helo < 500} < 0}) then {
                    {if (!isPlayer _x) then {deleteVehicle _x;};} forEach (_helo getVariable ["MSL_cleanupCrew",[]]);
                    private _g = _helo getVariable ["MSL_cleanupGroup",grpNull];
                    if (alive _helo) then {deleteVehicle _helo;} else {_helo setVariable ["MSL_cleanupPending",false];};
                    deleteGroup _g;
                };
            };
        };
    } forEach MSL_supportCleanup;
    MSL_supportCleanup = MSL_supportCleanup select {!isNull _x && {_x getVariable ["MSL_cleanupPending",false]}};
    sleep 5;
};
