params [["_unit",objNull,[objNull]]];
!isNull _unit && {alive _unit} && {side group _unit == GRLIB_side_friendly} && {vehicle _unit == _unit} && {getMarkerColor GRLIB_respawn_marker != ""} && {[_unit,MSL_terminalRadius] call MSL_fnc_atMainBase}
