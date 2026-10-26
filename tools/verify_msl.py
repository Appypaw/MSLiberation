#!/usr/bin/env python3
"""Offline integration and SQF analysis. No Arma engine or installed mods required.

Usage: python3 tools/verify_msl.py --sqflint-path /path/to/sqflint-package
Install optional analyzer: python3 -m pip install --target /tmp/msl-sqflint sqflint==0.3.2
The old analyzer lacks findIf: add its documented signature in memory, not to mission code.
This checks syntax/integration, not engine behavior or mod compatibility.
"""
from pathlib import Path
import argparse
import json
import re
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser()
parser.add_argument('--sqflint-path')
args = parser.parse_args()
if args.sqflint_path:
    sys.path.insert(0, args.sqflint_path)
try:
    from sqf.database import EXPRESSIONS
    from sqf.expressions import BinaryExpression, UnaryExpression
    from sqf.types import Array, Code, Number, Keyword, Config
    # Register only missing real engine signatures before parser/analyzer initialization.
    for expression in [BinaryExpression(Array, Keyword('findif'), Code, Number),
                       UnaryExpression(Keyword('configsourceaddonlist'), Config, Array)]:
        if expression not in EXPRESSIONS:
            EXPRESSIONS.append(expression)
    from sqf.parser import parse
    from sqf.analyzer import analyze
    from sqf.exceptions import SQFWarning
except ImportError:
    raise SystemExit('Install sqflint==0.3.2 or pass --sqflint-path; no engine tests were run.')

errors = []
configuration = (ROOT / 'scripts/msl/config.sqf').read_text()
thresholds = json.loads(re.search(r'MSL_levelThresholds\s*=\s*(\[[^;]+\]);', configuration).group(1))
assert len(thresholds) >= 2 and thresholds[0] == 0 and all(a < b for a,b in zip(thresholds, thresholds[1:])), 'Invalid cumulative XP thresholds'
rules = json.loads(re.search(r'MSL_unlockRules\s*=\s*(\[[^;]+\]);', configuration).group(1))
assert all(isinstance(level,int) and 1 <= level <= len(thresholds) for _,level in rules), 'Unlock rule outside configured level range'
def setting(name):
    return json.loads(re.search(rf'{name}\s*=\s*([^;]+);', configuration).group(1))
tiers = setting('MSL_equipmentTiers')
assert len({row[0] for row in tiers}) == len(tiers), 'Duplicate equipment tier'
assert all(len(row) == 3 and row[1] >= 0 and isinstance(row[2], int) and 1 <= row[2] <= len(thresholds) for row in tiers), 'Invalid equipment price/level'
assert not ({row[0] for row in tiers} & {row[0] for row in rules if row[0] not in ['item','goggles','backpack','optic','suppressor','nvg','armor']}), 'Unexpected equipment unlock override'
weapon_text = (ROOT / 'presets/msl/custom_weapons.sqf').read_text()
weapon_rows = [json.loads(row) for row in re.findall(r'\["[^"\n]+",\d+,\d+\]', weapon_text)]
arsenal_weapons = re.findall(r'"([^"\n]+)"', (ROOT / 'arsenal_presets/custom.sqf').read_text().split('];', 1)[0])
assert len({row[0] for row in weapon_rows}) == len(weapon_rows), 'Duplicate weapon price'
assert {row[0] for row in weapon_rows} == set(arsenal_weapons), 'Weapon price coverage mismatch'
assert all(price >= 0 and 1 <= level <= len(thresholds) for _,price,level in weapon_rows), 'Invalid weapon tier'
weapon_prices = {row[0]: row[1:] for row in weapon_rows}
for classname, expected in {
    'rhs_weap_m24sws': [2200,3], 'rhs_weap_m249': [2400,3],
    'rhs_weap_m240B': [2800,4], 'rhs_weap_M320': [1600,3],
    'rhs_weap_m32': [3800,5], 'rhs_weap_rpg75': [900,2],
    'rhs_weap_fgm148': [6500,7], 'uk3cb_auga1_para': [800,1],
}.items():
    assert weapon_prices[classname] == expected, f'Incorrect weapon family: {classname}'
