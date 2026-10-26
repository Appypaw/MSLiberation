if (!hasInterface || {!MSL_enabled} || {isRemoteExecuted}) exitWith {};
if (player getVariable ["MSL_clientReady", false]) exitWith {};
player setVariable ["MSL_clientReady", true];
[player, "sync", []] remoteExecCall ["MSL_fnc_request", 2];
player addAction ["<t color='#80d8ff'>개인 보급소 / 상점 / 노획품 판매</t>", {[] call MSL_fnc_menu;}, nil, -735, false, true, "", "alive _this && {[_this] call MSL_fnc_atBase}"];
player addAction ["<t color='#80d8ff'>개인 스탯 / 아군 송금</t>", {["progress"] call MSL_fnc_menu;}, nil, -736, false, true, "", "[_this] call MSL_fnc_atTerminal"];
player addAction ["<t color='#e9be70'>적 독택 회수</t>", {
    private _body = cursorObject;
    [player,"dogtag",[_body]] remoteExecCall ["MSL_fnc_request",2];
},nil,-734,false,true,"","alive _this && {!isNull cursorObject} && {!alive cursorObject} && {cursorObject getVariable ['MSL_dogtagEligible',false]} && {!(cursorObject getVariable ['MSL_dogtagTaken',false])} && {_this distance cursorObject <= MSL_dogtagRange}"];
player addAction ["<t color='#80d8ff'>후방 Evac / 분대 헬기 철수 요청</t>", {[player,"evac",[]] remoteExecCall ["MSL_fnc_request",2];},nil,-736.5,false,true,"","alive _this && {vehicle _this == _this} && {!([_this] call MSL_fnc_atBase)}"];
player addAction ["AI 공중보급: 탄약 (연막/플레어 표시)", {[player, "airdrop", ["ammo"]] remoteExecCall ["MSL_fnc_request", 2];}, nil, -737, false, true, "", "alive _this"];
player addAction ["AI 공중보급: 의료품 (연막/플레어 표시)", {[player, "airdrop", ["medical"]] remoteExecCall ["MSL_fnc_request", 2];}, nil, -738, false, true, "", "alive _this"];
player addAction ["AI 공중보급: 팀 자원 (연막/플레어 표시)", {[player, "airdrop", ["resources"]] remoteExecCall ["MSL_fnc_request", 2];}, nil, -739, false, true, "", "alive _this"];
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
