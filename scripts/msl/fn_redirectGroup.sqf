// Execute on the owning server/HC only; the server is the only remote caller.
if (isRemoteExecuted && {remoteExecutedOwner != 2}) exitWith {};
if (!isRemoteExecuted && {!isServer}) exitWith {};
params ["_g", "_pos", ["_raid", false], ["_aircraft", objNull]];
if (isNull _g || {!local _g} || {side _g != GRLIB_side_enemy} || {count units _g == 0}) exitWith {};
if (time < (_g getVariable ["MSL_redirectAfter", 0])) exitWith {};
private _visible = !(lineIntersects [eyePos leader _g, ATLToASL (_pos vectorAdd [0,0,2]), leader _g]);
private _detected = leader _g distance2D _pos < 700 && {_visible};
if (!isNull _aircraft && {_g knowsAbout _aircraft > 1}) then {_detected = true;};
if (!_raid && {!_detected}) exitWith {};
_g setVariable ["MSL_redirectAfter", time + 180];
while {count waypoints _g > 0} do {deleteWaypoint ((waypoints _g) select 0);};
private _wp = _g addWaypoint [_pos, 80]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE";
