params [["_unit",objNull,[objNull]]];
!isNull _unit && {alive _unit} && {side group _unit == GRLIB_side_friendly} && {vehicle _unit == _unit} && {getPosATL _unit select 2 < 10} && {getMarkerColor GRLIB_respawn_marker != ""} && {_unit distance2D ([] call MSL_fnc_basePosition) <= MSL_terminalRadius}
