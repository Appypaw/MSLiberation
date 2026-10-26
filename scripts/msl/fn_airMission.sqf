if (!isServer || {isRemoteExecuted}) exitWith {};
params ["_targetPos", ["_role", "CAS"]];
private _pool = [MSL_airCAS, MSL_airCAP] select (_role == "CAP");
_pool = _pool select {isClass (configFile >> "CfgVehicles" >> _x)};
if (_pool isEqualTo [] || {sectors_airspawn isEqualTo []}) exitWith {};
private _airfields = sectors_airspawn select {!(_x in blufor_sectors)};
// Air spawn markers are usually separate from capturable military markers.
_airfields = _airfields select {
    private _p = markerPos _x;
    sectors_military findIf {_x in blufor_sectors && {markerPos _x distance2D _p < 1200}} < 0
};
if (_airfields isEqualTo []) exitWith {};
private _factor = [] call MSL_fnc_supportFactor;
if (random 1 > _factor) exitWith {};
if (isNil "MSL_airGroups") then {MSL_airGroups = [];};
MSL_airGroups = MSL_airGroups select {!isNull _x && {count units _x > 0}};
if (count MSL_airGroups >= 2) exitWith {};
private _targets = vehicles select {alive _x && {_x isKindOf "Air"} && {getPosATL _x select 2 > 30} && {crew _x findIf {alive _x && {side group _x == GRLIB_side_friendly}} >= 0}};
if (_role == "CAP" && {_targets isEqualTo []}) exitWith {};
private _spawn = markerPos selectRandom _airfields;
if (allPlayers findIf {_x distance2D _spawn < 1500} >= 0) exitWith {};
private _result = [_spawn vectorAdd [0,0,900], _spawn getDir _targetPos, selectRandom _pool, GRLIB_side_enemy] call BIS_fnc_spawnVehicle;
_result params ["_plane", "_crew", "_g"];
MSL_airGroups pushBack _g;
_plane setVariable ["MSL_airRole", _role, true];
_plane flyInHeight ([350, 1200] select (_role == "CAP"));
_plane addMPEventHandler ["MPKilled", {_this spawn kill_manager;}];
{_x addMPEventHandler ["MPKilled", {_this spawn kill_manager;}];} forEach _crew;
[_plane] call KPLIB_fnc_addObjectInit;
// Select compatible magazines by the actual ammo's airLock property. Legacy aircraft
// without dynamic pylons keep their built-in weapons and are still assigned a role.
{
    private _pylon = _forEachIndex + 1;
    private _compatible = _plane getCompatiblePylonMagazines _pylon;
    private _suitable = _compatible select {
        private _ammo = configFile >> "CfgAmmo" >> getText (configFile >> "CfgMagazines" >> _x >> "ammo");
        private _air = getNumber (_ammo >> "airLock") > 0;
        private _simulation = toLower getText (_ammo >> "simulation");
        [!_air && {_simulation in ["shotmissile", "shotrocket", "shotbomb", "shotshell", "shotbullet"]}, _air] select (_role == "CAP")
    };
    if !(_suitable isEqualTo []) then {_plane setPylonLoadout [_pylon, selectRandom _suitable, true];};
} forEach getPylonMagazines _plane;
{_x disableAI "AUTOTARGET";} forEach _crew;
private _wp = _g addWaypoint [_targetPos, 250]; _wp setWaypointType "MOVE";
_wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
private _end = time + 600;
while {alive _plane && {alive driver _plane} && {time < _end} && {GRLIB_endgame == 0}} do {
    private _target = objNull;
    if (_role == "CAP") then {
        _targets = vehicles select {alive _x && {_x isKindOf "Air"} && {getPosATL _x select 2 > 30} && {crew _x findIf {alive _x && {side group _x == GRLIB_side_friendly}} >= 0} && {_g knowsAbout _x > 1}};
    } else {
        _targets = (allUnits + vehicles) select {alive _x && {!(_x isKindOf "Air")} && {side _x == GRLIB_side_friendly} && {_x distance2D _targetPos < 1500} && {_g knowsAbout _x > 1}};
    };
    if !(_targets isEqualTo []) then {
        private _ranked = _targets apply {[_x distance2D _plane, _x]}; _ranked sort true;
        _target = (_ranked select 0) select 1;
        _wp setWaypointType "DESTROY"; _wp waypointAttachVehicle _target;
        driver _plane doTarget _target; driver _plane doFire _target;
        _wp setWaypointPosition [getPos _target, 100];
    } else {
        _wp setWaypointType "MOVE";
        _wp setWaypointPosition [_targetPos, 500];
    };
    if (_role == "CAP" && {(vehicles findIf {alive _x && {_x isKindOf "Air"} && {crew _x findIf {isPlayer _x && {side group _x == GRLIB_side_friendly}} >= 0}}) < 0}) exitWith {};
    sleep 10;
};
if (alive _plane) then {
    _g setCombatMode "BLUE"; driver _plane doWatch objNull; _g move (_spawn vectorAdd [0,0,1200]);
    private _until = time + 180;
    waitUntil {sleep 5; !alive _plane || {_plane distance2D _spawn < 800} || {time > _until}};
};
{deleteVehicle _x;} forEach crew _plane;
if (alive _plane) then {deleteVehicle _plane;};
deleteGroup _g;
