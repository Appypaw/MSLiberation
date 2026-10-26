if (!hasInterface || {isRemoteExecuted}) exitWith {};
if (missionNamespace getVariable ["MSL_arsenalOpening",false]) exitWith {};
MSL_arsenalOpening = true;
[] spawn {
    disableSerialization;
    if (!alive player || {!([player] call MSL_fnc_atBase)} || {vehicle player != player} || {player getVariable ["MSL_econBusy",false]} || {dialog} || {!isNull (uiNamespace getVariable ["BIS_fnc_arsenal_display",displayNull])}) exitWith {MSL_arsenalOpening = false;};
    private _unit = player;
    private _requestId = format ["%1_%2",clientOwner,diag_tickTime];
    // Wait for the server catalog and the initial equipment transaction before opening.
    if (!(missionNamespace getVariable ["MSL_ready",false])) then {systemChat "무기고 준비 중입니다. 서버 초기화를 기다립니다.";};
    private _timeout = diag_tickTime + 120;
    waitUntil {sleep 0.2; !alive _unit || {player != _unit} || {diag_tickTime > _timeout} || {(missionNamespace getVariable ["MSL_ready",false]) && {!(_unit getVariable ["MSL_econBusy",false])}}};
    if (!alive _unit || {player != _unit} || {!(missionNamespace getVariable ["MSL_ready",false])} || {_unit getVariable ["MSL_econBusy",false]}) exitWith {MSL_arsenalOpening = false; systemChat "개인 프로필 또는 무기고 초기화가 아직 끝나지 않았습니다. 잠시 후 다시 시도하세요.";};
    _timeout = diag_tickTime + 15;
    private _nextAttempt = 0;
    waitUntil {
        sleep 0.1;
        if (diag_tickTime >= _nextAttempt && {((_unit getVariable ["MSL_arsenalSession",[]]) param [3,""]) != _requestId}) then {
            [_unit,"arsenalOpen",[_requestId]] remoteExecCall ["MSL_fnc_request",2];
            _nextAttempt = diag_tickTime + 1.5;
        };
        ((_unit getVariable ["MSL_arsenalSession",[]]) param [3,""]) == _requestId || {diag_tickTime > _timeout} || {!alive _unit} || {player != _unit}
    };
    private _session = _unit getVariable ["MSL_arsenalSession",[]];
    if ((_session param [3,""]) != _requestId) exitWith {
        MSL_arsenalOpening = false;
        diag_log format ["[MSL ARSENAL TIMEOUT] request=%1 ready=%2 busy=%3 session=%4",_requestId,missionNamespace getVariable ["MSL_ready",false],_unit getVariable ["MSL_econBusy",false],_session param [3,""]];
        systemChat "무기고 응답을 받지 못했습니다. 본진 안에서 다시 시도하세요.";
    };
    private _before = _session select 1;
    private _level = ([(_unit getVariable ["MSL_stats",[0,0]]) select 1] call MSL_fnc_progress) select 0;
    private _entries = MSL_shopEntries select {(_x select 3) <= _level};
    private _allowed = _entries apply {toLower (_x select 0)};
    // Separate preview actor keeps actual equipment intact until server settlement.
    private _preview = createAgent ["B_Soldier_F",[100,100,10000],[],0,"CAN_COLLIDE"];
    _preview allowDamage false; _preview disableAI "ALL"; _preview enableSimulation false;
    _preview setUnitLoadout [_before,false];
    private _cargo = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
    [_cargo,(_entries select {(_x select 4) == "weapon"}) apply {_x select 0},false,false] call BIS_fnc_addVirtualWeaponCargo;
    [_cargo,(_entries select {(_x select 4) == "magazine"}) apply {_x select 0},false,false] call BIS_fnc_addVirtualMagazineCargo;
    [_cargo,(_entries select {(_x select 4) in ["item","goggles"]}) apply {_x select 0},false,false] call BIS_fnc_addVirtualItemCargo;
    [_cargo,(_entries select {(_x select 4) == "backpack"}) apply {_x select 0},false,false] call BIS_fnc_addVirtualBackpackCargo;
    ["Open",[false,_cargo,_preview]] spawn BIS_fnc_arsenal;
    _timeout = diag_tickTime + 30;
    waitUntil {sleep 0.1; !isNull (uiNamespace getVariable ["BIS_fnc_arsenal_display",displayNull]) || {diag_tickTime > _timeout}};
    private _d = uiNamespace getVariable ["BIS_fnc_arsenal_display",displayNull];
    private _cancel = isNull _d;
    if (!isNull _d) then {
        // Engine control IDs from A3/Ui_f/hpp/defineResinclDesign.inc.
        {(_d displayCtrl _x) ctrlShow false; (_d displayCtrl _x) ctrlEnable false;} forEach [44149,44150,44347];
        private _balance = _d ctrlCreate ["RscText",8890];
        _balance ctrlSetPosition [safeZoneX + safeZoneW * 0.32,safeZoneY + safeZoneH * 0.015,safeZoneW * 0.36,safeZoneH * 0.055];
        _balance ctrlSetBackgroundColor [0.015,0.025,0.035,0.95]; _balance ctrlCommit 0;
        private _browseUntil = diag_tickTime + 870;
        while {!isNull _d} do {
            if (!alive _unit || {player != _unit} || {!([_unit] call MSL_fnc_atBase)} || {diag_tickTime > _browseUntil}) exitWith {_cancel = true; _d closeDisplay 2;};
            private _quote = [_before,getUnitLoadout _preview,_level] call MSL_fnc_arsenalQuote;
            private _cash = (_unit getVariable ["MSL_stats",[0,0]]) select 0;
            _balance ctrlSetText (if (_quote select 0) then {format ["보유 $%1 | 결제 $%2 | 남은 현금 $%3",_cash,_quote select 1,_cash - (_quote select 1)]} else {"잠긴 장비 포함: 결제 불가 — 변경 후 닫으면 장비 변경이 취소됩니다."});
            _balance ctrlSetTextColor ([[1,0.35,0.3,1],[0.8,0.95,0.8,1]] select ((_quote select 0) && {(_quote select 1) <= _cash}));
            // Vanilla adds currently worn gear to its lists; hide locked entries too.
            for "_tab" from 0 to 26 do {
                if (!(_tab in [15,16,17])) then {
                    private _list = _d displayCtrl (960 + _tab);
                    if (ctrlType _list == 102) then {
                        for "_i" from ((lnbSize _list select 0) - 1) to 0 step -1 do {
                            private _class = toLower (_list lnbData [_i,0]);
                            if (_class != "") then {
                                if (!(_class in _allowed)) then {_list lnbDeleteRow _i;} else {
                                    private _e = _entries select (_allowed find _class);
                                    // Column 0 holds the icon/data, 1 the label, 2 the live quantity.
                                    private _label = _e select 1;
                                    private _short = if (count _label > 30) then {(_label select [0,27]) + "..."} else {_label};
                                    _list lnbSetText [[_i,1],format ["$%1 %2",_e select 2,_short]];
                                    private _columns = count lnbGetColumnsPosition _list;
                                    _list lbSetTooltip [_i * _columns,format ["%1 | $%2 | Lv.%3",_label,_e select 2,_e select 3]];
                                };
                            };
                        };
                    } else {
                        for "_i" from ((lbSize _list) - 1) to 0 step -1 do {
                            private _class = toLower (_list lbData _i);
                            if (_class != "") then {
                                if (!(_class in _allowed)) then {_list lbDelete _i;} else {
                                    private _e = _entries select (_allowed find _class);
                                    private _label = _e select 1;
                                    private _short = if (count _label > 34) then {(_label select [0,31]) + "..."} else {_label};
                                    _list lbSetText [_i,format ["$%1 %2",_e select 2,_short]];
                                    _list lbSetTooltip [_i,format ["%1 | $%2 | Lv.%3",_label,_e select 2,_e select 3]];
                                };
                            };
                        };
                    };
                };
            };
            sleep 0.2;
        };
    };
    private _chosen = getUnitLoadout _preview;
    deleteVehicle _preview; deleteVehicle _cargo;
    if (_cancel || {!alive _unit}) then {
        [_unit,"arsenalCancel",[_session select 0]] remoteExecCall ["MSL_fnc_request",2];
    } else {
        [_unit,"arsenalClose",[_session select 0,_chosen]] remoteExecCall ["MSL_fnc_request",2];
    };
    MSL_arsenalOpening = false;
};
