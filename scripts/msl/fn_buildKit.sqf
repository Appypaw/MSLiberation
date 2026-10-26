// Server-only equipment builder. Empty id produces a uniform-only spawn loadout.
if (!isServer || {isRemoteExecuted && {!(missionNamespace getVariable ["MSL_internal",false])}}) exitWith {[]};
params [["_id", "", [""]]];
private _row = [];
if (_id != "") then {
    private _i = MSL_freeKits findIf {(_x select 0) == _id};
    if (_i >= 0) then {_row = MSL_freeKits select _i;};
};
if (_id != "" && {_row isEqualTo []}) exitWith {[]};
if !(_row isEqualTo []) then {
    if ([_row select 2,_row select 3] findIf {_x != "" && {!isClass (configFile >> "CfgWeapons" >> _x)}} >= 0) then {_row = [];};
};
if (_id != "" && {_row isEqualTo []}) exitWith {[]};
private _dummy = createAgent ["B_Soldier_F",[0,0,0],[],0,"NONE"];
_dummy hideObjectGlobal true; _dummy allowDamage false;
removeAllWeapons _dummy; removeAllItems _dummy; removeAllAssignedItems _dummy;
removeUniform _dummy; removeVest _dummy; removeBackpack _dummy; removeHeadgear _dummy; removeGoggles _dummy;
private _uniform = MSL_spawnUniform;
if (!isClass (configFile >> "CfgWeapons" >> _uniform)) then {_uniform = "U_B_CombatUniform_mcam";};
_dummy forceAddUniform _uniform;
private _valid = true;
if !(_row isEqualTo []) then {
    _dummy addVest "PRACS_CIRAS_rifleman";
    _dummy addHeadgear "PRACS_LWH";
    _dummy addBackpack "PRACS_FieldPack";
    if (vest _dummy == "") then {_dummy addVest "V_PlateCarrier1_rgr";};
    if (headgear _dummy == "") then {_dummy addHeadgear "H_HelmetB";};
    if (backpack _dummy == "") then {_dummy addBackpack "B_AssaultPack_rgr";};
    {
        private _weapon = _x;
        if (_weapon != "") then {
            private _mags = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
            private _well = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazineWell");
            {private _cfg = configFile >> "CfgMagazineWells" >> _x; {_mags append getArray _x;} forEach (configProperties [_cfg,"isArray _x",true]);} forEach _well;
            _mags = _mags select {isClass (configFile >> "CfgMagazines" >> _x)};
            if (_mags isEqualTo []) then {_valid = false;} else {
                private _mag = _mags select 0;
                private _standard = ["PRACS_20rd_G3_mag","PRACS_30rd_HK33_mag","rhs_mag_maaws_HEAT","rhs_fim92_mag"];
                {if (_x in _mags) exitWith {_mag = _x;};} forEach _standard;
                private _count = [6,2] select (_forEachIndex == 1);
                if (_id == "mg" && {_forEachIndex == 0}) then {_count = 3;};
                _dummy addMagazines [_mag,_count]; _dummy addWeapon _weapon;
                if !(_weapon in weapons _dummy) then {_valid = false;};
            };
        };
    } forEach [_row select 2,_row select 3];
    {_dummy linkItem _x;} forEach ["ItemMap","ItemCompass","ItemWatch","ItemRadio"];
    {_dummy addItem _x;} forEach ["FirstAidKit","FirstAidKit","SmokeShellGreen","SmokeShellGreen","Chemlight_green","Chemlight_green"];
};
private _kit = getUnitLoadout _dummy; deleteVehicle _dummy;
if (!_valid) exitWith {[]};
_kit
