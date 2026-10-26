// Only network entry point for personal economy. All amounts/classes are server derived.
params [["_unit", objNull, [objNull]], ["_op", "", [""]], ["_args", [], [[]]]];
if (!isServer || {!(missionNamespace getVariable ["MSL_ready", false])} || {isNull _unit} || {!isPlayer _unit}) exitWith {};
if (!isRemoteExecuted || {remoteExecutedOwner != owner _unit}) exitWith {};
if (side group _unit != GRLIB_side_friendly || {getPlayerUID _unit == ""}) exitWith {};
MSL_internal = true;
call {
    private _uid = getPlayerUID _unit;
    private _a = [_uid] call MSL_fnc_account;
    private _tell = {params ["_text"]; [_unit, _text] call MSL_fnc_publish;};
    if (_op == "ack") exitWith {
        private _pending = _unit getVariable ["MSL_pending", []];
        if (_pending isEqualTo [] || {_args param [0, ""] != (_pending select 0)}) exitWith {};
        // No client loadout accepted. Server owns the proposed complete inventory.
        _unit setVariable ["MSL_ack", true];
    };
    if (_op == "signal") exitWith {
        private _window = _unit getVariable ["MSL_signalWindow", []];
        private _projectile = _args param [0, objNull, [objNull]];
        if (_window isEqualTo [] || {isNull _projectile} || {!(_unit in getShotParents _projectile)}) exitWith {};
        private _types = [MSL_supplySignalsDay, MSL_supplySignalsNight] select (sunOrMoon < 0.2);
        if (typeOf _projectile in _types && {_projectile distance2D (_window select 1) < MSL_supplySignalRadius}) then {_unit setVariable ["MSL_signal", _projectile];};
    };
    if (_op == "loot") exitWith {
        if (!alive _unit) exitWith {};
        private _source = _args param [0, objNull, [objNull]];
        _source = _source getVariable ["MSL_lootOwner", _source];
        private _class = _args param [1, "", [""]];
        if (isNull _source || {_unit distance _source > 12}) exitWith {};
        private _stock = _source getVariable ["MSL_lootStock", []];
        private _i = _stock findIf {(_x select 0) == _class};
        if (_i < 0) exitWith {};
        private _remaining = [_source] call MSL_fnc_inventory;
        {if (!isNull _x) then {_remaining append ([_x] call MSL_fnc_inventory);};} forEach (_source getVariable ["MSL_lootHolders", []]);
        private _held = [_unit] call MSL_fnc_inventory;
        private _credits = _a select 8;
        // A whole stolen backpack/weapon includes its contained gear and attachments.
        {
            private _stockRow = _x; private _lootClass = _stockRow select 0;
            private _left = 0;
            {if ((_x select 0) == _lootClass) then {_left = _left + (_x select 1);};} forEach _remaining;
            private _delta = ((_stockRow select 1) - _left) max 0;
            private _carried = _held select {(_x select 0) == _lootClass};
            if (_delta > 0 && {!(_carried isEqualTo [])}) then {
                private _k = _credits findIf {(_x select 0) == _lootClass};
                private _owned = if (_k < 0) then {0} else {(_credits select _k) select 1};
                private _grant = _delta min (((_carried select 0) select 1) - _owned);
                if (_grant > 0) then {
                    _stockRow set [1, (_stockRow select 1) - _grant];
                    if (_k < 0) then {_credits pushBack [_lootClass, _grant];} else {(_credits select _k) set [1, _owned + _grant];};
                };
            };
        } forEach _stock;
        _a set [8, _credits];
        [_unit] call MSL_fnc_publish;
    };
    if (_op == "sync") exitWith {
        if (_unit getVariable ["MSL_joined", false]) exitWith {[_unit] call MSL_fnc_publish;};
        if (!alive _unit) exitWith {};
        _unit setVariable ["MSL_joined", true];
        private _savedPending = _a param [9, []];
        private _gear = _a select 7;
        if (_gear isEqualTo []) then {_gear = [""] call MSL_fnc_buildKit; _a set [8, []];};
        _a set [7, _gear];
        private _token = format ["join_%1_%2", _uid, diag_tickTime];
        private _p = [_token, diag_tickTime, _gear, 0, "join"];
        if !(_savedPending isEqualTo []) then {_p = _savedPending; _token = _p select 0; _gear = _p select 2;};
        _unit setVariable ["MSL_pending", _p];
        _unit setVariable ["MSL_econBusy", true, true];
        _a set [9, _p];
        [_unit, _gear, _token] remoteExecCall ["MSL_fnc_applyGear", owner _unit];
        [_unit, "개인 프로필 연결 완료. 보급소의 무기고에서 해금 장비를 선택하세요."] call MSL_fnc_publish;
    };
    if (!alive _unit || {!((_unit getVariable ["MSL_pending", []]) isEqualTo [])}) exitWith {};
    if (_op in ["arsenalOpen","arsenalClose","arsenalCancel"]) exitWith {[_unit,_op,_args,_a] call MSL_fnc_arsenalRequest;};
    if (!((_unit getVariable ["MSL_arsenalSession",[]]) isEqualTo [])) exitWith {};
    if (diag_tickTime < (_unit getVariable ["MSL_nextRequest", 0])) exitWith {};
    _unit setVariable ["MSL_nextRequest", diag_tickTime + 1];
    if (_op == "dogtag") exitWith {
        private _body = _args param [0,objNull,[objNull]];
        if (isNull _body || {alive _body} || {!(_body getVariable ["MSL_dogtagEligible",false])} || {_body getVariable ["MSL_dogtagTaken",false]} || {_unit distance _body > MSL_dogtagRange} || {vehicle _unit != _unit}) exitWith {};
        _body setVariable ["MSL_dogtagTaken",true,true];
        _a set [1,(_a select 1) + MSL_dogtagCash]; _a set [2,(_a select 2) + MSL_dogtagXP];
        _a set [10,(_a param [10,0]) + 1];
        [] call MSL_fnc_persist;
        [_unit,format ["독택 회수: $%1 / XP %2",MSL_dogtagCash,MSL_dogtagXP]] call MSL_fnc_publish;
    };
    if (_op == "transfer") exitWith {
        if (!([_unit] call MSL_fnc_atTerminal)) exitWith {["송금은 본진 단말기에서만 가능합니다."] call _tell;};
        private _target = _args param [0, objNull, [objNull]];
        private _amount = _args param [1, 0, [0]];
        if (!finite _amount || {_amount != floor _amount} || {_amount < 1} || {_amount > (_a select 1)}) exitWith {["송금 금액이나 잔액을 확인하세요."] call _tell;};
        if (isNull _target || {_target == _unit} || {!isPlayer _target} || {!alive _target} || {side group _target != GRLIB_side_friendly} || {getPlayerUID _target == ""}) exitWith {["접속 중인 아군을 선택하세요."] call _tell;};
        private _b = [getPlayerUID _target] call MSL_fnc_account;
        _a set [1, (_a select 1) - _amount]; _b set [1, (_b select 1) + _amount];
        [] call MSL_fnc_persist;
        [_unit, format ["%1에게 $%2 송금 완료", name _target, _amount]] call MSL_fnc_publish;
        [_target, format ["%1에게서 $%2 수신", name _unit, _amount]] call MSL_fnc_publish;
        diag_log format ["[MSL TRANSFER] %1 -> %2 : %3", _uid, getPlayerUID _target, _amount];
    };
    if (_op == "evac") exitWith {
        if (!([_unit] call MSL_fnc_canRequestSupport)) exitWith {["지원 요청은 분대장 또는 지휘관만 가능합니다."] call _tell;};
        if (count MSL_evacRequests < 2) then {MSL_evacRequests pushBack _unit;};
    };
    if (_op == "airdrop") exitWith {
        if (!([_unit] call MSL_fnc_canRequestSupport)) exitWith {["지원 요청은 분대장 또는 지휘관만 가능합니다."] call _tell;};
        if (count MSL_dropRequests < 4) then {MSL_dropRequests pushBack [_unit, _args param [0, "ammo", [""]]];};
    };
    if (!([_unit] call MSL_fnc_atBase) || {vehicle _unit != _unit}) exitWith {["기지 또는 FOB 보급소에서 이용하세요."] call _tell;};
    private _new = [];
    private _cashDelta = 0;
    private _receipt = "";
    private _class = _args param [0, "", [""]];
    if (_op in ["free","buy"]) exitWith {["장비는 무기고에서 선택하세요."] call _tell;};
    if (_op in ["buy", "sell"]) then {
        private _entry = [_class, _op == "sell"] call MSL_fnc_catalog;
        if (_entry isEqualTo []) exitWith {};
        _entry params ["_id", "_label", "_price", "_level", "_kind"];
        private _credits = _a select 8;
        private _creditIndex = _credits findIf {(_x select 0) == _class};
        if (_op == "buy" && {!(_class in MSL_shopClasses) || {(([_a select 2] call MSL_fnc_progress) select 0) < _level} || {(_a select 1) < _price}}) exitWith {};
        if (_op == "sell" && {_creditIndex < 0 || {((_credits select _creditIndex) select 1) < 1}}) exitWith {["노획 또는 구매 기록이 없는 무료 보급품은 판매할 수 없습니다."] call _tell;};
        private _dummy = createAgent ["B_Soldier_F", [0, 0, 0], [], 0, "NONE"];
        _dummy hideObjectGlobal true; _dummy allowDamage false;
        _dummy setUnitLoadout [getUnitLoadout _unit, false];
        private _before = [_dummy] call MSL_fnc_inventory;
        private _slot = -1;
        if (_kind == "weapon") then {_slot = [1, 4, 2] find getNumber (configFile >> "CfgWeapons" >> _class >> "type");};
        if (_op == "buy") then {
            switch (_kind) do {
                case "weapon": {
                    if (_slot >= 0 && {((getUnitLoadout _dummy) select _slot) isEqualTo [] || {(((getUnitLoadout _dummy) select _slot) param [0, ""]) == ""}}) then {_dummy addWeapon _class;};
                };
                case "magazine": {if (_dummy canAdd _class) then {_dummy addMagazine _class;};};
                case "backpack": {if (backpack _dummy == "") then {_dummy addBackpack _class;};};
                case "goggles": {if (goggles _dummy == "") then {_dummy addGoggles _class;};};
                default {
                    private _type = getNumber (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "type");
                    switch (_type) do {
                        case 801: {if (uniform _dummy == "") then {_dummy forceAddUniform _class;};};
                        case 701: {if (vest _dummy == "") then {_dummy addVest _class;};};
                        case 605: {if (headgear _dummy == "") then {_dummy addHeadgear _class;};};
                        default {if (_dummy canAdd _class) then {_dummy addItem _class;};};
                    };
                };
            };
        } else {
            private _sale = [getUnitLoadout _dummy, _class] call MSL_fnc_removeFromLoadout;
            if !(_sale isEqualTo []) then {_dummy setUnitLoadout [_sale, false];};
        };
        private _after = [_dummy] call MSL_fnc_inventory;
        private _b = _before select {(_x select 0) == _class};
        private _c = _after select {(_x select 0) == _class};
        private _n0 = if (_b isEqualTo []) then {0} else {(_b select 0) select 1};
        private _n1 = if (_c isEqualTo []) then {0} else {(_c select 0) select 1};
        private _expected = [1, -1] select (_op == "sell");
        if (_n1 - _n0 == _expected) then {
            _new = getUnitLoadout _dummy;
            _cashDelta = -_price;
            if (_op == "sell") then {
                private _fraction = 1;
                if (_kind == "magazine") then {
                    private _roundsBefore = if (_b isEqualTo []) then {0} else {(_b select 0) select 2};
                    private _roundsAfter = if (_c isEqualTo []) then {0} else {(_c select 0) select 2};
                    _fraction = ((_roundsBefore - _roundsAfter) / (getNumber (configFile >> "CfgMagazines" >> _class >> "count") max 1)) min 1;
                };
                _cashDelta = floor (_price * MSL_sellRatio * (_fraction max 0));
            };
            _receipt = _class;
        };
        deleteVehicle _dummy;
    };
    if (_new isEqualTo []) exitWith {["거래할 수 없습니다. 해금·잔액·빈 슬롯·수납 공간을 확인하세요. 판매 전 총의 부착물과 탄창을 분리하세요."] call _tell;};
    // Reserve purchases before issuing gear. Sale proceeds wait for server-observed removal.
    if (_cashDelta < 0) then {_a set [1, (_a select 1) + _cashDelta];};
    private _token = format ["%1_%2", _uid, diag_tickTime];
    _unit setVariable ["MSL_pending", [_token, diag_tickTime, _new, _cashDelta, _op, _receipt, getUnitLoadout _unit]];
    _unit setVariable ["MSL_econBusy", true, true];
    _unit setVariable ["MSL_ack", false];
    _a set [9, _unit getVariable "MSL_pending"];
    _a set [7, _new];
    [] call MSL_fnc_persist;
    [_unit, _new, _token] remoteExecCall ["MSL_fnc_applyGear", owner _unit];
};
MSL_internal = false;
