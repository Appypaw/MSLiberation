// Called only from the authenticated request dispatcher.
if (!isServer || {!(missionNamespace getVariable ["MSL_internal",false])}) exitWith {};
params ["_unit","_op","_args","_a"];
private _session = _unit getVariable ["MSL_arsenalSession",[]];
private _tell = {params ["_text"]; [_unit,_text] call MSL_fnc_publish;};
if (_op == "arsenalOpen") exitWith {
    // A retry must return the original session rather than creating another one.
    private _requestId = _args param [0,"",[""]];
    if (!(_session isEqualTo []) && {(_session param [3,""]) == _requestId}) exitWith {
        _unit setVariable ["MSL_arsenalSession",_session,true];
    };

    if (!(_session isEqualTo []) && {diag_tickTime > (_session select 2) + 900}) then {_session = []; _unit setVariable ["MSL_arsenalSession",[],true];};
    if (!(_session isEqualTo [])) exitWith {["이전 무기고 이용 세션이 남아 있습니다. 재접속 후 다시 시도하세요."] call _tell;};
    if (!([_unit] call MSL_fnc_atBase) || {vehicle _unit != _unit}) exitWith {["무기고는 본진 안에서 차량에서 내린 상태로 이용하세요."] call _tell;};
    if (diag_tickTime < (_unit getVariable ["MSL_nextRequest",0])) exitWith {};
    _unit setVariable ["MSL_nextRequest",diag_tickTime + 1];
    private _token = format ["arsenal_%1_%2",getPlayerUID _unit,diag_tickTime];
    _unit setVariable ["MSL_arsenalSession",[_token,getUnitLoadout _unit,diag_tickTime,_args param [0,"",[""]]],true];
};
if (_session isEqualTo [] || {_args param [0,"",[""]] != (_session select 0)}) exitWith {};
_unit setVariable ["MSL_arsenalSession",[],true];
if (_op == "arsenalCancel") exitWith {};
if (!([_unit] call MSL_fnc_atBase) || {vehicle _unit != _unit} || {diag_tickTime > (_session select 2) + 900}) exitWith {["무기고 이용 시간이 지났거나 보급소를 벗어났습니다. 다시 열어주세요."] call _tell;};
private _requested = _args param [1,[],[[]]];
if (count _requested != 10 || {count str _requested > 60000}) exitWith {};
// Validate the native loadout shape before passing network data to engine commands.
private _shapeOK = true;
private _weaponShape = {
    params ["_w"];
    if (!(_w isEqualType []) || {!(count _w in [0,7])}) exitWith {false};
    if (_w isEqualTo []) exitWith {true};
    private _ok = true;
    {if (!((_w select _x) isEqualType "")) then {_ok = false;};} forEach [0,1,2,3,6];
    {
        private _m = _w select _x;
        if (!(_m isEqualType [])) then {_ok = false;} else {
            if !(_m isEqualTo []) then {
                if (count _m != 2) then {_ok = false;} else {
                    if (!((_m select 0) isEqualType "") || {!((_m select 1) isEqualType 0)}) then {_ok = false;} else {
                        if (!finite (_m select 1) || {(_m select 1) < 0} || {(_m select 1) > 10000}) then {_ok = false;};
                    };
                };
            };
        };
    } forEach [4,5];
    _ok
};
{if (!([_requested select _x] call _weaponShape)) then {_shapeOK = false;};} forEach [0,1,2,8];
{
    private _container = _requested select _x;
    if (!(_container isEqualType [])) then {_shapeOK = false;} else {
        if !(_container isEqualTo []) then {
            if (count _container != 2) then {_shapeOK = false;} else {
                if (!((_container select 0) isEqualType "") || {!((_container select 1) isEqualType [])}) then {_shapeOK = false;} else {
                    if (count (_container select 1) > 500) then {_shapeOK = false;};
                    {
                        if (!(_x isEqualType []) || {!(count _x in [2,3])}) then {_shapeOK = false;} else {
                            private _item = _x select 0; private _count = _x select 1;
                            if (!(_count isEqualType 0)) then {_shapeOK = false;} else {
                                if (!finite _count || {_count < 1} || {_count > 500} || {_count != floor _count}) then {_shapeOK = false;};
                            };
                            if (!(_item isEqualType "") && {!([_item] call _weaponShape)}) then {_shapeOK = false;};
                            if (count _x == 3) then {
                                private _rounds = _x select 2;
                                if (!(_rounds isEqualType 0)) then {_shapeOK = false;} else {
                                    if (!finite _rounds || {_rounds < 0} || {_rounds > 10000}) then {_shapeOK = false;};
                                };
                            };
                        };
                    } forEach (_container select 1);
                };
            };
        };
    };
} forEach [3,4,5];
{if (!((_requested select _x) isEqualType "")) then {_shapeOK = false;};} forEach [6,7];
private _assigned = _requested select 9;
if (!(_assigned isEqualType [])) then {_shapeOK = false;} else {
    if (count _assigned > 6 || {_assigned findIf {!(_x isEqualType "")} >= 0}) then {_shapeOK = false;};
};
if (!_shapeOK) exitWith {};
// Reject locked/unknown additions before engine normalization can discard them.
private _requestLevel = ([_a select 2] call MSL_fnc_progress) select 0;
if (!(([_session select 1,_requested,_requestLevel] call MSL_fnc_arsenalQuote) select 0)) exitWith {["해금되지 않은 탄창 또는 장비가 포함되어 있어 결제를 취소했습니다."] call _tell;};
// Normalize using the engine; all prices, permissions and credits are server owned.
private _dummy = createAgent ["B_Soldier_F",[0,0,0],[],0,"NONE"];
_dummy hideObjectGlobal true; _dummy allowDamage false;
_dummy setUnitLoadout [_requested,false];
private _new = getUnitLoadout _dummy;
deleteVehicle _dummy;
private _level = ([_a select 2] call MSL_fnc_progress) select 0;
private _quote = [_session select 1,_new,_level] call MSL_fnc_arsenalQuote;
if (!(_quote select 0)) exitWith {["해금되지 않은 장비가 포함되어 있습니다. 장비 변경을 취소했습니다."] call _tell;};
private _cost = _quote select 1;
if (_cost > (_a select 1)) exitWith {[format ["잔액 부족: 필요 $%1 / 보유 $%2. 장비 변경을 취소했습니다.",_cost,_a select 1]] call _tell;};
// Do not replace equipment changed by injury/another system while browsing.
if !((getUnitLoadout _unit) isEqualTo (_session select 1)) exitWith {["이용 중 실제 장비가 변경되었습니다. 무기고를 다시 열어주세요."] call _tell;};
private _token = _session select 0;
_a set [1,(_a select 1) - _cost];
private _p = [_token,diag_tickTime,_new,-_cost,"arsenal","",_session select 1,_quote select 2];
_a set [9,_p]; _a set [7,_new];
_unit setVariable ["MSL_pending",_p];
_unit setVariable ["MSL_econBusy",true,true]; _unit setVariable ["MSL_ack",false];
[] call MSL_fnc_persist;
[_unit,format ["무기고 결제: $%1",_cost]] call MSL_fnc_publish;
[_unit,_new,_token] remoteExecCall ["MSL_fnc_applyGear",owner _unit];
