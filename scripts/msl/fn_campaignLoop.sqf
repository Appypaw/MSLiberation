if (!isServer || {isRemoteExecuted}) exitWith {};
MSL_isolated = []; publicVariable "MSL_isolated";
private _all = (sectors_capture + sectors_bigtown + sectors_military + sectors_factory + sectors_tower) arrayIntersect (sectors_capture + sectors_bigtown + sectors_military + sectors_factory + sectors_tower);
private _links = [];
{
    private _sector = _x;
    private _near = _all select {_x != _sector && {markerPos _x distance2D markerPos _sector <= MSL_linkDistance}};
    _links pushBack [_sector, _near];
} forEach _all;
private _markers = [];
MSL_defenseActive = false; MSL_defenseState = []; publicVariable "MSL_defenseState";
while {GRLIB_endgame == 0} do {
    {deleteMarker _x;} forEach _markers; _markers = [];
    private _owned = +blufor_sectors;
    private _connected = [];
    private _queue = _owned select {markerPos _x distance2D ([] call MSL_fnc_basePosition) <= MSL_linkDistance};
    if (_queue isEqualTo [] && {!(_owned isEqualTo [])}) then {
        private _sorted = _owned apply {[markerPos _x distance2D ([] call MSL_fnc_basePosition), _x]};
        _sorted sort true; _queue = [(_sorted select 0) select 1];
    };
    while {!(_queue isEqualTo [])} do {
        private _s = _queue deleteAt 0;
        if !(_s in _connected) then {
            _connected pushBack _s;
            private _i = _links findIf {(_x select 0) == _s};
            if (_i >= 0) then {{if (_x in _owned && {!(_x in _connected)}) then {_queue pushBackUnique _x;};} forEach ((_links select _i) select 1);};
        };
    };
    MSL_isolated = _owned - _connected; publicVariable "MSL_isolated";
    {
        private _s = _x; private _i = _links findIf {(_x select 0) == _s};
        private _front = false;
        if (_i >= 0) then {_front = (((_links select _i) select 1) findIf {!(_x in _owned)}) >= 0;};
        if (_front || {_s in MSL_isolated}) then {
            private _m = createMarker ["MSL_front_" + _s, (markerPos _s) vectorAdd [60,60,0]];
            _m setMarkerType "mil_warning"; _m setMarkerSize [0.6,0.6];
            _m setMarkerColor (["ColorOrange", "ColorRed"] select (_s in MSL_isolated));
            _m setMarkerText (["전선", "고립 거점"] select (_s in MSL_isolated)); _markers pushBack _m;
        };
    } forEach _owned;
    // Radio sites are destructible; destroyed state survives a restart and blocks new calls.
    {
        private _tower = _x getVariable ["MSL_towerSector", ""];
        if (_tower != "" && {_tower in MSL_destroyedTowers} && {alive _x}) then {_x setDamage 1;};
    } forEach (missionNamespace getVariable ["MSL_towerObjects", []]);
    MSL_supplyPressure = (MSL_supplyPressure - 0.005) max 0; publicVariable "MSL_supplyPressure";
    sleep 30;
};
{deleteMarker _x;} forEach _markers;