assert all(weapon_prices[row[2]] == [0,1] for row in setting('MSL_freeKits')), 'Free primary kit pricing mismatch'
assert '["uniform",0,1]' in configuration, 'Basic uniforms must remain free'
catalog = (ROOT / 'scripts/msl/fn_catalog.sqf').read_text()
assert catalog.index('forEach MSL_weaponPreset') < catalog.index('forEach MSL_priceOverrides') < catalog.index('if (_unlockKey == "uniform")'), 'Invalid preset/override/free uniform priority'
from build_msl_attachment_preset import attachment_rows
attachment_text = (ROOT / 'presets/msl/custom_attachments.sqf').read_text()
attachment_prices = [json.loads(row) for row in re.findall(r'\["[^"\n]+",\d+,\d+\]', attachment_text)]
assert attachment_prices == [[c,p,lv] for c,label,cat,p,lv in attachment_rows()], 'Stale attachment preset; run tools/build_msl_attachment_preset.py'
assert len({c for c,p,lv in attachment_prices}) == len(attachment_prices), 'Duplicate attachment price'
assert all(p > 0 and 1 <= lv <= len(thresholds) for c,p,lv in attachment_prices), 'Invalid attachment tier'
ap = {c:[p,lv] for c,p,lv in attachment_prices}
assert ap['rhs_acc_dtk4short'] == [1100,4] and ap['rhs_acc_dtk3'] == [200,1], 'Suppressor/muzzle brake confusion'
assert ap['rhsusf_acc_m14_flashsuppresor'] == [200,1], 'Flash suppressor is not a sound suppressor'
assert ap['rhs_acc_pso1m2_ads_night'] == ap['rhs_acc_pso1m2'], 'Reticle illumination is not night vision'
assert ap['rhsusf_acc_anpas13gv1'] == [4500,7] and ap['rhsusf_acc_anpvs27'] == [2200,5], 'Thermal/night tiers'
assert ap['rhsusf_acc_rotex5_grey'] == ap['rhsusf_acc_rotex5_tan'], 'Camo price mismatch'
assert ap['rhsusf_acc_anpeq15_light'] == ap['rhsusf_acc_anpeq15'], 'Switchable module price mismatch'
assert 'preprocessFileLineNumbers "presets\\msl\\custom_attachments.sqf"' in configuration, 'Attachment preset not loaded'
assert catalog.index('forEach MSL_attachmentPreset') < catalog.index('forEach MSL_priceOverrides'), 'Attachment override priority'
hold = setting('MSL_defenseHoldRange')
assert 600 <= hold[0] <= hold[1] <= 1200, 'Defense hold must stay within 10..20 minutes'
fob = setting('MSL_fobCounterDelay')
assert 300 <= fob[0] + 60 <= fob[1] + 60 <= 600, 'FOB departure must respect 5..10 minute scenario window'
assert all(0 <= setting(k) <= 1 for k in ['MSL_cityCounterChance','MSL_fobCounterChance']), 'Scenario chance must be a probability'
assert setting('MSL_scenarioCooldown') >= hold[1], 'Large defense scenarios can overlap their pacing window'
module = ROOT / 'scripts/msl'
functions = re.findall(r'class\s+(\w+)\s*\{', (module / 'CfgFunctions.hpp').read_text())[2:]
for name in functions:
    if not (module / f'fn_{name}.sqf').exists():
        errors.append(f'Missing registered function: {name}')
registered = {f'MSL_fnc_{name}'.lower() for name in functions}
for path in list(module.glob('*.sqf')) + [ROOT / 'tools/msl_selftest.sqf']:
    for function in re.findall(r'\bMSL_fnc_\w+', path.read_text()):
        if function.lower() not in registered:
            errors.append(f'{path.relative_to(ROOT)}: unregistered {function}')
assert '#include "scripts\\msl\\CfgFunctions.hpp"' in (ROOT / 'description.ext').read_text()
assert 'preprocessFileLineNumbers "scripts\\msl\\config.sqf"' in (ROOT / 'init.sqf').read_text()
# Preserve non-weapon entries except the explicitly removed Tier1 mod equipment.
original = subprocess.check_output(['git', 'show', 'HEAD:arsenal_presets/custom.sqf'], cwd=ROOT, text=True)
current = (ROOT / 'arsenal_presets/custom.sqf').read_text()
def without_tier1(text):
    text = re.sub(r'^\s*"Tier1_[^\n]*\n', '', text, flags=re.MULTILINE | re.IGNORECASE)
    return re.sub(r',([ \t]*(?://[^\n]*)?\n\s*\];)', r'\1', text)
assert without_tier1(original.split('];', 1)[1]) == current.split('];', 1)[1], 'Unexpected non-weapon arsenal change'
assert not re.search(r'"tier1_', current, re.IGNORECASE), 'Tier1 equipment remains'
kits = setting('MSL_freeKits')
assert len(kits) == 6 and len({row[0] for row in kits}) == len(kits), 'Expected six unique free kits'
assert all(len(row) == 4 and row[2] for row in kits), 'Invalid free kit definition'
request = (module / 'fn_request.sqf').read_text()
assert '_gear = [""] call MSL_fnc_buildKit' in request, 'New profiles must spawn in uniform only'
assert '_freeWeapons' in (module / 'fn_postInit.sqf').read_text(), 'Free weapons must be excluded from paid catalog'
changed = subprocess.check_output(['git', 'diff', '--name-only'], cwd=ROOT, text=True).splitlines()
files = {ROOT / p for p in changed if p.endswith('.sqf') and p != 'arsenal_presets/custom.sqf'}
files.update(module.glob('*.sqf'))
files.add(ROOT / 'presets/msl/custom_weapons.sqf')
files.add(ROOT / 'presets/msl/custom_attachments.sqf')
files.add(ROOT / 'tools/msl_selftest.sqf')
files.add(ROOT / 'tools/msl_preflight.sqf')
files.add(ROOT / 'tools/msl_performance.sqf')

def diagnostics(text):
    try:
        a = analyze(parse(text))
        return [str(e) for e in a.exceptions if not isinstance(e, SQFWarning)]
    except Exception as exc:
        return [str(exc)]

checked = 0
for path in sorted(files):
    actual = diagnostics(path.read_text())
    # Old upstream code can contain existing analyzer findings; reject new findings.
    baseline = []
    if path.relative_to(ROOT).as_posix() in changed:
        base = subprocess.check_output(['git', 'show', f'HEAD:{path.relative_to(ROOT).as_posix()}'], cwd=ROOT, text=True)
        baseline = diagnostics(base)
    # Compare messages without source coordinates because inserted lines move upstream findings.
    normalize = lambda s: re.sub(r'\[\d+,\d+\]', '[line]', s)
    old = {normalize(e) for e in baseline}
    for finding in actual:
        if normalize(finding) not in old:
            errors.append(f'{path.relative_to(ROOT)}: {finding}')
    checked += 1
if errors:
    print('\n'.join(errors)); raise SystemExit(1)
print(f'PASS: {checked} SQF files analyzed; {len(functions)} functions registered; arsenal boundaries intact.')
print('Engine assertions and multiplayer acceptance checks have NOT been executed.')
