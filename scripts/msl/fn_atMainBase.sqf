// Shared client/server main-base check, including the Freedom flight deck.
params [["_unit", objNull, [objNull]], ["_radius", 100, [0]]];
if (isNull _unit || {!alive _unit}) exitWith {false};
private _base = [] call MSL_fnc_basePosition;
private _baseASL = ATLToASL _base;
private _height = abs ((getPosASL _unit select 2) - (_baseASL select 2));
if (_height > 10) exitWith {false};
if (_unit distance2D _base <= _radius) exitWith {true};
// Extend the startup base across its carrier, without admitting the sea below
// or making unrelated ships elsewhere into shops.
private _onDeck = false;
{
    private _local = _x worldToModel (getPosATL _unit);
    if (abs (_local select 0) <= 55 && {abs (_local select 1) <= 180}) exitWith {_onDeck = true;};
} forEach (nearestObjects [_base, ["Land_Carrier_01_base_F"], 250]);
_onDeck
