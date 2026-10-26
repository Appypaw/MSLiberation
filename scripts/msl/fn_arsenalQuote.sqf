// Shared preview/server quote. Negative changes never generate refunds.
params ["_before","_after","_level"];
private _old = [_before] call MSL_fnc_loadoutInventory;
private _new = [_after] call MSL_fnc_loadoutInventory;
private _cost = 0;
private _valid = true;
private _purchases = [];
{
    _x params ["_class","_count","_rounds"];
    private _i = _old findIf {toLower (_x select 0) == toLower _class};
    private _previous = if (_i < 0) then {[_class,0,0]} else {_old select _i};
    private _added = (_count - (_previous select 1)) max 0;
    private _refill = (_rounds - (_previous select 2)) max 0;
    if (_added > 0 || {_refill > 0}) then {
        private _entry = MSL_shopEntries select {toLower (_x select 0) == toLower _class};
        if (_entry isEqualTo [] || {((_entry select 0) select 3) > _level}) then {_valid = false;} else {
            private _e = _entry select 0;
            private _quantity = _added;
            if ((_e select 4) == "magazine") then {
                private _capacity = getNumber (configFile >> "CfgMagazines" >> _class >> "count") max 1;
                _quantity = _quantity max (ceil (_refill / _capacity));
            };
            _cost = _cost + (_e select 2) * _quantity;
            if (_added > 0 && {(_e select 2) > 0}) then {_purchases pushBack [_class,_added];};
        };
    };
} forEach _new;
[_valid,_cost,_purchases]
