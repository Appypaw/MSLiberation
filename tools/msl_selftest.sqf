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
private _freeFamilyWeapons = MSL_shopEntries select {(_x select 4) == "weapon" && {private _name = toLower (_x select 0); MSL_freeWeaponFamilies findIf {(_name find _x) >= 0} >= 0}};
[(count _freeFamilyWeapons > 0) && {_freeFamilyWeapons findIf {(_x select 2) != 0 || {(_x select 3) != 0}} < 0}, "all starter weapon family variants are free at level zero"] call _assert;
private _racsUniforms = MSL_shopEntries select {
    private _n = toLower (_x select 0);
    (_n find "pracs_") == 0 && {(_n find "pracs_sla") != 0} && {getNumber (configFile >> "CfgWeapons" >> (_x select 0) >> "ItemInfo" >> "type") == 801}
};
[(count _racsUniforms > 0) && {_racsUniforms findIf {(_x select 2) != 0 || {(_x select 3) != 0}} < 0}, "RACS uniforms are level zero and free"] call _assert;
private _shopMags = MSL_shopEntries select {(_x select 4) == "magazine"};
[(count _shopMags > 0) && {_shopMags findIf {(_x select 2) <= 0} < 0}, "all shop ammunition has a positive purchase price"] call _assert;
[_shopMags findIf {!((_x select 0) in MSL_import_magazines)} < 0, "shop ammunition comes from the imported whitelist"] call _assert;
[(MSL_shopClasses arrayIntersect MSL_shopClasses) isEqualTo MSL_shopClasses, "expanded catalog contains no duplicate classes"] call _assert;
// Quote real whitelist entries without changing accounts or issuing equipment.
private _emptyGear = [[],[],[],[],[],[],"","",[],[]];
private _testEntry = MSL_shopEntries select {(_x select 4) == "magazine" && {(_x select 2) > 0}};
if !(_testEntry isEqualTo []) then {
    private _e = _testEntry select 0;
    private _magClass = _e select 0;
    private _capacity = getNumber (configFile >> "CfgMagazines" >> _magClass >> "count") max 1;
    private _gear = [[],[],[],[MSL_spawnUniform,[[_magClass,2,_capacity]]],[],[],"","",[],[]];
    private _base = [[],[],[],[MSL_spawnUniform,[]],[],[],"","",[],[]];
    private _q = [_base,_gear,100] call MSL_fnc_arsenalQuote;
    [(_q select 0) && {(_q select 1) == 2 * (_e select 2)}, "arsenal charges per additional magazine"] call _assert;
    _q = [_gear,_gear,100] call MSL_fnc_arsenalQuote;
    [(_q select 0) && {(_q select 1) == 0}, "arsenal unchanged equipment costs nothing"] call _assert;
    _q = [_gear,_base,100] call MSL_fnc_arsenalQuote;
    [(_q select 0) && {(_q select 1) == 0}, "arsenal removals do not mint refunds"] call _assert;
    _q = [_base,_gear,-1] call MSL_fnc_arsenalQuote;
    [!(_q select 0), "arsenal rejects equipment above the player's level"] call _assert;
    private _partial = [[],[],[],[MSL_spawnUniform,[[_magClass,2,0]]],[],[],"","",[],[]];
    _q = [_partial,_gear,100] call MSL_fnc_arsenalQuote;
    [(_q select 1) == 2 * (_e select 2), "arsenal refilling empty magazines is charged"] call _assert;
};
private _invalidGear = [[],[],[],[MSL_spawnUniform,[["MSL_invalid_equipment",1]]],[],[],"","",[],[]];
[!(([_emptyGear,_invalidGear,100] call MSL_fnc_arsenalQuote) select 0), "arsenal rejects classes outside the server whitelist"] call _assert;
// Compatibility browser: use real engine data with an isolated catalog fixture.
isNil {
    private _savedEntries = MSL_shopEntries;
    private _key = "MSL_compatibleMags_arifle_MX_GL_F";
    private _savedCache = missionNamespace getVariable [_key,-1];
    missionNamespace setVariable [_key,-1];
    MSL_shopEntries = [
        ["30Rnd_65x39_caseless_mag","Rifle magazine",60,1,"magazine"],
        ["1Rnd_HE_Grenade_shell","UGL round",180,3,"magazine"],
        ["MSL_INCOMPATIBLE_MAG","Invalid magazine",60,1,"magazine"]
    ];
    private _rows = ["arifle_MX_GL_F"] call MSL_fnc_compatibleMags;
    private _classes = _rows apply {_x select 0};
    ["30Rnd_65x39_caseless_mag" in _classes, "browser finds compatible rifle magazines"] call _assert;
    ["1Rnd_HE_Grenade_shell" in _classes, "browser includes underbarrel launcher ammunition"] call _assert;
    [!("MSL_INCOMPATIBLE_MAG" in _classes), "browser excludes incompatible magazines"] call _assert;
    [count _rows == 2 && {(_rows select 0 select 3) == 1} && {(_rows select 1 select 3) == 3}, "browser sorts compatible magazines by unlock level"] call _assert;
    MSL_shopEntries = [["30RND_65X39_CASELESS_MAG","Case variant",60,1,"magazine"]];
    missionNamespace setVariable [_key,-1];
    [count (["arifle_MX_GL_F"] call MSL_fnc_compatibleMags) == 1, "browser matches magazine class names case insensitively"] call _assert;
    MSL_shopEntries = _savedEntries;
    missionNamespace setVariable [_key,_savedCache];
};
// Every cumulative threshold must switch exactly at its boundary.
{
    private _tier = _forEachIndex + 1;
    private _at = [_x] call MSL_fnc_progress;
    [(_at select 0) == _tier,format ["XP boundary enters tier %1",_tier]] call _assert;
    [(_at select 3) >= 0 && {(_at select 3) <= 1},format ["tier %1 fraction is bounded",_tier]] call _assert;
    if (_tier > 1) then {
        private _before = [_x - 1] call MSL_fnc_progress;
        [(_before select 0) == _tier - 1,format ["tier %1 stays locked below threshold",_tier]] call _assert;
    };
} forEach MSL_levelThresholds;

