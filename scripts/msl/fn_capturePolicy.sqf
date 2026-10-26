// Pure capture decision: no numeric superiority bypass, no armor or enemy in the core.
params ["_enemies","_coreEnemies","_presence","_armor","_suppressionTime","_coreTime"];
_presence && {!_armor} && {_enemies <= MSL_captureResidual} && {_coreEnemies == 0} && {_coreTime >= MSL_captureHold} && {_enemies == 0 || {_suppressionTime >= MSL_captureSuppression}}
