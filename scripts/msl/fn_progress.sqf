// [level, current threshold, next threshold, fraction], capped at configured maximum.
params [["_xp",0,[0]]];
private _level = 1;
{if (_xp >= _x) then {_level = _forEachIndex + 1;};} forEach MSL_levelThresholds;
private _start = MSL_levelThresholds select (_level - 1);
private _next = MSL_levelThresholds param [_level, _start];
private _fraction = 1;
if (_next > _start) then {_fraction = ((_xp - _start) / (_next - _start)) max 0 min 1;};
[_level,_start,_next,_fraction]
