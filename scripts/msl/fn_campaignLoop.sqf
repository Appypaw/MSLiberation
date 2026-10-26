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
private _lastOwned = [];
private _lastBase = [];
private _first = true;
MSL_defenseActive = false; MSL_defenseState = []; publicVariable "MSL_defenseState";
while {GRLIB_endgame == 0} do {
    private _owned = +blufor_sectors;
    private _base = [] call MSL_fnc_basePosition;
    if (_first || {!(_owned isEqualTo _lastOwned)} || {!(_base isEqualTo _lastBase)}) then {
        _first = false; _lastOwned = +_owned; _lastBase = +_base;
        private _wanted = [];
        private _connected = [];
        private _queue = _owned select {markerPos _x distance2D _base <= MSL_linkDistance};
        if (_queue isEqualTo [] && {!(_owned isEqualTo [])}) then {
            private _sorted = _owned apply {[markerPos _x distance2D _base, _x]};
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
        private _isolated = _owned - _connected;
        if !(_isolated isEqualTo MSL_isolated) then {MSL_isolated = _isolated; publicVariable "MSL_isolated";};
        {
            private _s = _x; private _i = _links findIf {(_x select 0) == _s};
            private _front = false;
            if (_i >= 0) then {_front = (((_links select _i) select 1) findIf {!(_x in _owned)}) >= 0;};
            if (_front || {_s in MSL_isolated}) then {
                private _m = "MSL_front_" + _s;
                private _color = ["ColorOrange", "ColorRed"] select (_s in MSL_isolated);
                private _text = ["전선", "고립 거점"] select (_s in MSL_isolated);
                if !(_m in _markers) then {
                    createMarker [_m, (markerPos _s) vectorAdd [60,60,0]];
                    // Set attributes locally; the final global update sends the full marker.
                    _m setMarkerTypeLocal "mil_warning"; _m setMarkerSizeLocal [0.6,0.6];
                    _m setMarkerColorLocal _color; _m setMarkerText _text;
                } else {
                    if (markerColor _m != _color) then {_m setMarkerColorLocal _color; _m setMarkerText _text;};
                };
                _wanted pushBack _m;
            };
        } forEach _owned;
        {deleteMarker _x;} forEach (_markers - _wanted);
        _markers = _wanted;
    };
    // Radio sites are destructible; destroyed state survives a restart and blocks new calls.
    {
        private _tower = _x getVariable ["MSL_towerSector", ""];
        if (_tower != "" && {_tower in MSL_destroyedTowers} && {alive _x}) then {_x setDamage 1;};
    } forEach (missionNamespace getVariable ["MSL_towerObjects", []]);
    private _pressure = (MSL_supplyPressure - 0.005) max 0;
    if (_pressure != MSL_supplyPressure) then {MSL_supplyPressure = _pressure; publicVariable "MSL_supplyPressure";};
    sleep 30;
};
{deleteMarker _x;} forEach _markers;
