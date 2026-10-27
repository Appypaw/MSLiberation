if (!hasInterface || {isRemoteExecuted}) exitWith {};
disableSerialization;
params ["_d","_mk","_button","_level","_progress"];
(_d displayCtrl 8004) ctrlSetText (["장비 도감 / 무기와 호환 탄창","Catalog / Weapons and magazines"] call MSL_fnc_text);
["RscText",[0.23,0.18,0.71,0.045],format ["LV.%1  %2 / %3",_level,MSL_levelTitles param [_level - 1,"OPERATOR"],if (_level >= count MSL_levelThresholds) then {(["최고 레벨","Max level"] call MSL_fnc_text)} else {format [(["다음 레벨까지 %1 XP","%1 XP to next level"] call MSL_fnc_text),(_progress select 2) - ((player getVariable ["MSL_stats",[0,0]]) select 1)]}]] call _mk;
private _bar = ["RscProgress",[0.23,0.24,0.71,0.008]] call _mk;
_bar progressSetPosition (_progress select 3); _bar ctrlSetTextColor [0.36,0.65,1,1];
private _filters = [
    [[0.23,0.28,0.23,0.05],"MSL_category",[
        [(["모든 무기","All weapons"] call MSL_fnc_text),"weapon"],[(["소총","Rifles"] call MSL_fnc_text),"rifle"],[(["기관단총","SMGs"] call MSL_fnc_text),"smg"],[(["기관총","Machine guns"] call MSL_fnc_text),"mg"],[(["저격총","Sniper rifles"] call MSL_fnc_text),"sniper"],[(["권총","Pistols"] call MSL_fnc_text),"pistol"],[(["산탄총","Shotguns"] call MSL_fnc_text),"shotgun"],[(["발사기 / 유탄발사기","Launchers"] call MSL_fnc_text),"launcher"],
        [(["탄창 / 탄약","Magazines / Ammo"] call MSL_fnc_text),"magazine"],[(["수류탄 / 폭발물","Grenades / Explosives"] call MSL_fnc_text),"explosive"],[(["부착물","Attachments"] call MSL_fnc_text),"attachment"],[(["의복 / 장비","Clothing / Gear"] call MSL_fnc_text),"gear"],[(["전체 장비","All equipment"] call MSL_fnc_text),"all"]],"weapon"],
    [[0.48,0.28,0.22,0.05],"MSL_browserLevel",[[(["전체 레벨","All levels"] call MSL_fnc_text),-1]],-1],
    [[0.72,0.28,0.22,0.05],"MSL_unlockFilter",[[(["해금 + 잠김","All unlock states"] call MSL_fnc_text),0],[(["해금된 장비만","Unlocked only"] call MSL_fnc_text),1],[(["잠긴 장비만","Locked only"] call MSL_fnc_text),2]],0]
];
for "_tier" from 1 to count MSL_levelThresholds do {
    ((_filters select 1) select 2) pushBack [format ["LV.%1 / %2 XP",_tier,MSL_levelThresholds select (_tier - 1)],_tier];
};
{
    _x params ["_rect","_key","_options","_default"];
    private _combo = ["RscCombo",_rect] call _mk;
    private _selected = 0;
    {
        _x params ["_label","_value"];
        private _i = _combo lbAdd _label;
        if (_value isEqualTo (_d getVariable [_key,_default])) then {_selected = _i;};
    } forEach _options;
    _combo setVariable ["MSL_filterKey",_key]; _combo setVariable ["MSL_options",_options];
    _combo lbSetCurSel _selected;
    _combo ctrlAddEventHandler ["LBSelChanged",{
        params ["_combo","_index"];
        if (_index < 0) exitWith {};
        private _d = ctrlParent _combo;
        _d setVariable [_combo getVariable "MSL_filterKey",((_combo getVariable "MSL_options") select _index) select 1];
        _d setVariable ["MSL_browserPage",0];
        [_d] call MSL_fnc_terminalRender;
    }];
} forEach _filters;
private _search = ["RscEdit",[0.23,0.36,0.54,0.05],_d getVariable ["MSL_browserQuery",""]] call _mk;
_search ctrlSetTooltip (["무기명 / 탄창명 / 클래스명 검색","Search weapon / magazine / class name"] call MSL_fnc_text);
private _apply = [[0.79,0.36,0.15,0.05],(["검색","Search"] call MSL_fnc_text),{
    private _b = _this select 0; private _d = ctrlParent _b;
    _d setVariable ["MSL_browserQuery",ctrlText (_b getVariable "MSL_search")];
    _d setVariable ["MSL_browserPage",0]; [_d] call MSL_fnc_terminalRender;
}] call _button;
_apply setVariable ["MSL_search",_search];
private _category = _d getVariable ["MSL_category","weapon"];
private _tier = _d getVariable ["MSL_browserLevel",-1];
private _state = _d getVariable ["MSL_unlockFilter",0];
private _query = toLower (_d getVariable ["MSL_browserQuery",""]);
private _rows = [];
{
    _x params ["_class","_name","_price","_required","_kind"];
    if ((_tier < 0 || {(_required max 1) == _tier}) && {(_state == 0) || {_state == 1 && {_required <= _level}} || {_state == 2 && {_required > _level}}} && {_query == "" || {(toLower (_name + " " + _class) find _query) >= 0}}) then {
        if (_category == "all" || {_category == "weapon" && {_kind == "weapon"}} || {_category == ([_x] call MSL_fnc_equipmentCategory)}) then {
            _rows pushBack [_required max 1,toLower _name,_class,_x];
        };
    };
} forEach MSL_shopEntries;
_rows sort true;
private _pages = (ceil (count _rows / 50)) max 1;
private _page = (_d getVariable ["MSL_browserPage",0]) min (_pages - 1);
_d setVariable ["MSL_browserPage",_page];
private _list = ["RscListbox",[0.23,0.44,0.35,0.40]] call _mk;
private _picture = ["RscPicture",[0.61,0.44,0.33,0.09],"res\ui_arsenal.paa"] call _mk;
private _detail = ["RscStructuredText",[0.61,0.54,0.33,0.12]] call _mk;
private _caption = ["RscText",[0.61,0.665,0.33,0.04],(["호환 탄창 / 무기를 선택하세요","Magazines / Select a weapon"] call MSL_fnc_text)] call _mk;
private _magList = ["RscListbox",[0.61,0.71,0.33,0.13]] call _mk;
_magList ctrlSetTooltip (["호환 탄창을 더블클릭하면 해당 탄창의 도감과 해금 레벨로 이동합니다.","Double-click a magazine to view its catalog entry and unlock level."] call MSL_fnc_text);
_magList ctrlAddEventHandler ["LBDblClick",{
    params ["_list","_index"];
    if (_index < 0) exitWith {};
    private _class = _list lbData _index;
    private _entries = MSL_shopEntries select {(_x select 0) == _class};
    if (_entries isEqualTo []) exitWith {};
    private _e = _entries select 0; private _d = ctrlParent _list;
    _d setVariable ["MSL_category",[_e] call MSL_fnc_equipmentCategory];
    _d setVariable ["MSL_browserLevel",(_e select 3) max 1];
    _d setVariable ["MSL_unlockFilter",0];
    _d setVariable ["MSL_browserQuery",_class];
    _d setVariable ["MSL_browserPage",0];
    _d setVariable ["MSL_selectedEquipment",_class];
    [_d] call MSL_fnc_terminalRender;
}];
_list setVariable ["MSL_picture",_picture]; _list setVariable ["MSL_detail",_detail];
_list setVariable ["MSL_magCaption",_caption]; _list setVariable ["MSL_magList",_magList];
_list ctrlAddEventHandler ["LBSelChanged",{_this call MSL_fnc_equipmentSelect;}];
private _selected = 0;
{
    (_x select 3) params ["_class","_name","_price","_required"];
    private _unlocked = _required <= _level;
    private _i = _list lbAdd format ["%1 · LV.%2",_name,_required max 1];
    _list lbSetData [_i,_class];
    _list lbSetTooltip [_i,format ["%1 | $%2 | LV.%3 | %4 | %5",_name,_price,_required max 1,_class,[(["잠김","Locked"] call MSL_fnc_text),(["해금 완료","Unlocked"] call MSL_fnc_text)] select _unlocked]];
    if (!_unlocked) then {_list lbSetColor [_i,[0.5,0.56,0.62,1]];};
    if (_class == (_d getVariable ["MSL_selectedEquipment",""])) then {_selected = _i;};
} forEach (_rows select [_page * 50,50]);
if (_rows isEqualTo []) then {_detail ctrlSetStructuredText parseText (["조건에 맞는 장비가 없습니다.<br/>필터나 검색어를 바꿔주세요.","No matching equipment.<br/>Change the filters or search."] call MSL_fnc_text);} else {_list lbSetCurSel _selected;};
{
    _x params ["_xPos","_label","_delta"];
    private _b = [[_xPos,0.865,0.095,0.05],_label,{
        private _b = _this select 0; private _d = ctrlParent _b;
        _d setVariable ["MSL_browserPage",((_d getVariable ["MSL_browserPage",0]) + (_b getVariable "MSL_delta")) max 0];
        [_d] call MSL_fnc_terminalRender;
    }] call _button;
    _b setVariable ["MSL_delta",_delta];
    _b ctrlEnable (if (_delta < 0) then {_page > 0} else {_page + 1 < _pages});
} forEach [[0.23,(["이전","Prev"] call MSL_fnc_text),-1],[0.485,(["다음","Next"] call MSL_fnc_text),1]];
["RscText",[0.335,0.865,0.145,0.05],format [(["%1 / %2 · %3개","%1 / %2 · %3 items"] call MSL_fnc_text),_page + 1,_pages,count _rows]] call _mk;
private _open = [[0.61,0.865,0.33,0.05],(["무기고에서 장비 선택","Select gear in arsenal"] call MSL_fnc_text),{(ctrlParent (_this select 0)) closeDisplay 1; [] call MSL_fnc_arsenal;}] call _button;
_open ctrlEnable ([player] call MSL_fnc_atBase);
_open ctrlSetTooltip (["본진 / FOB 보급소에서 이용할 수 있습니다.","Available at base / FOB supply points."] call MSL_fnc_text);
["RscText",[0.23,0.95,0.71,0.035],(["레벨 도달 시 자동 해금 · 탄창별 해금 레벨 적용 · 수령 시 결제","Unlocks by level · Magazine levels apply · Pay on collection"] call MSL_fnc_text),[0.55,0.65,0.7,1]] call _mk;
