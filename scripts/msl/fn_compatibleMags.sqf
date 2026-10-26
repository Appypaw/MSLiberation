// Engine compatibility includes magazine wells and every muzzle (including UGLs).
// Compare case-insensitively: engine-returned names may differ from mod config case.
params [["_weapon","",[""]]];
private _key = "MSL_compatibleMags_" + _weapon;
private _cached = missionNamespace getVariable [_key,-1];
if (_cached isEqualType []) exitWith {_cached};
private _compatible = (compatibleMagazines _weapon) apply {toLower _x};
private _rows = [];
{
    if ((_x select 4) == "magazine" && {toLower (_x select 0) in _compatible}) then {
        _rows pushBack [_x select 3,toLower (_x select 1),_x select 0,_x];
    };
} forEach MSL_shopEntries;
_rows sort true;
private _entries = _rows apply {_x select 3};
missionNamespace setVariable [_key,_entries];
_entries