// Starter arms must always have an affordable, level-zero compatible magazine.
{
    private _w = _x;
    private _rows = [_w select 0] call MSL_fnc_compatibleMags;
    [_rows findIf {(_x select 3) <= (_w select 3)} >= 0,format ["starter ammunition unlocked with %1",_w select 0]] call _assert;
} forEach _freeFamilyWeapons;
private _lockedMags = MSL_shopEntries select {(_x select 4) == "magazine" && {(_x select 3) > 1}};
[count _lockedMags > 0,"special/high-tier magazines remain locked at recruit level"] call _assert;
{
    private _m = _x select 0;
    private _gear = [[],[],[],[MSL_spawnUniform,[[_m,1,1]]],[],[],"","",[],[]];
    private _base = [[],[],[],[MSL_spawnUniform,[]],[],[],"","",[],[]];
    [!(([_base,_gear,1] call MSL_fnc_arsenalQuote) select 0),format ["server rejects locked magazine %1",_m]] call _assert;
} forEach (_lockedMags select [0,20]);

// Explicit language arguments isolate the checks from any host profile preference.
[(["한국어","English","ko"] call MSL_fnc_text) == "한국어","Korean UI selection"] call _assert;
[(["한국어","English","en"] call MSL_fnc_text) == "English","English UI selection"] call _assert;
[(["기본값","Fallback","invalid"] call MSL_fnc_text) == "기본값","unknown language falls back safely"] call _assert;
[(format [(["%1에게 $%2","$%2 to %1","en"] call MSL_fnc_text),"Ally",100]) == "$100 to Ally","translated argument order"] call _assert;

diag_log format ["[MSL TEST RESULT] %1 passed; %2 failed", _passed, _failed];
systemChat format ["MSL self-test: %1 passed / %2 failed (see RPT)", _passed, _failed];
