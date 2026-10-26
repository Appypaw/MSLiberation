if (isRemoteExecuted) exitWith {};
[] spawn {
    waitUntil {sleep 0.25; missionNamespace getVariable ["KPLIB_init", false]};
    if (!MSL_enabled) exitWith {};
    if (isServer) then {
        waitUntil {sleep 0.25; missionNamespace getVariable ["save_is_loaded", false]};
        MSL_saveKey = GRLIB_save_key + "_MSL_V1";
        private _saved = profileNamespace getVariable [MSL_saveKey, [1, [], [], 0]];
        if (GRLIB_param_wipe_savegame_1 == 1 && {GRLIB_param_wipe_savegame_2 == 1}) then {_saved = [1, [], [], 0];};
        MSL_accounts = _saved param [1, []];
        MSL_saveDirty = false;
        MSL_supportCleanup = [];
        MSL_destroyedTowers = _saved param [2, []];
        MSL_supplyPressure = _saved param [3, 0];
        publicVariable "MSL_destroyedTowers"; publicVariable "MSL_supplyPressure";
        MSL_scenarioQueue = []; MSL_nextScenario = 0; MSL_defenseActive = false;
        MSL_evacRequests = []; MSL_evacActive = false; MSL_nextEvac = 0;
        MSL_dropRequests = []; MSL_nextDrop = 0; MSL_dropActive = false;
        if (isNil "GRLIB_arsenal_weapons") then {[] call compileFinal preprocessFileLineNumbers "arsenal_presets\custom.sqf";};
        [] call compileFinal preprocessFileLineNumbers "scripts\msl\import_equipment.sqf";
        MSL_shopClasses = []; MSL_shopEntries = [];
        {
            {private _entry = [_x] call MSL_fnc_catalog; if (!(_entry isEqualTo []) && {!(_x in MSL_shopClasses)}) then {MSL_shopClasses pushBack _x; MSL_shopEntries pushBack _entry;};} forEach _x;
        } forEach [GRLIB_arsenal_weapons, GRLIB_arsenal_magazines, GRLIB_arsenal_items, GRLIB_arsenal_backpacks];
        [] call MSL_fnc_linkMagazineUnlocks;
        publicVariable "MSL_shopClasses"; publicVariable "MSL_shopEntries";
        MSL_ready = true; publicVariable "MSL_ready";
        // Native global event works with server- and HC-owned AI, without duplicate MPKilled payouts.
        addMissionEventHandler ["EntityKilled", {
            params ["_dead", "_killer", "_instigator"];
            if (_dead isKindOf "Man" && {side group _dead == GRLIB_side_enemy}) then {
                _dead setVariable ["MSL_dogtagEligible",true,true];
                _dead setVariable ["MSL_lootStock", [_dead] call MSL_fnc_inventory];
                {if (!isNull _x) then {_x setVariable ["MSL_lootOwner", _dead];};} forEach [uniformContainer _dead, vestContainer _dead, backpackContainer _dead];
                [_dead] spawn {
                    params ["_dead"]; sleep 0.3;
                    if (isNull _dead) exitWith {};
                    private _issued = _dead getVariable ["MSL_issuedWeapons", getArray (configFile >> "CfgVehicles" >> typeOf _dead >> "weapons")];
                    private _holders = nearestObjects [_dead, ["WeaponHolderSimulated", "GroundWeaponHolder"], 4];
                    private _linked = [];
                    private _stock = _dead getVariable ["MSL_lootStock", []];
                    {
                        private _holder = _x;
                        private _rows = [_holder] call MSL_fnc_inventory;
                        if (isNull (_holder getVariable ["MSL_lootOwner", objNull]) && {_rows findIf {(_x select 0) in _issued} >= 0}) then {
                            _holder setVariable ["MSL_lootOwner", _dead]; _linked pushBack _holder;
                            {
                                private _row = _x;
                                if (_stock findIf {(_x select 0) == (_row select 0)} < 0) then {_stock pushBack _row;};
                            } forEach _rows;
                        };
                    } forEach _holders;
                    _dead setVariable ["MSL_lootStock", _stock]; _dead setVariable ["MSL_lootHolders", _linked];
                };
                if (isNull _instigator) then {_instigator = _killer;};
                if (isPlayer _instigator && {side group _instigator == GRLIB_side_friendly}) then {
                    private _a = [getPlayerUID _instigator] call MSL_fnc_account;
                    _a set [2, (_a select 2) + MSL_killXP]; _a set [3, (_a select 3) + 1];
                    [_instigator] call MSL_fnc_publish;
                };
            };
            if (isPlayer _dead && {side group _dead == GRLIB_side_friendly}) then {
                [_dead, true] call MSL_fnc_settle;
                private _a = [getPlayerUID _dead] call MSL_fnc_account;
                _a set [4, (_a select 4) + 1]; _a set [7, []]; _a set [8, []]; _a set [9, []];
                [] call MSL_fnc_persist;
            };
        }];
        addMissionEventHandler ["EntityRespawned", {
            params ["_unit", "_old"];
            if (isPlayer _unit) then {_unit setVariable ["MSL_joined", false]; _unit setVariable ["MSL_pending", []]; _unit setVariable ["MSL_ack", false];};
        }];
        addMissionEventHandler ["HandleDisconnect", {
            params ["_unit", "_id", "_uid"];
            if (_uid != "") then {
                if (!isNull _unit) then {[_unit, true] call MSL_fnc_settle;};
                private _a = [_uid] call MSL_fnc_account;
                if (!isNull _unit && {alive _unit} && {(_a param [9, []]) isEqualTo []}) then {_a set [7, getUnitLoadout _unit];};
                [] call MSL_fnc_persist;
            };
            false
        }];
        [] spawn MSL_fnc_campaignLoop;
        [] spawn MSL_fnc_scenarioLoop;
        [] spawn {
            private _nextSave = time + 60;
            private _nextGear = time;
            private _nextCommit = time + 2;
            while {GRLIB_endgame == 0} do {
                if !(MSL_dropRequests isEqualTo []) then {(MSL_dropRequests deleteAt 0) spawn MSL_fnc_airdrop;};
                private _snapshotGear = time >= _nextGear;
                {
                    if (isPlayer _x && {alive _x} && {_x getVariable ["MSL_joined", false]}) then {
                        private _p = _x getVariable ["MSL_pending", []];
                        if !(_p isEqualTo []) then {
                            [_x] call MSL_fnc_settle;
                            if (diag_tickTime > (_p select 1) + 10 && {!((_x getVariable ["MSL_pending", []]) isEqualTo [])}) then {
                                _p set [1, diag_tickTime];
                                [_x, _p select 2, _p select 0] remoteExecCall ["MSL_fnc_applyGear", owner _x];
                            };
                        } else {
                            if (_snapshotGear) then {
                                private _a = [getPlayerUID _x] call MSL_fnc_account;
                                _a set [7, getUnitLoadout _x];
                            };
                        };
                    };
                } forEach allPlayers;
                if (_snapshotGear) then {_nextGear = time + 10;};
                if (time >= _nextCommit) then {
                    if (MSL_saveDirty) then {[] call MSL_fnc_persist;};
                    _nextCommit = time + 2;
                };
                if (time >= _nextSave) then {[] call MSL_fnc_persist; _nextSave = time + 60;};
                sleep 1;
            };
            [] call MSL_fnc_persist;
        };
    };
    if (hasInterface) then {
        waitUntil {sleep 0.25; missionNamespace getVariable ["MSL_ready", false] && {!isNull player} && {alive player}};
        [] call MSL_fnc_clientLife;
        player addEventHandler ["Respawn", {[] spawn {sleep 1; player setVariable ["MSL_clientReady", false]; [] call MSL_fnc_clientLife;};}];
    };
};
