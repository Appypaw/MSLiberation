// Remove exactly one sellable physical item, preserving all other inventory and ammo.
// Returns [] if no match or if a weapon/container must be emptied first.
params ["_loadout", "_class"];
private _new = +_loadout;
private _removed = false;
{
    private _index = _x;
    private _container = +(_new param [_index, []]);
    if (!_removed && {count _container >= 2}) then {
        private _contents = +(_container select 1);
        {
            private _entry = +_x; private _item = _entry select 0;
            private _match = false;
            if (_item isEqualType "") then {_match = _item == _class;} else {
                if (count _item >= 7) then {_match = (_item select 0) == _class && {(_item select [1,6]) isEqualTo ["","","",[],[],""]};};
            };
            if (!_removed && {_match}) then {
                private _count = (_entry select 1) - 1;
                if (_count > 0) then {_entry set [1,_count]; _contents set [_forEachIndex, _entry];} else {_contents set [_forEachIndex, []];};
                _removed = true;
            };
        } forEach _contents;
        _container set [1, _contents select {!(_x isEqualTo [])}];
        _new set [_index, _container];
    };
} forEach [3,4,5];
{
    private _index = _x;
    private _w = +(_new param [_index, []]);
    if (!_removed && {count _w >= 7}) then {
        if ((_w select 0) == _class && {(_w select [1,6]) isEqualTo ["","","",[],[],""]}) then {_new set [_index, []]; _removed = true;} else {
            {if (!_removed && {(_w select _x) == _class}) then {_w set [_x, ""]; _removed = true;};} forEach [1,2,3,6];
            _new set [_index, _w];
        };
    };
} forEach [0,1,2,8];
{if (!_removed && {(_new param [_x, ""]) == _class}) then {_new set [_x, ""]; _removed = true;};} forEach [6,7];
{
    private _c = _new param [_x, []];
    if (!_removed && {count _c >= 2} && {(_c select 0) == _class} && {(_c select 1) isEqualTo []}) then {_new set [_x, []]; _removed = true;};
} forEach [3,4,5];
private _assigned = +(_new param [9, []]);
private _i = _assigned find _class;
if (!_removed && {_i >= 0}) then {_assigned set [_i, ""]; _new set [9,_assigned]; _removed = true;};
if (!_removed) exitWith {[]};
_new
