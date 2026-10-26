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
files.add(ROOT / 'tools/msl_selftest.sqf')
files.add(ROOT / 'tools/msl_preflight.sqf')

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
