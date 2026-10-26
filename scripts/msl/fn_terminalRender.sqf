if (!hasInterface || {isRemoteExecuted}) exitWith {};
disableSerialization;
params ["_d"];
if (isNull _d) exitWith {};
private _mode = _d getVariable ["MSL_mode","buy"];
if (_mode in ["progress","transfer"] && {!([player] call MSL_fnc_atTerminal)}) exitWith {_d closeDisplay 2;};
{ctrlDelete _x;} forEach (_d getVariable ["MSL_body",[]]);
private _controls = []; private _id = 8100;
private _make = _d getVariable "MSL_make";
private _mk = {
    params ["_class","_rect",["_text",""],["_color",[0.88,0.92,0.94,1]]];
    private _c = [_d,_class,_id,_rect,_text,_color] call _make;
    _id = _id + 1; _controls pushBack _c; _c
};
private _button = {
    params ["_rect","_text","_handler"];
    private _b = ["RscButton",_rect,_text] call _mk;
    _b ctrlAddEventHandler ["ButtonClick",_handler]; _b
};
private _s = player getVariable ["MSL_stats",[0,0,0,0,0,0]];
private _progress = [_s select 1] call MSL_fnc_progress;
private _level = _progress select 0;
if (_mode == "progress") then {
    (_d displayCtrl 8004) ctrlSetText "CAREER / 개인 해금 진행도";
    ["RscText",[0.23,0.18,0.68,0.055],format ["LEVEL %1   %2",_level,MSL_levelTitles param [_level - 1,"OPERATOR"]],[0.91,0.76,0.45,1]] call _mk;
    private _bar = ["RscProgress",[0.23,0.25,0.71,0.014]] call _mk; _bar progressSetPosition (_progress select 3); _bar ctrlSetTextColor [0.91,0.76,0.45,1];
    ["RscText",[0.23,0.28,0.71,0.045],format ["XP %1 / %2     처치 %3  |  사망 %4  |  점령 %5  |  독택 %6",_s select 1,_progress select 2,_s select 2,_s select 3,_s select 4,player getVariable ["MSL_dogtags",0]]] call _mk;
    private _page = _d getVariable ["MSL_page",0];
    for "_i" from 0 to 5 do {
        private _tier = _page * 6 + _i + 1;
        if (_tier <= count MSL_levelThresholds) then {
            private _xPos = 0.23 + _i * 0.12;
            private _unlocked = _tier <= _level;
            private _color = [[0.3,0.36,0.4,1],[0.9,0.73,0.4,1]] select _unlocked;
            private _panel = ["RscText",[_xPos,0.39,0.108,0.37]] call _mk;
            _panel ctrlSetBackgroundColor ([[0.045,0.06,0.075,1],[0.11,0.105,0.075,1]] select _unlocked);
            ["RscText",[_xPos + 0.006,0.405,0.1,0.045],format ["LV. %1",_tier],_color] call _mk;
            private _rewards = MSL_shopEntries select {(_x select 3) == _tier};
            private _name = "기본 보급 / 전투 경력";
            private _image = "res\ui_arsenal.paa";
            if !(_rewards isEqualTo []) then {
                private _entry = _rewards select 0; _name = _entry select 1;
                private _class = _entry select 0;
                {private _cfg = configFile >> _x >> _class; if (isClass _cfg && {getText (_cfg >> "picture") != ""}) exitWith {_image = getText (_cfg >> "picture");};} forEach ["CfgWeapons","CfgVehicles","CfgGlasses","CfgMagazines"];
            };
            ["RscPicture",[_xPos + 0.005,0.47,0.098,0.105],_image,_color] call _mk;
            ["RscText",[_xPos + 0.005,0.59,0.1,0.045],MSL_levelTitles param [_tier - 1,"OPERATOR"],_color] call _mk;
            ["RscText",[_xPos + 0.005,0.635,0.1,0.045],format ["%1 XP",MSL_levelThresholds select (_tier - 1)]] call _mk;
            private _card = [[_xPos + 0.005,0.69,0.1,0.05],format ["품목 %1",count _rewards],{
                private _b = _this select 0; private _d = ctrlParent _b;
                _d setVariable ["MSL_query",""];
                _d setVariable ["MSL_filterLevel",_b getVariable "MSL_tier"];
                _d setVariable ["MSL_mode","buy"]; [_d] call MSL_fnc_terminalRender;
            }] call _button;
            _card setVariable ["MSL_tier",_tier];
            _panel ctrlSetTooltip format ["LV.%1 / %2 / 해금 품목 %3개",_tier,_name,count _rewards];
            ["RscText",[_xPos + 0.005,0.75,0.1,0.035],["잠김","해금 완료"] select _unlocked,_color] call _mk;
        };
    };
    [[0.23,0.8,0.2,0.05],"이전 티어",{private _d = ctrlParent (_this select 0); _d setVariable ["MSL_page",((_d getVariable ["MSL_page",0]) - 1) max 0]; [_d] call MSL_fnc_terminalRender;}] call _button;
    [[0.74,0.8,0.2,0.05],"다음 티어",{private _d = ctrlParent (_this select 0); _d setVariable ["MSL_page",((_d getVariable ["MSL_page",0]) + 1) min (floor ((count MSL_levelThresholds - 1) / 6))]; [_d] call MSL_fnc_terminalRender;}] call _button;
    ["RscText",[0.23,0.88,0.71,0.05],"레벨 달성 시 구매 권한 영구 해금 / 장비는 개인 자금으로 구매",[0.55,0.65,0.7,1]] call _mk;
};
if (_mode == "kits") then {
    (_d displayCtrl 8004) ctrlSetText "ARMORY / 무료 군수 키트";
    ["RscText",[0.23,0.18,0.71,0.05],"레벨 제한 없음 / $0 / 필요한 키트를 선택하세요."] call _mk;
    {
        private _row = _x;
        private _b = [[0.23,0.27 + _forEachIndex * 0.09,0.71,0.07],format ["%1   |   무료 $0",_row select 1],{
            private _b = _this select 0;
            [_b getVariable "MSL_kit"] spawn {
                params ["_id"];
                if (["현재 장비를 버리고 선택한 무료 키트로 교체할까요?","무료 키트 수령",true,true] call BIS_fnc_guiMessage) then {[player,"free",[_id]] remoteExecCall ["MSL_fnc_request",2];};
            };
        }] call _button;
        _b setVariable ["MSL_kit",_row select 0];
    } forEach MSL_freeKits;
    ["RscText",[0.23,0.86,0.71,0.07],"전체 장비 교체 / 무료 키트 장비는 판매 불가",[0.91,0.76,0.45,1]] call _mk;
};
if (_mode == "transfer") then {
    (_d displayCtrl 8004) ctrlSetText "BANKING / 아군 송금";
    ["RscText",[0.24,0.2,0.67,0.08],format ["AVAILABLE BALANCE   $%1",_s select 0],[0.91,0.76,0.45,1]] call _mk;
    ["RscText",[0.24,0.33,0.67,0.045],"수신자 / 접속 중인 아군"] call _mk;
    private _combo = ["RscCombo",[0.24,0.39,0.66,0.065]] call _mk;
    private _friends = allPlayers select {_x != player && {alive _x} && {side group _x == GRLIB_side_friendly}};
    _combo setVariable ["MSL_friends",_friends];
    {_combo lbAdd name _x;} forEach _friends; _combo lbSetCurSel 0;
    ["RscText",[0.24,0.51,0.67,0.045],"송금액 / 수수료 없음"] call _mk;
    private _amount = ["RscEdit",[0.24,0.57,0.66,0.065],"100"] call _mk;
    private _send = [[0.24,0.71,0.66,0.07],"송금 내역 확인",{
        private _b = _this select 0; private _combo = _b getVariable "MSL_combo";
        private _friends = _combo getVariable ["MSL_friends",[]]; private _i = lbCurSel _combo;
        if (_i < 0 || {_i >= count _friends}) exitWith {};
        [_friends select _i,parseNumber ctrlText (_b getVariable "MSL_amount")] spawn {
            params ["_target","_amount"];
            if ([format ["%1에게 $%2 송금할까요?",name _target,_amount],"송금 확인",true,true] call BIS_fnc_guiMessage) then {[player,"transfer",[_target,_amount]] remoteExecCall ["MSL_fnc_request",2];};
        };
    }] call _button;
    _send setVariable ["MSL_combo",_combo]; _send setVariable ["MSL_amount",_amount];
    ["RscText",[0.24,0.84,0.67,0.06],"본진 전용 서비스 / 서버가 잔액과 수신자를 다시 검증합니다.",[0.55,0.65,0.7,1]] call _mk;
};
if (_mode in ["buy","sell"]) then {
    (_d displayCtrl 8004) ctrlSetText (["ARMORY / 해금 장비 구매","SALVAGE / 노획품 정산"] select (_mode == "sell"));
    private _search = ["RscEdit",[0.23,0.18,0.53,0.055],_d getVariable ["MSL_query",""]] call _mk;
    private _queryButton = [[0.78,0.18,0.16,0.055],"검색 / 적용",{
        private _b = _this select 0; private _d = ctrlParent _b;
        _d setVariable ["MSL_query",ctrlText (_b getVariable "MSL_search")];
        _d setVariable ["MSL_filterLevel",-1]; [_d] call MSL_fnc_terminalRender;
    }] call _button; _queryButton setVariable ["MSL_search",_search];
    private _list = ["RscListbox",[0.23,0.27,0.46,0.49]] call _mk;
    private _picture = ["RscPicture",[0.72,0.32,0.21,0.16],"res\ui_arsenal.paa"] call _mk;
    private _detail = ["RscText",[0.72,0.51,0.22,0.11],"장비를 선택하세요."] call _mk;
    _list setVariable ["MSL_picture",_picture]; _list setVariable ["MSL_detail",_detail];
    _list ctrlAddEventHandler ["LBSelChanged",{
        params ["_list","_i"]; if (_i < 0) exitWith {};
        private _class = _list lbData _i; private _image = "res\ui_arsenal.paa";
        {private _cfg = configFile >> _x >> _class; if (isClass _cfg && {getText (_cfg >> "picture") != ""}) exitWith {_image = getText (_cfg >> "picture");};} forEach ["CfgWeapons","CfgVehicles","CfgGlasses","CfgMagazines"];
        (_list getVariable "MSL_picture") ctrlSetText _image;
        (_list getVariable "MSL_detail") ctrlSetText (_list lbText _i);
        private _button = _list getVariable ["MSL_trade",controlNull];
        if (!isNull _button) then {
            private _d = ctrlParent _list; private _sale = (_d getVariable ["MSL_mode",""]) == "sell";
            private _e = [_class,_sale] call MSL_fnc_catalog;
            private _stats = player getVariable ["MSL_stats",[0,0,0,0,0,0]];
            if !(_e isEqualTo []) then {
                private _allowed = _sale || {(_stats select 0) >= (_e select 2) && {(([_stats select 1] call MSL_fnc_progress) select 0) >= (_e select 3)}};
                _button ctrlEnable _allowed;
                if (!_allowed) then {(_list getVariable "MSL_detail") ctrlSetTooltip "해금 레벨 또는 잔액이 부족합니다.";};
            };
        };
    }];
    private _entries = MSL_shopEntries select {(_x select 3) <= _level};
    if (_mode == "sell") then {
        _entries = []; private _credits = player getVariable ["MSL_sellCredits",[]];
        {
            private _class = _x select 0;
            if (_credits findIf {(_x select 0) == _class && {(_x select 1) > 0}} >= 0) then {
                private _e = [_class,true] call MSL_fnc_catalog; if !(_e isEqualTo []) then {_entries pushBack _e;};
            };
        } forEach ([player] call MSL_fnc_inventory);
    };
    private _query = toLower (_d getVariable ["MSL_query",""]); private _shown = 0;
    private _tierFilter = _d getVariable ["MSL_filterLevel",-1];
    {
        _x params ["_class","_name","_price","_required"];
        if (_shown < 200 && {(_tierFilter < 0) || {_required == _tierFilter}} && {_query == "" || {(toLower (_name + " " + _class) find _query) >= 0}}) then {
            private _text = format ["%1  |  $%2  |  LV.%3",_name,_price,_required];
            if (_mode == "sell") then {_text = format ["%1  |  최대 $%2",_name,floor (_price * MSL_sellRatio)];};
            private _i = _list lbAdd _text; _list lbSetData [_i,_class];
            if (_mode == "buy" && {_required > _level}) then {_list lbSetColor [_i,[0.42,0.48,0.52,1]];};
            _shown = _shown + 1;
        };
    } forEach _entries;
    private _trade = [[0.72,0.65,0.22,0.065],["구매","판매"] select (_mode == "sell"),{
        private _b = _this select 0; private _d = ctrlParent _b; private _l = _b getVariable "MSL_list";
        if (lbCurSel _l < 0) exitWith {};
        [player,_d getVariable ["MSL_mode","buy"],[_l lbData lbCurSel _l]] remoteExecCall ["MSL_fnc_request",2];
        [_d] spawn {disableSerialization; params ["_d"]; sleep 2; if (!isNull _d) then {[_d] call MSL_fnc_terminalRender;};};
    }] call _button; _trade setVariable ["MSL_list",_list];
    _list setVariable ["MSL_trade",_trade]; _trade ctrlEnable (_shown > 0); _list lbSetCurSel 0;
    if (_shown == 0) then {_detail ctrlSetText "표시할 해금 장비가 없습니다. 무료 키트 또는 해금 진행도를 확인하세요.";};
    _trade ctrlSetTooltip "장비를 넣을 빈 슬롯과 수납 공간이 필요합니다. 기존 장비는 먼저 내려놓으세요.";
    [[0.23,0.8,0.71,0.065],"무료 키트 선택 / $0",{private _d = ctrlParent (_this select 0); _d setVariable ["MSL_mode","kits"]; [_d] call MSL_fnc_terminalRender;}] call _button;
    ["RscText",[0.23,0.9,0.71,0.045],"최대 200개 / 검색으로 전체 조회 / 해금 장비만 표시 / 무료 장비는 키트 탭",[0.55,0.65,0.7,1]] call _mk;
};
_d setVariable ["MSL_body",_controls];
