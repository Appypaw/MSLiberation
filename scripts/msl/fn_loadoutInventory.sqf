// Pure conversion of the native Unit Loadout Array into an inventory multiset.
params ["_loadout"];
private _rows = [];
private _add = {
    params ["_class", ["_count", 1], ["_rounds", 0]];
    if (_class == "" || {_count < 1}) exitWith {};
    private _i = _rows findIf {(_x select 0) == _class};
    if (_i < 0) then {_rows pushBack [_class, _count, _rounds];} else {
        private _r = _rows select _i; _r set [1, (_r select 1) + _count]; _r set [2, (_r select 2) + _rounds];
    };
};
private _weapon = {
    params ["_w", ["_count", 1]];
    if (count _w < 7) exitWith {};
    {[_w select _x, _count] call _add;} forEach [0,1,2,3,6];
    {
        private _mag = _w select _x;
        if (count _mag >= 2) then {[_mag select 0, _count, (_mag select 1) * _count] call _add;};
    } forEach [4,5];
};
{[_loadout param [_x, []]] call _weapon;} forEach [0,1,2,8];
{
    private _container = _loadout param [_x, []];
    if (count _container >= 2) then {
        [_container select 0] call _add;
        {
            private _entry = _x select 0; private _count = _x select 1;
            if (_entry isEqualType "") then {
                [_entry, _count, (_x param [2,0]) * _count] call _add;
            } else {
                if (count _entry >= 7) then {[_entry, _count] call _weapon;} else {
                    if (count _entry > 0) then {[_entry select 0, _count] call _add;};
                };
            };
        } forEach (_container select 1);
    };
} forEach [3,4,5];
{[_loadout param [_x, ""]] call _add;} forEach [6,7];
{[_x] call _add;} forEach (_loadout param [9, []]);
_rows
