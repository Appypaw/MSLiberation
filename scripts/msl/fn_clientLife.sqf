if (!hasInterface || {!MSL_enabled} || {isRemoteExecuted}) exitWith {};
if (player getVariable ["MSL_clientReady", false]) exitWith {};
player setVariable ["MSL_clientReady", true];
player setVariable ["MSL_language",profileNamespace getVariable ["MSL_language","ko"],true];
[player, "sync", []] remoteExecCall ["MSL_fnc_request", 2];
private _arsenalAction = player addAction [(["<t color='#80d8ff'>무기고</t>","<t color='#80d8ff'>Arsenal</t>"] call MSL_fnc_text), {[] call MSL_fnc_arsenal;}, nil, -735, false, true, "", "alive _this && {[_this] call MSL_fnc_atBase}"];
private _dogtagAction = player addAction [(["<t color='#e9be70'>적 독택 회수</t>","<t color='#e9be70'>Collect enemy dogtag</t>"] call MSL_fnc_text), {
    private _body = cursorObject;
    [player,"dogtag",[_body]] remoteExecCall ["MSL_fnc_request",2];
},nil,-734,false,true,"","alive _this && {!isNull cursorObject} && {!alive cursorObject} && {cursorObject getVariable ['MSL_dogtagEligible',false]} && {!(cursorObject getVariable ['MSL_dogtagTaken',false])} && {_this distance cursorObject <= MSL_dogtagRange}"];
private _tabletAction = player addAction [(["<t color='#80d8ff'>태블릿</t>","<t color='#80d8ff'>Tablet</t>"] call MSL_fnc_text), {[] call MSL_fnc_supportTablet;}, nil, -737, false, true, "", "alive _this"];
player setVariable ["MSL_actionLabels",[
    [_arsenalAction,"<t color='#80d8ff'>무기고</t>","<t color='#80d8ff'>Arsenal</t>"],
    [_dogtagAction,"<t color='#e9be70'>적 독택 회수</t>","<t color='#e9be70'>Collect enemy dogtag</t>"],
    [_tabletAction,"<t color='#80d8ff'>태블릿</t>","<t color='#80d8ff'>Tablet</t>"]
]];
player addEventHandler ["InventoryOpened", {player getVariable ["MSL_econBusy", false]}];
player addEventHandler ["FiredMan", {
    private _unit = _this select 0; private _projectile = _this select 6; private _ammo = _this select 4;
    if (!isNull _projectile && {_ammo in (MSL_supplySignalsDay + MSL_supplySignalsNight)}) then {
        [_unit, _projectile] spawn {
            params ["_unit", "_projectile"]; sleep 0.3;
            if (!isNull _projectile) then {[_unit, "signal", [_projectile]] remoteExecCall ["MSL_fnc_request", 2];};
            sleep 0.7;
            if (!isNull _projectile) then {[_unit, "signal", [_projectile]] remoteExecCall ["MSL_fnc_request", 2];};
        };
    };
}];
player addEventHandler ["Take", {
    params ["_unit", "_container", "_class"];
    [_unit, _container, _class] spawn {
        params ["_unit", "_container", "_class"];
        sleep 0.5;
        [_unit, "loot", [_container, _class]] remoteExecCall ["MSL_fnc_request", 2];
        sleep 1;
        [_unit, "loot", [_container, _class]] remoteExecCall ["MSL_fnc_request", 2];
    };
}];
