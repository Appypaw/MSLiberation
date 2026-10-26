/*
    Run locally in the Arma 3 debug console after loading the desired current
    PRACS, RHS and 3CB Factions releases. Copies a TSV inventory to clipboard.
    Includes hidden/state/preset classes for comparison; does not change arsenal.
    Paste clipboard into mod_weapons.tsv and provide it for preset updating.
*/
private _rows = ["className" + toString [9] + "displayName" + toString [9] + "scope" + toString [9] + "scopeArsenal" + toString [9] + "weaponType" + toString [9] + "baseWeapon" + toString [9] + "linkedItems" + toString [9] + "sourceAddons"];
{
    private _class = configName _x;
    private _lower = toLower _class;
    private _matches = false;
    {
        if ((_lower find _x) == 0) then {_matches = true;};
    } forEach ["pracs_", "rhs_", "rhsusf_", "rhsgref_", "rhssaf_", "uk3cb_"];
    private _type = getNumber (_x >> "type");
    if (_matches && {_type in [1, 2, 4]}) then {
        private _linked = [];
        {
            private _item = getText (_x >> "item");
            if (_item != "") then {_linked pushBackUnique _item;};
        } forEach ("true" configClasses (_x >> "LinkedItems"));
        private _fields = [
            _class,
            getText (_x >> "displayName"),
            str getNumber (_x >> "scope"),
            str getNumber (_x >> "scopeArsenal"),
            str _type,
            _class call BIS_fnc_baseWeapon,
            _linked joinString ";",
            (configSourceAddonList _x) joinString ";"
        ];
        _rows pushBack (_fields joinString toString [9]);
    };
} forEach ("true" configClasses (configFile >> "CfgWeapons"));
copyToClipboard (_rows joinString toString [13, 10]);
hint format ["Exported %1 weapon classes. Paste clipboard into mod_weapons.tsv.", (count _rows) - 1];
