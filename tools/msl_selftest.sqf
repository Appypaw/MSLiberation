/* Server-local assertions. Run on a test mission after MSL_ready, never remoteExec.
   [] execVM "tools\msl_selftest.sqf";
   Does not write profiles, issue gear or modify live accounts. Results go to RPT.
*/
if (!isServer || {isRemoteExecuted} || {!(missionNamespace getVariable ["MSL_ready", false])}) exitWith {diag_log "[MSL TEST] server not ready";};
private _failed = 0;
private _passed = 0;
private _assert = {
    params ["_ok", "_name"];
    if (_ok) then {_passed = _passed + 1; diag_log ("[MSL TEST PASS] " + _name);} else {_failed = _failed + 1; diag_log ("[MSL TEST FAIL] " + _name);};
};
private _weapon = ["arifle_MX_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",17],[],""];
private _loadout = [_weapon,[],[],["U_B_CombatUniform_mcam",[["FirstAidKit",2],["30Rnd_65x39_caseless_mag",2,8]]],["V_PlateCarrier1_rgr",[]],["B_AssaultPack_mcamo",[[["hgun_P07_F","","","",[],[],""],1]]],"H_HelmetB","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];
private _rows = [_loadout] call MSL_fnc_loadoutInventory;
private _mag = _rows select {(_x select 0) == "30Rnd_65x39_caseless_mag"};
[(_mag select 0) isEqualTo ["30Rnd_65x39_caseless_mag",3,33], "counts loaded and partial spare magazines once"] call _assert;
[(_rows select {(_x select 0) == "hgun_P07_F"}) isEqualTo [["hgun_P07_F",1,0]], "counts cargo weapons"] call _assert;
[(_rows select {(_x select 0) == "optic_Aco"}) isEqualTo [["optic_Aco",1,0]], "counts mounted optics once"] call _assert;
private _sold = [_loadout,"FirstAidKit"] call MSL_fnc_removeFromLoadout;
private _remaining = ([_sold] call MSL_fnc_loadoutInventory) select {(_x select 0) == "FirstAidKit"};
[(_remaining select 0) select 1 == 1, "selling stacked items removes exactly one"] call _assert;
[(_loadout select 3 select 1 select 0 select 1) == 2, "removal does not mutate original loadout"] call _assert;
[([_loadout,"arifle_MX_F"] call MSL_fnc_removeFromLoadout) isEqualTo [], "refuses bundled loaded/attached weapon sale"] call _assert;
private _noOptic = [_loadout,"optic_Aco"] call MSL_fnc_removeFromLoadout;
[(_noOptic select 0 select 3) == "", "mounted optics can be sold separately"] call _assert;
private _noCargoGun = [_loadout,"hgun_P07_F"] call MSL_fnc_removeFromLoadout;
[(_noCargoGun select 5 select 1) isEqualTo [], "empty cargo weapon can be sold"] call _assert;
[([_loadout,"U_B_CombatUniform_mcam"] call MSL_fnc_removeFromLoadout) isEqualTo [], "refuses nonempty clothing sale"] call _assert;
private _noVest = [_loadout,"V_PlateCarrier1_rgr"] call MSL_fnc_removeFromLoadout;
[(_noVest select 4) isEqualTo [], "empty vest can be sold"] call _assert;
[([_loadout,"missing_class"] call MSL_fnc_removeFromLoadout) isEqualTo [], "missing inventory item is rejected"] call _assert;
[(["missing_class"] call MSL_fnc_catalog) isEqualTo [], "missing catalog config is rejected"] call _assert;
[((([0] call MSL_fnc_progress) select 0) == 1), "zero XP starts at level one"] call _assert;
[((([MSL_levelThresholds select 1] call MSL_fnc_progress) select 0) == 2), "custom threshold unlocks the next level exactly"] call _assert;
[((([1e9] call MSL_fnc_progress) select 0) == count MSL_levelThresholds), "level caps at configured final tier"] call _assert;
[!([3,0,true,false,9999,9999] call MSL_fnc_capturePolicy), "three enemies cannot be bypassed by rushing the core"] call _assert;
[!([1,0,true,false,MSL_captureSuppression - 1,MSL_captureHold] call MSL_fnc_capturePolicy), "residual enemy requires full suppression duration"] call _assert;
[([2,0,true,false,MSL_captureSuppression,MSL_captureHold] call MSL_fnc_capturePolicy), "two stragglers allowed after suppression and core hold"] call _assert;
[!([1,1,true,false,9999,9999] call MSL_fnc_capturePolicy), "enemy inside the core still contests capture"] call _assert;
[!([0,0,true,true,9999,9999] call MSL_fnc_capturePolicy), "active armor blocks capture"] call _assert;
[([0,0,true,false,0,MSL_captureHold] call MSL_fnc_capturePolicy), "fully cleared sector only requires the core hold"] call _assert;
isNil {
private _savedAccounts = MSL_accounts;
private _savedCache = missionNamespace getVariable ["MSL_account_MSL_SELFTEST", -1];
MSL_accounts = [];
private _a = ["MSL_SELFTEST"] call MSL_fnc_account;
[_a select 1 == MSL_startingCash && {count _a == 10}, "new account has configured funds and schema"] call _assert;
_a set [1,100];
[(((["MSL_SELFTEST"] call MSL_fnc_account) select 1) == 100) && {count MSL_accounts == 1}, "account lookup preserves updates without duplicates"] call _assert;
[([""] call MSL_fnc_account) isEqualTo [], "empty UID cannot open an account"] call _assert;
// A stale cached index must never refer to another UID or detached account.
MSL_accounts = [["MSL_OTHER", 1]];
private _fresh = ["MSL_SELFTEST"] call MSL_fnc_account;
[(_fresh select 1) == MSL_startingCash && {count MSL_accounts == 2}, "cached index revalidates after account array replacement"] call _assert;
MSL_accounts = _savedAccounts;
missionNamespace setVariable ["MSL_account_MSL_SELFTEST", _savedCache];
};
diag_log format ["[MSL TEST RESULT] %1 passed; %2 failed", _passed, _failed];
systemChat format ["MSL self-test: %1 passed / %2 failed (see RPT)", _passed, _failed];
