#!/usr/bin/env python3
"""Build explicit attachment prices from custom arsenal; fail on unknown families."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'arsenal_presets/custom.sqf'

def classify(name):
    n = name.lower()
    if any(x in n for x in ['anpas13']): return '열상 조준경',4500,7
    if any(x in n for x in ['anpvs','pvs4','pvs27','1pn']): return '야간 조준경',2200,5
    if any(x in n for x in ['npz','_mtz','adapter']): return '레일 어댑터',100,1
    if any(x in n for x in ['sighthood','aasight','at4_handler','bayonet']): return '기계식 보조 부품',100,1
    if any(x in n for x in ['grip','_rvg_','tdstubby']): return '수직 그립',200,2
    if any(x in n for x in ['harris','bipod']): return '양각대',300,2
    if any(x in n for x in ['perst3_2dp','anpeq15','anpeq16']): return '레이저·복합 모듈',450,3
    if 'perst' in n: return '레이저 모듈',300,2
    if any(x in n for x in ['2dpzenit','m952v','_wmx','flashlight']): return '전술 라이트',150,1
    # Flash hiders and adapters must precede the suppressor name rules.
    if any(x in n for x in ['flashsuppresor','muzzlehider','muzzlebreak','sf3p','sfmb','ardec','falmuzzle','zendl','g36_rotex']): return '소염기·제퇴기',200,1
    if any(x in n for x in ['dtk4','m2010s','sr25s','aac_','sdn6','m24_silencer']): return '고급·정밀 소음기',1100,4
    if any(x in n for x in ['6p9_suppressor','omega9k','rotex_mp7','snds_mp5','muzzle_snds_l','snds_a6aug']): return '권총·기관단총 소음기',600,3
    if any(x in n for x in ['silencer','suppressor','_snds_','_tgpa','_tgpv','_pbs','rotex5','nt4']): return '소총 소음기',800,3
    if any(x in n for x in ['_dtk','_uuk','_ak5','_pgs64']): return '소염기·제퇴기',200,1
    if any(x in n for x in ['dh520','leupoldmk4_2','nxs_5522']): return '초고배율 조준경',1400,5
    if any(x in n for x in ['leupold','premier','m8541','nxs_','_lrt_','zf95','zfsg1']): return '정밀 조준경',1100,4
    if any(x in n for x in ['acog_rmr','su230_mrds','su230a_mrds']): return '배율·도트 복합 조준경',900,3
    if any(x in n for x in ['su230a','specterdr_a','acog_mdo']): return '중장거리 전투 조준경',850,3
    if any(x in n for x in ['su230','specterdr','g33']): return '가변·확대경 복합 조준경',750,3
    if any(x in n for x in ['pgo7','optic_smaw','optic_maaws','m2a1']): return '유탄·대전차 조준경',350,2
    if any(x in n for x in ['pso','1p29','1p78','sniper_base','scope_base','elcan','acog','l2a2','suit','kern','artel','accupoint','stanagzf','zf4x','no32','35x']): return '고정 배율 조준경',600,2
    if any(x in n for x in ['aco_','pkas','1p63','ekp','1p87','nita','okp7','rakurs','compm4','_t1_','rx01','eotech','rm05','mrds','optic_sro','15x']): return '도트·저배율 조준경',350,2
    raise ValueError(f'Unclassified attachment: {name}')

def attachment_rows():
    items = SOURCE.read_text().split('GRLIB_arsenal_items = [',1)[1].split('];',1)[0]
    rows = []
    for line in items.splitlines():
        m = re.search(r'"([^"]+)"',line)
        if not m: continue
        c = m[1]; n = c.lower()
        # Preset section headers contain mixed clothing; use attachment class families.
        if not (n.startswith(('rhs_acc_','rhsusf_acc_','rhsgref_acc_','rhssaf_acc_','uk3cb_optic_','uk3cb_muzzle_','optic_','muzzle_')) or
                'silencer_base' in n or 'sdn6_suppressor' in n or n.startswith('rhs_weap_optic_') or
                n in ['rhs_optic_maaws','rhsgref_mg42_acc_aasight','rhsgref_k98k_acc_sighthood_add','acc_flashlight_pistol','rhsusf_m4muzzlebreak_base']): continue
        category,price,level = classify(c)
        label = line.split('//',1)[1].strip() if '//' in line else c
        rows.append((c,label,category,price,level))
    assert len({r[0].lower() for r in rows}) == len(rows), 'Duplicate attachment'
    return rows

def main():
    rows = attachment_rows()
    out = '// Explicit custom arsenal attachment prices: [class, price, level].\nMSL_attachmentPreset = [\n'
    out += ',\n'.join(f'    ["{c}",{p},{lv}] /* {cat} */' for c,label,cat,p,lv in rows)+'\n];\n'
    (ROOT/'presets/msl/custom_attachments.sqf').write_text(out)
    doc = '''# 부착물·소음기 가격 및 해금

`presets/msl/custom_attachments.sqf`에 클래스별 가격과 레벨을 명시합니다. 현재 custom arsenal의 부착물 계열을 추출하며 의상·장구류가 섞인 섹션 제목에 의존하지 않습니다. 같은 제품의 색상·장착 위치·2D/3D/PiP·전환 상태는 같은 가격입니다. 레이저/라이트 복합 장치는 모드 전환에 관계없이 같은 가격을 적용합니다. PSO의 야간 조명 상태는 실제 야간 투시 조준경과 구분합니다.

기존 엔진의 scope·내부 클래스 필터는 유지합니다. 아래는 설정된 클래스이며 실제 게임에서 표시되는 품목은 모드 설정에 따라 줄어듭니다. 별도 야시경·헬멧 장착형 액세서리는 기존 장비 분류를 유지합니다. 자동 분류보다 이 프리셋을 우선하고 `MSL_priceOverrides`가 최종 예외입니다. 기본 의상 무료 정책은 유지합니다.

미션 재시작 후 적용됩니다. 정적 검증은 게임 내 호환성·실제 기능 검증을 대신하지 않습니다.

| 클래스 | 표시명 참고 | 분류 | 레벨 | 누적 XP | 가격 |
|---|---|---|---:|---:|---:|
'''
    xp=[0,500,1200,2200,3600,5500,8000,11000,15000,20000]
    for c,label,cat,p,lv in rows: doc+=f'| `{c}` | {label.replace("|","/")} | {cat} | {lv} | {xp[lv-1]:,} | ${p:,} |\n'
    (ROOT/'docs/MSL_ATTACHMENT_PRESET.md').write_text(doc)
    print(f'Generated {len(rows)} attachment price rows')

if __name__ == '__main__': main()
