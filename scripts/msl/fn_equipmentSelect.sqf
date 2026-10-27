if (!hasInterface || {isRemoteExecuted}) exitWith {};
disableSerialization;
params ["_list","_index"];
if (_index < 0) exitWith {};
private _d = ctrlParent _list;
private _class = _list lbData _index;
_d setVariable ["MSL_selectedEquipment",_class];
private _entries = MSL_shopEntries select {(_x select 0) == _class};
if (_entries isEqualTo []) exitWith {};
private _e = _entries select 0;
private _level = ([((player getVariable ["MSL_stats",[0,0]]) select 1)] call MSL_fnc_progress) select 0;
private _image = "res\ui_arsenal.paa";
{private _cfg = configFile >> _x >> _class; if (isClass _cfg && {getText (_cfg >> "picture") != ""}) exitWith {_image = getText (_cfg >> "picture");};} forEach ["CfgWeapons","CfgMagazines","CfgVehicles","CfgGlasses"];
(_list getVariable "MSL_picture") ctrlSetText _image;
(_list getVariable "MSL_detail") ctrlSetStructuredText composeText [
    text (_e select 1),lineBreak,
    text format ["$%1 / LV.%2",_e select 2,(_e select 3) max 1],lineBreak,
    text ([(["잠김 / 레벨 도달 시 자동 해금","Locked / Unlocks at required level"] call MSL_fnc_text),(["해금 완료","Unlocked"] call MSL_fnc_text)] select ((_e select 3) <= _level))
];
private _mags = _list getVariable "MSL_magList";
private _caption = _list getVariable "MSL_magCaption";
lbClear _mags;
private _compatible = [];
if ((_e select 4) == "weapon") then {_compatible = [_class] call MSL_fnc_compatibleMags;};
{
    private _unlocked = (_x select 3) <= _level;
    private _name = _x select 1;
    private _short = if (count _name > 28) then {(_name select [0,25]) + "..."} else {_name};
    private _i = _mags lbAdd format ["%1 $%2 L%3 %4",[(["잠김","Locked"] call MSL_fnc_text),(["해금","Open"] call MSL_fnc_text)] select _unlocked,_x select 2,_x select 3,_short];
    _mags lbSetData [_i,_x select 0];
    _mags lbSetTooltip [_i,format [(["%1 | $%2 | LV.%3 | %4 | 레벨 도달 시 자동 해금","%1 | $%2 | LV.%3 | %4 | Unlocks by level"] call MSL_fnc_text),_x select 1,_x select 2,(_x select 3) max 1,_x select 0]];
    if (!_unlocked) then {_mags lbSetColor [_i,[0.5,0.56,0.62,1]];};
} forEach _compatible;
private _available = {_x select 3 <= _level} count _compatible;
_caption ctrlSetText (if ((_e select 4) == "weapon") then {format [(["호환 탄창 / 해금 %1 · 전체 %2","Magazines / %1 unlocked of %2"] call MSL_fnc_text),_available,count _compatible]} else {(["호환 탄창 / 무기를 선택하세요","Magazines / Select a weapon"] call MSL_fnc_text)});
if ((_e select 4) == "weapon" && {_compatible isEqualTo []}) then {_caption ctrlSetText (["호환 탄창 / 등록된 탄창 없음","Magazines / None registered"] call MSL_fnc_text);};
if !(_compatible isEqualTo []) then {_mags lbSetCurSel 0;};
