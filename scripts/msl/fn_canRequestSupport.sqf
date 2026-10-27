// Shared by the tablet, group actions and the server airdrop dispatcher.
params [["_unit",objNull,[objNull]]];
!isNull _unit && {alive _unit} && {isPlayer _unit} && {side group _unit == GRLIB_side_friendly} && {_unit == leader group _unit}
