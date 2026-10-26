// Match KP's actual redeployment base, which can differ from the initial respawn marker.
if (!isNil "startbase" && {!isNull startbase}) exitWith {getPosATL startbase};
markerPos GRLIB_respawn_marker
