// Strength remaining from territorial logistics plus recent convoy disruption.
private _sites = sectors_factory + sectors_military;
private _remaining = { !(_x in blufor_sectors) } count _sites;
private _factor = 1;
if !(_sites isEqualTo []) then {_factor = 0.25 + 0.75 * (_remaining / count _sites);};
(_factor * (1 - (missionNamespace getVariable ["MSL_supplyPressure", 0]))) max 0.15
