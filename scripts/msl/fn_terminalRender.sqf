if (!hasInterface || {isRemoteExecuted}) exitWith {};
disableSerialization;
params ["_d"];
if (isNull _d) exitWith {};
private _mode = _d getVariable ["MSL_mode","buy"];

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
// Refresh persistent shell labels in place on language change; keep filters/page.
(_d displayCtrl 8003) ctrlSetText (["개인 태블릿","Personal tablet"] call MSL_fnc_text);
(_d displayCtrl 8020) ctrlSetText (["연결됨","Connected"] call MSL_fnc_text);
(_d displayCtrl 8021) ctrlSetText (["닫기","Close"] call MSL_fnc_text);
{
    (_d displayCtrl (8010 + _forEachIndex)) ctrlSetText (_x call MSL_fnc_text);
} forEach [["요약","Overview"],["개인 기록","Career"],["장비 도감","Catalog"],["무기고","Arsenal"],["장비 판매","Sell gear"],["분대 지휘","Command"],["아군 송금","Transfers"],["설정","Settings"]];
private _tabHints = [
    [8013,["본진 / FOB에서 장비를 선택하고 수령합니다.","Select and collect equipment at base or an FOB."]],
    [8014,["본진 / FOB에서 구매·노획 장비를 정산합니다.","Sell purchased or captured equipment at base or an FOB."]],
    [8016,["본진에서 접속 중인 아군에게 송금합니다.","Transfer funds to online allies at the main base."]]
];
{(_d displayCtrl (_x select 0)) ctrlSetTooltip ((_x select 1) call MSL_fnc_text);} forEach _tabHints;
private _s = player getVariable ["MSL_stats",[0,0,0,0,0,0]];
private _progress = [_s select 1] call MSL_fnc_progress;
private _level = _progress select 0;
private _catalog = missionNamespace getVariable ["MSL_shopEntries",[]];
private _unlocked = {(_x select 3) <= _level} count _catalog;
private _maxLevel = count MSL_levelThresholds;
private _nextXP = ((_progress select 2) - (_s select 1)) max 0;
private _nextUnlocks = {(_x select 3) == _level + 1} count _catalog;
private _rankText = if (_level >= _maxLevel) then {(["최고 레벨 달성","Maximum level reached"] call MSL_fnc_text)} else {format [(["다음 LV.%1까지 %2 XP","%2 XP to LV.%1"] call MSL_fnc_text),_level + 1,_nextXP]};
{
    private _tab = _d displayCtrl (8010 + _forEachIndex);
    _tab ctrlSetBackgroundColor (if (_x == _mode) then {[0.12,0.27,0.46,1]} else {[0.075,0.08,0.095,1]});
    _tab setVariable ["MSL_idleColor",if (_x == _mode) then {[0.12,0.27,0.46,1]} else {[0.075,0.08,0.095,1]}];
    _tab ctrlSetTextColor (if (_x == _mode) then {[0.94,0.95,0.98,1]} else {[0.72,0.79,0.82,1]});
} forEach ["overview","career","progress","buy","sell","command","transfer","settings"];
private _commandTab = _d displayCtrl 8015;
_commandTab ctrlEnable ([player] call MSL_fnc_canRequestSupport);
_commandTab ctrlSetTooltip (["분대장 전용: 보급 요청과 분대 관리","Squad leaders only: supply requests and group management"] call MSL_fnc_text);
if (_mode in ["career","progress"] && {!(missionNamespace getVariable ["MSL_ready",false])}) exitWith {
    (_d displayCtrl 8004) ctrlSetText (["개인 기록 / 장비 도감","Career / Equipment"] call MSL_fnc_text);
    ["RscText",[0.25,0.35,0.67,0.08],(["장비 도감을 동기화하고 있습니다.","Syncing the equipment catalog."] call MSL_fnc_text)] call _mk;
    ["RscText",[0.25,0.45,0.67,0.06],(["서버 준비가 끝나면 자동으로 표시됩니다.","This screen will update when the server is ready."] call MSL_fnc_text),[0.62,0.65,0.71,1]] call _mk;
    _d setVariable ["MSL_body",_controls];
    _d setVariable ["MSL_signature",nil];
};
if (_mode == "settings" && {!(missionNamespace getVariable ["KPPLM_CBA",false]) || {!(missionNamespace getVariable ["KP_liberation_playermenu",false])}}) exitWith {
    (_d displayCtrl 8004) ctrlSetText (["KP 플레이어 메뉴","KP Player Menu"] call MSL_fnc_text);
    ["RscText",[0.23,0.35,0.71,0.08],(["이 미션에서 KP Player Menu가 활성화되어 있지 않습니다.","KP Player Menu is not enabled for this mission."] call MSL_fnc_text)] call _mk;
    _d setVariable ["MSL_body",_controls];
    _d setVariable ["MSL_signature",nil];
};
if (_mode == "settings") then {[_d,_mk,_button] call MSL_fnc_playerSettings;};
if (_mode == "command") then {[_d,_mk,_button] call MSL_fnc_squadCommand;};
// Overview keeps the most common field actions one click away.
if (_mode == "overview") then {
    (_d displayCtrl 8004) ctrlSetText (["요약","Overview"] call MSL_fnc_text);
    {
        _x params ["_xPos","_label","_value"];
        private _panel = ["RscText",[_xPos,0.20,0.225,0.15]] call _mk;
        _panel ctrlSetBackgroundColor [0.10,0.11,0.135,1];
        ["RscText",[_xPos + 0.012,0.21,0.20,0.04],_label,[0.62,0.65,0.71,1]] call _mk;
        private _valueCtrl = ["RscText",[_xPos + 0.012,0.265,0.20,0.065],_value,[0.94,0.95,0.98,1]] call _mk;
        _valueCtrl ctrlSetFontHeight (((_d getVariable "MSL_layout") select 3) * 0.044);
    } forEach [[0.23,(["개인 잔고","Balance"] call MSL_fnc_text),format ["$%1",_s select 0]],[0.472,(["개인 레벨","Level"] call MSL_fnc_text),format ["LV.%1",_level]],[0.714,(["작전 위치","Location"] call MSL_fnc_text),[(["야전","Field"] call MSL_fnc_text),(["본진 / FOB","Base / FOB"] call MSL_fnc_text)] select ([player] call MSL_fnc_atBase)]];
    private _bar = ["RscProgress",[0.23,0.37,0.71,0.012]] call _mk;
    _bar progressSetPosition (_progress select 3);
    _bar ctrlSetTextColor [0.36,0.65,1,1];
    ["RscText",[0.23,0.395,0.71,0.045],format [(["%1 · 해금 %2 / %3","%1 · Unlocked %2 / %3"] call MSL_fnc_text),_rankText,_unlocked,count _catalog],[0.62,0.65,0.71,1]] call _mk;
    ["RscText",[0.23,0.455,0.71,0.045],(["빠른 작업","Quick actions"] call MSL_fnc_text)] call _mk;
    private _command = [[0.23,0.52,0.71,0.09],(["분대 지휘","Command"] call MSL_fnc_text),{
        if (!([player] call MSL_fnc_canRequestSupport)) exitWith {};
        private _d = ctrlParent (_this select 0);
        _d setVariable ["MSL_mode","command"];
        [_d] call MSL_fnc_terminalRender;
    }] call _button;
    _command ctrlEnable ([player] call MSL_fnc_canRequestSupport);
    _command ctrlSetTooltip (["분대장 전용: 보급 요청과 분대 관리","Squad leaders only: supply requests and group management"] call MSL_fnc_text);
    ["RscText",[0.23,0.63,0.71,0.045],(["분대장 전용 · 보급 요청과 분대 관리","Squad leaders only · Supply requests and group management"] call MSL_fnc_text),[0.62,0.65,0.71,1]] call _mk;
    [[0.23,0.73,0.71,0.08],(["개인 화면 / 음향 설정","Display / Audio settings"] call MSL_fnc_text),{
        private _d = ctrlParent (_this select 0);
        _d setVariable ["MSL_mode","settings"];
        [_d] call MSL_fnc_terminalRender;
    }] call _button;

    // Existing optional KP Ranks data stays visible to ordinary squad members.
    if (missionNamespace getVariable ["KPPLM_KPR",false] && {!isNil "KPR_fnc_getRankName"} && {!isNil "KPR_fnc_getScore"} && {!isNil "KPR_fnc_getPlaytime"}) then {
        private _score = (["점수 미사용","Score disabled"] call MSL_fnc_text);
        if (missionNamespace getVariable ["KPR_levelSystem",false]) then {_score = str ([] call KPR_fnc_getScore);};
        private _rank = format ["KP Ranks · %1 · %2 · %3",[] call KPR_fnc_getRankName,_score,[] call KPR_fnc_getPlaytime];
        private _rankControl = ["RscText",[0.23,0.875,0.71,0.06],_rank,[0.62,0.65,0.71,1]] call _mk;
        _rankControl ctrlSetTooltip _rank;
    };

};
if (_mode == "career") then {
    (_d displayCtrl 8004) ctrlSetText (["개인 기록","Career"] call MSL_fnc_text);
    ["RscText",[0.23,0.18,0.71,0.065],format ["LV.%1  %2",_level,MSL_levelTitles param [_level - 1,"OPERATOR"]],[0.94,0.95,0.98,1]] call _mk;
    ["RscText",[0.23,0.255,0.71,0.045],format ["%1 XP · %2",_s select 1,_rankText]] call _mk;
    private _bar = ["RscProgress",[0.23,0.315,0.71,0.014]] call _mk;
    _bar progressSetPosition (_progress select 3);
    _bar ctrlSetTextColor [0.36,0.65,1,1];
    ["RscText",[0.23,0.355,0.71,0.05],format [(["해금 %1 / %2 · 다음 레벨 신규 %3개","Unlocked %1 / %2 · Next level: +%3"] call MSL_fnc_text),_unlocked,count _catalog,if (_level >= _maxLevel) then {0} else {_nextUnlocks}]] call _mk;
    ["RscText",[0.23,0.425,0.31,0.045],(["레벨 로드맵","Level roadmap"] call MSL_fnc_text)] call _mk;
    ["RscText",[0.57,0.425,0.37,0.045],(["작전 기록 / XP 획득","Record / XP rewards"] call MSL_fnc_text)] call _mk;
    private _tiers = ["RscListbox",[0.23,0.48,0.31,0.34]] call _mk;
    {
        private _tier = _forEachIndex + 1;
        private _count = {((_x select 3) max 1) == _tier} count _catalog;
        private _i = _tiers lbAdd format [(["LV.%1  %2 XP  /  %3개","LV.%1  %2 XP  /  %3 items"] call MSL_fnc_text),_tier,_x,_count];
        _tiers lbSetValue [_i,_tier];
        _tiers lbSetTooltip [_i,format [(["%1 · %2 · %3종 해금","%1 · %2 · %3 items"] call MSL_fnc_text),MSL_levelTitles select (_tier - 1),[(["잠김","Locked"] call MSL_fnc_text),(["해금 완료","Unlocked"] call MSL_fnc_text)] select (_tier <= _level),_count]];
        if (_tier > _level) then {_tiers lbSetColor [_i,[0.48,0.50,0.55,1]];};
    } forEach MSL_levelThresholds;
    _tiers lbSetCurSel ((_level min (_maxLevel - 1)) max 0);
    private _record = ["RscStructuredText",[0.57,0.48,0.37,0.34]] call _mk;
    _record ctrlSetStructuredText composeText [
        text format [(["처치 %1  /  전사 %2","Kills %1  /  Deaths %2"] call MSL_fnc_text),_s select 2,_s select 3],lineBreak,
        text format [(["점령 %1  /  독택 %2","Captures %1  /  Dogtags %2"] call MSL_fnc_text),_s select 4,player getVariable ["MSL_dogtags",0]],lineBreak,lineBreak,
        text format [(["처치 $%1 / %2 XP","Kill $%1 / %2 XP"] call MSL_fnc_text),MSL_killCash,MSL_killXP],lineBreak,
        text format [(["독택 $%1 / %2 XP","Dogtag $%1 / %2 XP"] call MSL_fnc_text),MSL_dogtagCash,MSL_dogtagXP],lineBreak,
        text format [(["점령 +%1 XP · 방어 +%2 XP","Capture +%1 XP · Defense +%2 XP"] call MSL_fnc_text),MSL_captureXP,MSL_defenseXP]
    ];
    private _inspect = [[0.23,0.85,0.71,0.065],(["선택한 레벨의 해금 장비 보기","View equipment at selected level"] call MSL_fnc_text),{
        private _d = ctrlParent (_this select 0);
        private _tiers = (_this select 0) getVariable "MSL_tiers";
        if (lbCurSel _tiers < 0) exitWith {};
        _d setVariable ["MSL_mode","progress"];
        _d setVariable ["MSL_browserLevel",_tiers lbValue lbCurSel _tiers];
        _d setVariable ["MSL_category","all"];
        _d setVariable ["MSL_unlockFilter",0];
        _d setVariable ["MSL_browserQuery",""];
        _d setVariable ["MSL_browserPage",0];
        [_d] call MSL_fnc_terminalRender;
    }] call _button;
    _inspect setVariable ["MSL_tiers",_tiers];
    ["RscText",[0.23,0.94,0.71,0.04],(["레벨 도달 시 자동 해금 · 장비 수령 비용 별도","Unlocks by level · Equipment costs still apply"] call MSL_fnc_text),[0.62,0.65,0.71,1]] call _mk;
};
if (_mode == "progress") then {[_d,_mk,_button,_level,_progress] call MSL_fnc_equipmentBrowser;};
if (_mode == "transfer") then {
    if (!([player] call MSL_fnc_atTerminal)) exitWith {
        (_d displayCtrl 8004) ctrlSetText (["아군 송금","Transfers"] call MSL_fnc_text);
        ["RscText",[0.25,0.35,0.67,0.08],(["본진에서 이용할 수 있습니다.","Available at the main base."] call MSL_fnc_text)] call _mk;
        ["RscText",[0.25,0.45,0.67,0.06],(["본진 단말기 범위로 이동한 뒤 아군 송금을 선택하세요.","Return to the main base terminal to transfer funds."] call MSL_fnc_text),[0.55,0.68,0.72,1]] call _mk;
    };
    (_d displayCtrl 8004) ctrlSetText (["아군 송금","Transfers"] call MSL_fnc_text);
    ["RscText",[0.24,0.2,0.67,0.08],format [(["송금 가능 잔액  $%1","Available balance  $%1"] call MSL_fnc_text),_s select 0],[0.94,0.95,0.98,1]] call _mk;
    ["RscText",[0.24,0.33,0.67,0.045],(["수신자 / 접속 중인 아군","Recipient / Online allies"] call MSL_fnc_text)] call _mk;
    private _combo = ["RscCombo",[0.24,0.39,0.66,0.065]] call _mk;
    private _friends = allPlayers select {_x != player && {alive _x} && {side group _x == GRLIB_side_friendly}};
    _combo setVariable ["MSL_friends",_friends];
    {_combo lbAdd name _x;} forEach _friends; _combo lbSetCurSel 0;
    ["RscText",[0.24,0.51,0.67,0.045],(["송금액 / 수수료 없음","Amount / No fee"] call MSL_fnc_text)] call _mk;
    private _amount = ["RscEdit",[0.24,0.57,0.66,0.065],"100"] call _mk;
    private _send = [[0.24,0.71,0.66,0.07],(["송금 내역 확인","Review transfer"] call MSL_fnc_text),{
        private _b = _this select 0; private _combo = _b getVariable "MSL_combo";
        private _friends = _combo getVariable ["MSL_friends",[]]; private _i = lbCurSel _combo;
        if (_i < 0 || {_i >= count _friends}) exitWith {};
        [_friends select _i,parseNumber ctrlText (_b getVariable "MSL_amount")] spawn {
            params ["_target","_amount"];
            if ([format [(["%1에게 $%2 송금할까요?","Send $%2 to %1?"] call MSL_fnc_text),name _target,_amount],(["송금 확인","Confirm transfer"] call MSL_fnc_text),true,true] call BIS_fnc_guiMessage) then {[player,"transfer",[_target,_amount]] remoteExecCall ["MSL_fnc_request",2];};
        };
    }] call _button;
    _send ctrlEnable !(_friends isEqualTo []);
    if (_friends isEqualTo []) then {_send ctrlSetText (["송금 가능한 아군 없음","No eligible allies online"] call MSL_fnc_text);};
    _send setVariable ["MSL_combo",_combo]; _send setVariable ["MSL_amount",_amount];
    ["RscText",[0.24,0.84,0.67,0.06],(["본진 전용 서비스 / 서버가 잔액과 수신자를 다시 검증합니다.","Main base only · Balance and recipient verified by the server"] call MSL_fnc_text),[0.55,0.65,0.7,1]] call _mk;
};
if (_mode == "sell") then {
    if (!([player] call MSL_fnc_atBase)) exitWith {
        (_d displayCtrl 8004) ctrlSetText (["장비 판매","Sell gear"] call MSL_fnc_text);
        ["RscText",[0.25,0.35,0.67,0.08],(["본진 / FOB 보급소에서 이용할 수 있습니다.","Available at base / FOB supply points."] call MSL_fnc_text)] call _mk;
        ["RscText",[0.25,0.45,0.67,0.06],(["보급소로 이동한 뒤 장비 판매를 선택하세요.","Visit a supply point to sell equipment."] call MSL_fnc_text),[0.55,0.68,0.72,1]] call _mk;
    };
    (_d displayCtrl 8004) ctrlSetText ([(["ARMORY / 해금 장비 구매","Arsenal / Unlocked equipment"] call MSL_fnc_text),(["장비 판매","Sell gear"] call MSL_fnc_text)] select (_mode == "sell"));
    private _search = ["RscEdit",[0.23,0.18,0.53,0.055],_d getVariable ["MSL_query",""]] call _mk;
    private _queryButton = [[0.78,0.18,0.16,0.055],(["검색 / 적용","Search"] call MSL_fnc_text),{
        private _b = _this select 0; private _d = ctrlParent _b;
        _d setVariable ["MSL_query",ctrlText (_b getVariable "MSL_search")];
        _d setVariable ["MSL_filterLevel",-1]; [_d] call MSL_fnc_terminalRender;
    }] call _button; _queryButton setVariable ["MSL_search",_search];
    private _list = ["RscListbox",[0.23,0.27,0.46,0.49]] call _mk;
    private _picture = ["RscPicture",[0.72,0.32,0.21,0.16],"res\ui_arsenal.paa"] call _mk;
    private _detail = ["RscText",[0.72,0.51,0.22,0.11],(["장비를 선택하세요.","Select an item."] call MSL_fnc_text)] call _mk;
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
                if (!_allowed) then {(_list getVariable "MSL_detail") ctrlSetTooltip (["해금 레벨 또는 잔액이 부족합니다.","Insufficient level or funds."] call MSL_fnc_text);};
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
            if (_mode == "sell") then {_text = format [(["%1  |  최대 $%2","%1  |  Up to $%2"] call MSL_fnc_text),_name,floor (_price * MSL_sellRatio)];};
            private _i = _list lbAdd _text; _list lbSetData [_i,_class];
            if (_mode == "buy" && {_required > _level}) then {_list lbSetColor [_i,[0.42,0.48,0.52,1]];};
            _shown = _shown + 1;
        };
    } forEach _entries;
    private _trade = [[0.72,0.65,0.22,0.065],[(["구매","Buy"] call MSL_fnc_text),(["판매","Sell"] call MSL_fnc_text)] select (_mode == "sell"),{
        private _b = _this select 0; private _d = ctrlParent _b; private _l = _b getVariable "MSL_list";
        if (lbCurSel _l < 0) exitWith {};
        [player,_d getVariable ["MSL_mode","buy"],[_l lbData lbCurSel _l]] remoteExecCall ["MSL_fnc_request",2];
        [_d] spawn {disableSerialization; params ["_d"]; sleep 2; if (!isNull _d) then {[_d] call MSL_fnc_terminalRender;};};
    }] call _button; _trade setVariable ["MSL_list",_list];
    _list setVariable ["MSL_trade",_trade]; _trade ctrlEnable (_shown > 0); _list lbSetCurSel 0;
    if (_shown == 0) then {_detail ctrlSetText (["판매 가능한 장비가 없습니다. 구매하거나 노획한 장비만 판매할 수 있습니다.","No eligible items. Only purchased or captured equipment can be sold."] call MSL_fnc_text);};
    _trade ctrlSetTooltip (["장비를 넣을 빈 슬롯과 수납 공간이 필요합니다. 기존 장비는 먼저 내려놓으세요.","A free slot and storage space are required. Remove existing gear first."] call MSL_fnc_text);
    [[0.23,0.8,0.71,0.065],(["무기고 열기","Open arsenal"] call MSL_fnc_text),{(ctrlParent (_this select 0)) closeDisplay 1; [] call MSL_fnc_arsenal;}] call _button;
    ["RscText",[0.23,0.9,0.71,0.045],(["구매 / 노획 장비만 판매 가능 / 무료 장비는 판매 불가","Sell purchased / captured equipment · Free supplies cannot be sold"] call MSL_fnc_text),[0.55,0.65,0.7,1]] call _mk;
};
_d setVariable ["MSL_body",_controls];

// Establish a fresh refresh baseline after navigation or filtering.
_d setVariable ["MSL_signature",nil];
