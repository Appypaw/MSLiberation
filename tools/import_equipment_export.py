"""Import class identifiers only; export comments are data, never code."""
import json
import re
import sys
from pathlib import Path

root = Path(__file__).resolve().parents[1]
text = Path(sys.argv[1]).read_text(encoding='utf-8-sig')
sections = re.split(r'// (CfgWeapons|CfgMagazines|CfgVehicles|CfgGlasses)\s*:\s*\d+ classes', text)
names = {'CfgWeapons': 'weapons', 'CfgMagazines': 'magazines', 'CfgVehicles': 'backpacks', 'CfgGlasses': 'goggles'}
out = ['// Imported identifiers; types and handheld ammunition are validated at runtime.']
for i in range(1, len(sections), 2):
    category, body = sections[i:i+2]
    classes = re.findall(r'^\s*"([A-Za-z0-9_]+)"\s*,?\s*(?://[^\n]*)?$', body, re.M)
    classes = list(dict.fromkeys(classes))
    assert classes, category
    out.append('MSL_import_' + names[category] + ' = ' + json.dumps(classes, indent=4) + ';')
    print(category, len(classes))
assert len(out) == 5, 'Expected four exported categories'
(root / 'presets/msl/imported_equipment.sqf').write_text('\n'.join(out) + '\n', encoding='utf-8')
