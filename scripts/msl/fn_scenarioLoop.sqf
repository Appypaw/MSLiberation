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
    sleep 5;
};
