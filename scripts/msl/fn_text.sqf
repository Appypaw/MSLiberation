// Client-owned display preference only; never used for gameplay permissions.
// Servers pass the recipient's preference explicitly, so mixed languages coexist.
params ["_korean","_english",["_language",profileNamespace getVariable ["MSL_language","ko"]]];
if (_language == "en") then {_english} else {_korean}
