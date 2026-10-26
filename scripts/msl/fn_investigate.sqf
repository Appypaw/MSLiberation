// Dispatch existing patrols or a real reinforcement from an enemy military site.
if (!isServer || {isRemoteExecuted}) exitWith {};
params ["_pos", ["_raid", false], ["_aircraft", objNull], ["_maxGroups",2], ["_reinforcementSize",-1]];
private _groups = allGroups select {
    side _x == GRLIB_side_enemy && {count units _x > 0} && {vehicle leader _x == leader _x} && {leader _x distance2D _pos < 1800}
};
private _sent = 0;
{
    private _g = _x;
    private _visible = !(lineIntersects [eyePos leader _g, ATLToASL (_pos vectorAdd [0,0,2]), leader _g]);
    private _detected = leader _g distance2D _pos < 700 && {_visible};
    if (!isNull _aircraft && {_g knowsAbout _aircraft > 1}) then {_detected = true;};
    if ((_detected || {_raid}) && {_sent < _maxGroups}) then {
        if (local _g) then {[_g, _pos, _raid, _aircraft] call MSL_fnc_redirectGroup;} else {
            [_g, _pos, _raid, _aircraft] remoteExecCall ["MSL_fnc_redirectGroup", groupOwner _g];
        };
        _sent = _sent + 1;
    };
} forEach _groups;
if (!_raid && {_sent == 0}) exitWith {};
if ([] call KPLIB_fnc_getOpforCap >= GRLIB_battlegroup_cap || {random 1 > ([] call MSL_fnc_supportFactor)}) exitWith {};
private _tower = [_pos, GRLIB_side_enemy, GRLIB_radiotower_size * 1.4] call KPLIB_fnc_getNearestTower;
if (_tower == "") exitWith {};
private _sites = sectors_military select {
    !(_x in blufor_sectors) && {markerPos _x distance2D _pos > 1200} && {markerPos _x distance2D _pos < 6000}
};
_sites = _sites select {private _p = markerPos _x; allPlayers findIf {alive _x && {_x distance2D _p < 900}} < 0};
if (_sites isEqualTo []) exitWith {};
private _source = markerPos selectRandom _sites;
private _squad = [(["army", "specops"] select _raid)] call KPLIB_fnc_getSquadComp;
if (_reinforcementSize >= 0) then {_squad = _squad select [0,_reinforcementSize];};
private _g = createGroup [GRLIB_side_enemy, true];
{[_x, _source, _g, "PRIVATE", 10] call KPLIB_fnc_createManagedUnit;} forEach _squad;
private _wp = _g addWaypoint [_pos, 80]; _wp setWaypointType "SAD"; _wp setWaypointSpeed "FULL";
if (_raid) then {[_g, _pos] spawn MSL_fnc_specopsAI;};
[_g] spawn {
    params ["_g"]; private _deadline = time + 1800;
    waitUntil {sleep 15; count units _g == 0 || {time > _deadline}};
    waitUntil {sleep 15; count units _g == 0 || {private _p = getPos leader _g; allPlayers findIf {alive _x && {_x distance2D _p < 1200}} < 0}};
    {deleteVehicle _x;} forEach units _g; deleteGroup _g;
};
