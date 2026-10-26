// Runs where the group is local. Repositions only against actually known targets.
if (isRemoteExecuted) exitWith {};
params ["_g", "_home"];
_g setVariable ["MSL_specops", true, true];
_g setFormation "WEDGE"; _g setCombatMode "YELLOW";
private _end = time + 1800;
while {!isNull _g && {local _g} && {count units _g > 0} && {time < _end} && {GRLIB_endgame == 0} && {!(_g getVariable ["MSL_stopSpecops",false])}} do {
    private _leader = leader _g;
    private _target = objNull;
    private _nearest = 1200;
    {
        private _distance = _x distance2D _leader;
        if (_distance < _nearest && {alive _x} && {side group _x == GRLIB_side_friendly} && {_g knowsAbout _x > 1.5} && {_x distance2D _home < 2000}) then {
            _target = _x; _nearest = _distance;
        };
    } forEach allUnits;
    if (!isNull _target) then {
        private _flank = (getPosATL _target) getPos [200, (_target getDir leader _g) + selectRandom [-70,70]];
        if (!surfaceIsWater _flank) then {
            while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
            private _wp = _g addWaypoint [_flank, 25]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE";
            _wp = _g addWaypoint [getPosATL _target, 70]; _wp setWaypointType "SAD";
        };
    };
    sleep 60;
};
