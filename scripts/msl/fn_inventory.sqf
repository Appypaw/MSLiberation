params [["_unit", objNull, [objNull]]];
if (_unit isKindOf "Man") exitWith {[getUnitLoadout _unit] call MSL_fnc_loadoutInventory};
private _cargo = [[],[],[],["",[]],[],[],"","",[],[]];
private _contents = [];
{_contents pushBack [_x select 0,1,_x select 1];} forEach magazinesAmmoCargo _unit;
private _items = getItemCargo _unit;
{_contents pushBack [_x, (_items select 1) select _forEachIndex];} forEach (_items select 0);
{_contents pushBack [_x, 1];} forEach weaponsItemsCargo _unit;
_cargo set [3,["",_contents]];
[_cargo] call MSL_fnc_loadoutInventory
