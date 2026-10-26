# 무기 가격·해금 프리셋

현재 custom arsenal의 모든 무기 클래스에 명시적 가격·레벨을 지정합니다. 같은 계열의 위장색·탄창·개머리판 변형은 동일한 기준을 적용하며, 유탄발사기 일체형은 추가 가격을 적용합니다. 무료 보급 6종은 유지합니다. 부착물·탄약은 별도 가격입니다.

실제 적용 파일: `presets/msl/custom_weapons.sqf`. `scripts/msl/config.sqf`에서 로드하며 `MSL_priceOverrides`로 최종 예외를 지정할 수 있습니다. 품목 목록은 `arsenal_presets/custom.sqf`를 유지합니다. 게임에서 없는 클래스, 비공개 클래스, 부착물 포함 파생 무기는 기존 카탈로그 필터에 따라 제외됩니다. 아래는 설정 목록이며 실제 상점 표시를 보장하는 목록은 아닙니다.

기본 전투복을 포함한 일반 uniform은 Lv1/$0으로 구매할 수 있습니다. 길리·잠수복만 기존 유료 티어를 유지합니다. 무료 의상의 판매 가치는 $0이며 유료 예외 설정으로도 기본 의상에 요금이 붙지 않습니다. 기존 XP와 현금은 유지하고 미션 재시작 후 적용합니다.

| 클래스 | 표시명 참고 | 분류 | 레벨 | 누적 XP | 가격 |
|---|---|---|---:|---:|---:|
| `UK3CB_CZ550` | UK3CB_CZ550 | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `UK3CB_M14DMR` | UK3CB_M14DMR | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_M14DMR_BLK` | UK3CB_M14DMR_BLK | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_M14DMR_Railed_BLK` | UK3CB_M14DMR_Railed_BLK | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_M14DMR_Railed` | UK3CB_M14DMR_Railed | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_M16A1_LSW` | UK3CB_M16A1_LSW | 분대지원화기 | 3 | 1,200 | $1,800 |
| `UK3CB_M16A2` | UK3CB_M16A2 | 무료 보급 | 1 | 0 | $0 |
| `UK3CB_M16A2_UGL` | UK3CB_M16A2_UGL | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `UK3CB_M16A3` | UK3CB_M16A3 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_M21` | UK3CB_M21 | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_BHP` | UK3CB_BHP | 권총 | 1 | 0 | $400 |
| `UK3CB_CZ75` | UK3CB_CZ75 | 권총 | 1 | 0 | $400 |
| `rhs_weap_pp2000` | PP-2000 | 기관단총 | 1 | 0 | $800 |
| `rhs_weap_m76` | M76 | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak74m` | AK-74M | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_camo` | AK-74M (Camo) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_npz` | AK-74M (B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_desert_npz` | AK-74M (Desert/B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_camo_npz` | AK-74M (Camo/B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_desert` | AK-74M (Desert) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_gp25` | AK-74M (GP-25) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_ak74m_gp25_npz` | AK-74M (GP-25/B-13) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_ak74m_fullplum` | AK-74M (Plum) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_fullplum_npz` | AK-74M (Plum/B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak74m_fullplum_gp25` | AK-74M (GP-25/Plum) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_ak74m_fullplum_gp25_npz` | AK-74M (GP-25/Plum/B-13) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_ak74m_zenitco01` | AK-74M (Zenitco) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak74m_zenitco01_npz` | AK-74M (Zenitco/B-13) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak74m_zenitco01_b33` | AK-74M (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak74mr` | AK-74MR (UUK) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak74mr_gp25` | AK-74MR (UUK/GP-25) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_ak105` | AK-105 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak105_zenitco01` | AK-105 (Zenitco) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak105_zenitco01_npz` | AK-105 (Zenitco/B-13) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak105_npz` | AK-105 (B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak105_zenitco01_b33` | AK-105 (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_akm` | AKM | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_akm_gp25` | AKM (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_akmn` | AKMN | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_akmn_gp25` | AKMN (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_akmn_npz` | AKMN (NPZ) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_akmn_gp25_npz` | AKMN (GP-25/NPZ) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_akm_zenitco01_b33` | AKM (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_akms` | AKMS | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_akms_gp25` | AKMS (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_pm63` | PM-63 | 기관단총 | 1 | 0 | $800 |
| `rhs_weap_ak103` | AK-103 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak103_npz` | AK-103 (B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak103_zenitco01` | AK-103 (Zenitco) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak103_zenitco01_npz` | AK-103 (Zenitco/B-13) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak103_zenitco01_b33` | AK-103 (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak103_1` | AK-103-1 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak103_1_npz` | AK-103-1 (B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak103_2` | AK-103-2 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak103_2_npz` | AK-103-2 (B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak103_gp25` | AK-103 (GP-25) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_ak103_gp25_npz` | AK-103 (GP-25/B-13) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_ak104` | AK-104 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak104_npz` | AK-104 (B-13) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_ak104_zenitco01` | AK-104 (Zenitco) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak104_zenitco01_npz` | AK-104 (Zenitco/B-13) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak104_zenitco01_b33` | AK-104 (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_ak74` | AK-74 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_ak74_gp25` | AK-74 (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_ak74n` | AK-74N | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_ak74n_gp25` | AK-74N (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_ak74n_npz` | AK-74N (NPZ) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_ak74n_gp25_npz` | AK-74N (GP-25/NPZ) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_ak74_2` | AK-74 (Plum) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_ak74n_2` | AK-74N (Plum) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_ak74n_2_npz` | AK-74N (Plum/B-13) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_ak74n_2_gp25` | AK-74N (Plum/GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_ak74n_2_gp25_npz` | AK-74N (Plum/GP-25/B-13) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_ak74_3` | AK-74 (Green) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74` | AKS-74 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74_2` | AKS-74 (Plum) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74_gp25` | AKS-74 (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_aks74n` | AKS-74N | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74n_npz` | AKS-74N (NPZ) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74n_2` | AKS-74N (Plum) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74n_2_npz` | AKS-74N (Plum/B-13) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74n_gp25` | AKS-74N (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_aks74n_gp25_npz` | AKS-74N (GP-25/NPZ) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_aks74u` | AKS-74U | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_aks74un` | AKS-74UN | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_asval` | AS Val | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `rhs_weap_asval_npz` | AS Val (NPZ) | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `rhs_weap_vss` | VSS Vintorez | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `rhs_weap_vss_npz` | VSS Vintorez (NPZ) | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `rhs_weap_svd` | SVD | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_svdp` | SVDM | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_svdp_npz` | SVDM (NPZ) | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_svdp_wd` | SVDM (Camo) | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_svdp_wd_npz` | SVDM (Camo/NPZ) | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_svds` | SVDS | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_svds_npz` | SVDS (NPZ) | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_t5000` | T-5000 | 고급 저격총 | 5 | 3,600 | $3,800 |
| `rhs_weap_pkp` | PKP | 고급 기관총 | 5 | 3,600 | $3,800 |
| `rhs_weap_pkm` | PKM | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_rpk74m` | RPK-74M | 분대지원화기 | 3 | 1,200 | $1,800 |
| `rhs_weap_rpk74m_npz` | RPK-74M (B-13) | 분대지원화기 | 3 | 1,200 | $1,800 |
| `rhs_weap_rpk74m_uuk` | RPK-74M (B-13) | 분대지원화기 | 3 | 1,200 | $1,800 |
| `rhs_weap_XM2010` | M2010 ESR | 고급 저격총 | 5 | 3,600 | $3,800 |
| `rhs_weap_XM2010_d` | M2010 ESR (Desert) | 고급 저격총 | 5 | 3,600 | $3,800 |
| `rhs_weap_XM2010_wd` | M2010 ESR (Camo) | 고급 저격총 | 5 | 3,600 | $3,800 |
| `rhs_weap_XM2010_sa` | M2010 ESR (Semi-arid) | 고급 저격총 | 5 | 3,600 | $3,800 |
| `rhs_weap_m24sws` | M24 SWS | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m24sws_d` | M24 SWS (Desert) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m24sws_wd` | M24 SWS (Woodland) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m24sws_blk` | M24 SWS (Black) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m24sws_ghillie` | M24 SWS (Ghillie) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m40a5` | M40A5 | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m40a5_d` | M40A5 (Desert) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m40a5_wd` | M40A5 (Woodland) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4` | M4 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4_pmag` | M4 (PMAG) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4_mstock` | M4 (Magpull Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4_carryhandle` | M4 (Carryhandle) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4_carryhandle_pmag` | M4 (Carryhandle/PMAG) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4_carryhandle_mstock` | M4 (Carryhandle/Magpull Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4_m320` | M4 (M320) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4_m203` | M4 (M203) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4_m203S` | M4 (M203S) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4_carryhandle_m203` | M4 (Carryhandle/M203) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4_carryhandle_m203S` | M4 (Carryhandle/M203S) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1` | M4A1 PIP | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_d` | M4A1 PIP (Desert) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_wd` | M4A1 PIP (Woodland) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_mstock` | M4A1 PIP (Magpull Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_d_mstock` | M4A1 PIP (Desert/Magpull Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_wd_mstock` | M4A1 PIP (Woodland/Magpull Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_pmag` | M4A1 PIP (PMAG) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_carryhandle` | M4A1 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_carryhandle_mstock` | M4A1 (Magpull Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_carryhandle_pmag` | M4A1 (PMAG) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m4a1_m203` | M4A1 PIP (M203) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_m203s` | M4A1 PIP (M203S) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_m203s_wd` | M4A1 PIP (Woodland/M203S) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_m203s_d` | M4A1 PIP (Desert/M203S) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_m203s_sa` | M4A1 (M203S/Semi-Arid) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_carryhandle_m203` | M4A1 (M203) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_carryhandle_m203S` | M4A1 (M203S) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_m320` | M4A1 PIP (M320) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m4a1_blockII` | M4A1 Block II | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_bk` | M4A1 Block II (Black Rail) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_wd` | M4A1 Block II (Woodland) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_d` | M4A1 Block II (Desert) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_KAC` | M4A1 Block II (SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_KAC_bk` | M4A1 Block II (Black Rail/SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_KAC_wd` | M4A1 Block II (Woodland/SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_KAC_d` | M4A1 Block II (Desert/SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m4a1_blockII_M203` | M4A1 Block II (M203) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_m4a1_blockII_M203_bk` | M4A1 Block II (Black Rail/M203) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_m4a1_blockII_M203_d` | M4A1 Block II (Desert/M203) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_m4a1_blockII_M203_wd` | M4A1 Block II (Woodland/M203) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_mk18` | Mk 18 Mod 1 | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_bk` | Mk 18 Mod 1 (Black Rail) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_wd` | Mk 18 Mod 1 (Woodland) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_d` | Mk 18 Mod 1 (Desert) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_KAC` | Mk 18 Mod 1 (SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_KAC_bk` | Mk 18 Mod 1 (Black Rail/SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_KAC_wd` | Mk 18 Mod 1 (Woodland/SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_KAC_d` | Mk 18 Mod 1 (Desert/SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk18_m320` | Mk 18 Mod 1 (M320) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_m16a4` | M16A4 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m16a4_pmag` | M16A4 (PMAG) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m16a4_imod` | M16A4 (IMOD Stock) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m16a4_carryhandle` | M16A4 (Carryhandle) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m16a4_carryhandle_pmag` | M16A4 (Carryhandle/PMAG) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m16a4_carryhandle_M203` | M16A4 (Carryhandle/M203) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m16a4_imod_M203` | M16A4 (IMOD Stock/M203) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_hk416d10` | HK416 D10 | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d145` | HK416 D14.5 | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d10_LMT` | HK416 D10 (SOPMOD Stock) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d10_m320` | HK416 D10 (M320) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_hk416d145_m320` | HK416 D14.5 (M320) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `rhs_weap_hk416d10_LMT_d` | HK416 D10 (SOPMOD Stock/Desert) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d10_LMT_wd` | HK416 D10 (SOPMOD Stock/Woodland) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d145_d` | HK416 D14.5 (Desert Grass) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d145_d_2` | HK416 D14.5 (Desert Net) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d145_wd` | HK416 D14.5 (Woodland Grass) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_hk416d145_wd_2` | HK416 D14.5 (Woodland Net) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m27iar` | M27 IAR | 분대지원화기 | 3 | 1,200 | $1,800 |
| `rhs_weap_m249` | M249 | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_pip_S` | M249 PIP (Short/Savit) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_pip_S_para` | M249 PIP (Short/Para) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_light_S` | M249 PIP (Short/LCBA) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_pip` | M249 PIP | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_pip_ris` | M249 PIP (RIS) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_pip_L` | M249 PIP (Long/Savit) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_pip_L_para` | M249 PIP (Long/Para) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m249_light_L` | M249 PIP (Long/LCBA) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhs_weap_m240B` | M240B | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_m240G` | M240G | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_m240B_CAP` | M240B (CAP) | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_m14` | M14 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_wd` | M14 (Woodland) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_d` | M14 (Desert) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_fiberglass` | M14 (Fiberglass) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_rail` | M14 (Rail) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_rail_wd` | M14 (Rail/Woodland) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_rail_d` | M14 (Rail/Desert) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_rail_fiberglass` | M14 (Rail/Fiberglass) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_ris` | M14 (RIS) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_ris_wd` | M14 (RIS/Woodland) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_ris_d` | M14 (RIS/Desert) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_ris_fiberglass` | M14 (RIS/Fiberglass) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_socom` | SOCOM 16 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14_socom_rail` | SOCOM 16 (Rail) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m14ebrri` | M14 EBR-RI | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_sr25` | Mk 11 Mod 0 | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_sr25_ec` | Mk 11 Mod 0 (EC) | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_sr25_wd` | Mk 11 Mod 0 (Woodland) | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_sr25_ec_wd` | Mk 11 Mod 0 (EC/Woodland) | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_sr25_d` | Mk 11 Mod 0 (Desert) | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_sr25_ec_d` | Mk 11 Mod 0 (EC/Desert) | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_m110` | KAC M-110 | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_M107` | M107 | 대물 저격총 | 7 | 8,000 | $6,000 |
| `rhs_weap_M107_d` | M107 (Desert) | 대물 저격총 | 7 | 8,000 | $6,000 |
| `rhs_weap_M107_w` | M107 (Woodland) | 대물 저격총 | 7 | 8,000 | $6,000 |
| `rhs_weap_M107_lc` | M107 (Woodland) | 대물 저격총 | 7 | 8,000 | $6,000 |
| `rhs_weap_M590_5RD` | M590A1 (Short) | 산탄총 | 1 | 0 | $650 |
| `rhs_weap_M590_8RD` | M590A1 (Long) | 산탄총 | 1 | 0 | $650 |
| `rhs_weap_m32` | M32 MGL | 회전식 유탄발사기 | 5 | 3,600 | $3,800 |
| `rhsusf_weap_MP7A2` | MP7A2 | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhsusf_weap_MP7A2_winter` | MP7A2 (Winter) | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhsusf_weap_MP7A2_desert` | MP7A2 (Desert) | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhsusf_weap_MP7A2_aor1` | MP7A2 (AOR1) | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhsusf_weap_MP7A1_winter` | MP7A2 (Winter) | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhsusf_weap_MP7A1_desert` | MP7A2 (Desert) | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhsusf_weap_MP7A1_aor1` | MP7A2 (AOR1) | 현대 PDW | 3 | 1,200 | $1,800 |
| `rhs_weap_mk17_CQC` | Mk 17 Mod 0 (CQC) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk17_STD` | Mk 17 Mod 0 (STD) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_mk17_LB` | Mk 17 Mod 0 (LB) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_USA_CQC` | SCAR-H (USA/CQC) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_USA_STD` | SCAR-H (USA/STD) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_USA_LB` | SCAR-H (USA/LB) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_m4a1_m320` | M4A1 PIP (M320) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_m4_m320` | M4 (M320) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m39` | M39 EMR | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `rhs_weap_m38_rail` | Mosin Nagant M38 (Railed) | 구형 보병화기 | 1 | 0 | $650 |
| `rhs_weap_kar98k` | Karabiner 98 Kurz | 구형 보병화기 | 1 | 0 | $650 |
| `rhs_weap_m38` | Mosin Nagant M38 | 구형 보병화기 | 1 | 0 | $650 |
| `rhs_weap_mosin_sbr` | Mosin SBR | 구형 보병화기 | 1 | 0 | $650 |
| `rhs_weap_dsr1` | DSR-1 | 고급 저격총 | 5 | 3,600 | $3,800 |
| `rhs_weap_m70ab2` | M70AB2 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m70b1` | M70B1 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m92` | M92 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m21a` | M21A | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m21a_pr` | M21A (Rail) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m21s` | M21S | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_m21s_pr` | M21S (Rail) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_savz61` | Sa vz. 61 | 기관단총 | 1 | 0 | $800 |
| `rhs_weap_savz58p` | Sa vz. 58P | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58v` | Sa vz. 58V | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58p_rail` | Sa vz. 58P (Rail) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58v_rail` | Sa vz. 58V (Rail) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58v_ris` | Sa vz. 58V (RIS) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58p_black` | Sa vz. 58P (Black) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58v_black` | Sa vz. 58V (Black) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58p_rail_black` | Sa vz. 58P (Rail, Black) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_savz58v_rail_black` | Sa vz. 58V (Rail, Black) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_Izh18` | IZh-18 12 Gauge | 산탄총 | 1 | 0 | $650 |
| `rhs_weap_vhsd2` | VHS-D2 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_vhsd2_bg` | VHS-D2 (VHS-BG) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_vhsd2_ct15x` | VHS-D2 (CT-1.5x) | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_vhsd2_bg_ct15x` | VHS-D2 (VHS-BG/CT-1.5x) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_vhsk2` | VHS-K2 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_stgw57` | Stgw 57 | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m3a1` | M3A1 | 기관단총 | 1 | 0 | $800 |
| `rhs_weap_m3a1_specops` | M3A1 (SD) | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `rhs_weap_MP44` | MP44 | 구형 보병화기 | 1 | 0 | $650 |
| `rhs_weap_m1garand_sa43` | M1 Garand | 구형 보병화기 | 1 | 0 | $650 |
| `rhs_weap_mg42` | MG42 | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_mg42_aa` | MG42 | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_m79` | M79 | 독립 유탄발사기 | 3 | 1,200 | $1,600 |
| `rhs_weap_l1a1` | L1A1 (Polymer) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_l1a1_wood` | L1A1 (Wood) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_lzh18` | rhs_weap_lzh18 | 산탄총 | 1 | 0 | $650 |
| `rhs_weap_fnmag` | FN MAG | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_m70b1n` | M70B1N | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m70b3n` | M70B3N | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhs_weap_m70b3n_pbg40` | M70B3N (PBG) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `rhs_weap_m21a_pr_pbg40` | M21A (Rail/PBG) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m21a_pbg40` | M21A (PBG) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_m82a1` | M82A1 | 대물 저격총 | 7 | 8,000 | $6,000 |
| `rhs_weap_scorpion` | M84A Scorpion | 기관단총 | 1 | 0 | $800 |
| `rhs_weap_g36c` | HK G36C | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_g36kv` | HK G36KV | 표준 돌격소총 | 2 | 500 | $1,500 |
| `rhs_weap_g36kv_ag36` | HK G36KV (AG36) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `rhs_weap_SCARH_CQC` | SCAR-H (CQC) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_STD` | SCAR-H (STD) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_LB` | SCAR-H (LB) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_FDE_CQC` | SCAR-H (CQC) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_FDE_STD` | SCAR-H (STD) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_SCARH_FDE_LB` | SCAR-H (LB) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `rhs_weap_m84` | M84 | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `rhs_weap_minimi_para_railed` | FN Minimi Para (RIS) | 경기관총 | 3 | 1,200 | $2,400 |
| `rhsgref_weap_svds` | SVDS | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhsgref_weap_savz58v_saboteur` | Sa vz. 58V (RIS) | 기본 전투소총 | 2 | 500 | $1,000 |
| `rhsgref_weap_akm_zenitco` | AKM (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `uk3cb_enfield_no3t_no32_worn` | Enfield No.3 Mk.1(T) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `uk3cb_enfield_no4t_no32` | Enfield No.4 Mk.1(T) (Beech) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `uk3cb_enfield_l42_walnut_no32` | Enfield L42 (Beech) | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `uk3cb_auga1` | Steyr AUGA1 [OD] | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_auga1_tan` | Steyr AUGA1 [Tan] | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_auga1_blk` | Steyr AUGA1 [Black] | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_auga1_carb` | Steyr AUGA1 Carbine [OD] | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_auga1_carb_blk` | Steyr AUGA1 Carbine [Black] | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_auga1_carb_tan` | Steyr AUGA1 Carbine [Tan] | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_auga1_hbar` | Steyr AUGA1 HBAR [OD] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga1_hbar_blk` | Steyr AUGA1 HBAR [Black] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga1_hbar_tan` | Steyr AUGA1 HBAR [Tan] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga1_para` | Steyr AUGA1 9mm [OD] | 기관단총 | 1 | 0 | $800 |
| `uk3cb_auga1_para_blk` | Steyr AUGA1 9mm [Black] | 기관단총 | 1 | 0 | $800 |
| `uk3cb_auga1_para_tan` | Steyr AUGA1 9mm [Tan] | 기관단총 | 1 | 0 | $800 |
| `uk3cb_auga2` | Steyr AUGA2 [OD] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_tan` | Steyr AUGA2 [Tan] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_blk` | Steyr AUGA2 [Black] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_sr` | Steyr AUG-SR [OD] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_sr_tan` | Steyr AUG-SR [Tan] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_sr_blk` | Steyr AUG-SR [Black] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_para` | Steyr AUGA2 9mm [OD] | 기관단총 | 1 | 0 | $800 |
| `uk3cb_auga2_para_tan` | Steyr AUGA2 9mm [Tan] | 기관단총 | 1 | 0 | $800 |
| `uk3cb_auga2_para_blk` | Steyr AUGA2 9mm [Black] | 기관단총 | 1 | 0 | $800 |
| `uk3cb_auga2_carb` | Steyr AUGA2 Carbine [OD] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_carb_tan` | Steyr AUGA2 Carbine [Tan] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_carb_blk` | Steyr AUGA2 Carbine [Black] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_sr_carb` | Steyr AUG-SR Carbine [OD] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_sr_carb_tan` | Steyr AUGA-SR Carbine [Tan] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_sr_carb_blk` | Steyr AUG-SR Carbine [Black] | 표준 돌격소총 | 2 | 500 | $1,500 |
| `uk3cb_auga2_lsw` | Steyr AUGA2 HBAR [OD] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga2_lsw_tan` | Steyr AUGA2 HBAR [Tan] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga2_lsw_blk` | Steyr AUGA2 HBAR [Black] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga2_sr_hbar` | Steyr AUG-SR HBAR [OD] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga2_sr_hbar_tan` | Steyr AUG-SR HBAR [Tan] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga2_sr_hbar_blk` | Steyr AUG-SR HBAR [Black] | 분대지원화기 | 3 | 1,200 | $1,800 |
| `uk3cb_auga3` | Steyr AUGA3 [Green] | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `uk3cb_auga3_blu` | Steyr AUGA3 [Blue] | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `uk3cb_auga3_blk` | Steyr AUGA3 [Black] | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `uk3cb_auga3_gl` | Steyr AUGA3(GL) [Green] | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `uk3cb_auga3_gl_blu` | Steyr AUGA3 GL [Blue] | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `uk3cb_auga3_gl_blk` | Steyr AUGA3 GL [Black] | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `uk3cb_stgw57_RIS` | SIG Stgw.57 (RIS) | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_stgw57_RIS_commando` | SIG Stgw.57 Commando | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_stgw57_5104` | SIG SG510-4 | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_stgw57_amt` | SIG AMT | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_Enfield` | Enfield No.3 Mk.1 | 구형 보병화기 | 1 | 0 | $650 |
| `UK3CB_FNFAL_PARA` | FN FAL 50.61 'Para' | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_FNFAL_PARA_RAILS` | FN FAL 50.61 'Para' (RIS) | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_FNFAL_FULL_RAILS` | FN FAL 50.00 (RIS) | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_FNFAL_FOREGRIP` | FN FAL 50.00 Front Grip | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_C1A1` | CAL C1A1 | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_FNLAR` | FN LAR | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_FNFAL_STG58` | Steyr STG.58 | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_FNFAL_OSW` | DSArms FAL OSW | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_FNFAL_OSW_GL` | DSArms FAL OSW(GL) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `UK3CB_G36A1` | HK G36A1 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_AG36A1` | HK G36A1 (GL) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `UK3CB_G36_LSW` | HK MG36A1 | 분대지원화기 | 3 | 1,200 | $1,800 |
| `UK3CB_G36A1_K` | HK G36A1 Carbine | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_G36A1_C` | HK G36A1 Compact Carbine | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_G36E1` | HK G36E1 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_AG36E1` | HK G36E1 (GL) | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `UK3CB_G36E1_K` | HK G36E1 Carbine | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_G36E1_C` | HK G36E1 Compact Carbine | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_G36_MLIC` | HK G36-MLI | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `UK3CB_G36_MLIC_K` | HK G36-MLI Carbine | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `UK3CB_G36_MLIC_C` | HK G36-MLI Compact Carbine | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `UK3CB_AG36_MLIC` | HK G36MLI(C)(GL) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `UK3CB_G3SG1` | HK G3/SG1 | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_G3A3` | HK G3A3 | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_HK33KA2` | HK33A2 | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_PSG1A1` | HK PSG1A1 | 고급 저격총 | 5 | 3,600 | $3,800 |
| `uk3cb_m16a1` | uk3cb_m16a1 | 기본 전투소총 | 2 | 500 | $1,000 |
| `uk3cb_m16_carbine` | uk3cb_m16_carbine | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_M14_Railed` | M14 [RIS] | 기본 전투소총 | 2 | 500 | $1,000 |
| `UK3CB_M21_Bipod_Railed` | M21 [RIS] | 지정사수총 | 3 | 1,200 | $2,200 |
| `UK3CB_M60` | M60 | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `UK3CB_M79` | M79 Grenade Launcher | 독립 유탄발사기 | 3 | 1,200 | $1,600 |
| `UK3CB_MG3` | MG3 Machine Gun | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `UK3CB_MG3_Railed` | MG M/62 Machine Gun | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `UK3CB_MG3_KWS_T` | MG3-KWS Machine Gun (Tan) | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `UK3CB_MG3_KWS_B` | MG3-KWS Machine Gun (Black) | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `UK3CB_MG3_KWS_G` | MG3-KWS Machine Gun (Green) | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `UK3CB_MP5K_PDW` | HK MP5K-PDW | 기관단총 | 1 | 0 | $800 |
| `UK3CB_FAMAS_F1` | UK3CB_FAMAS_F1 | 표준 돌격소총 | 2 | 500 | $1,500 |
| `UK3CB_FAMAS_F1_GLM203` | UK3CB_FAMAS_F1_GLM203 | 표준 돌격소총 + 유탄발사기 | 3 | 1,200 | $2,150 |
| `UK3CB_MP5K` | HK MP5K | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5A2` | HK MP5A2 | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5N` | HK MP5N | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5N_UGL` | HK MP5N UGL | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5A4` | HK MP5A4 | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP510` | HK MP5/10 | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5SD5` | HK MP5SD5 | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `UK3CB_MP5A3` | HK MP5A3 | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5SD6` | HK MP5SD6 | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `UK3CB_MP5` | HK MP5A2 | 기관단총 | 1 | 0 | $800 |
| `UK3CB_MP5_SD` | HK MP5SD5 | 소음 특수화기 | 4 | 2,200 | $2,400 |
| `UK3CB_P90_TR_black` | FN PS90 TR (Black) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_TR_camo` | FN PS90 TR (Camo) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_TR_khaki` | FN PS90 TR (Khaki) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_TR_hex` | FN PS90 TR (Hex) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_TR_black` | FN P90 TR (Black) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_TR_camo` | FN P90 TR (Camo) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_TR_khaki` | FN P90 TR (Khaki) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_TR_hex` | FN P90 TR (Hex) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_black` | FN PS90 (Black) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_camo` | FN PS90 (Camo) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_khaki` | FN PS90 (Khaki) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90_hex` | FN PS90 (Hex) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_black` | FN P90 (Black) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_camo` | FN P90 (Camo) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_khaki` | FN P90 (Khaki) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_P90C_hex` | FN P90 (Hex) | 현대 PDW | 3 | 1,200 | $1,800 |
| `UK3CB_STGW57` | SIG Stgw.57 | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_galil_SAR` | IMI Galil SAR | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_galil_ARM_308` | IMI Galil ARM 308 | 분대지원화기 | 3 | 1,200 | $1,800 |
| `PRACS_FNC` | FN FNC | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_g3a3` | SMI G3A3-S | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_g3a3_w` | SMI G3A3-S (Wide Handguard) | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_g3a4` | SMI G3A4-S | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_g3a4_w` | SMI G3A4-S (wide Handguard) | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_CETME` | SMI CETME-S | 무료 보급 | 1 | 0 | $0 |
| `PRACS_CETME_BNT` | SMI CETME-S (Parade) | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_g3a3t40` | SMI G3A3-S T-40 UGL | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `PRACS_g3a4t40` | SMI G3A4-S T-40 UGL | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `PRACS_rk62` | Valmet Rk.62 | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_HK53` | SMI HK-53A4s | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_HK33` | SMI HK-33A2s | 무료 보급 | 1 | 0 | $0 |
| `PRACS_HK33_MKS` | SMI HK-33A2s | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_HK33A4` | SMI HK-33A4s | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_UZI` | IMI Uzi 9mm | 기관단총 | 1 | 0 | $800 |
| `PRACS_UZI_Commando` | IMI Uzi 9mm | 기관단총 | 1 | 0 | $800 |
| `PRACS_UZI_FS` | IMI Uzi 9mm | 기관단총 | 1 | 0 | $800 |
| `PRACS_M24` | M24 SWS | 볼트액션 저격총 | 3 | 1,200 | $2,200 |
| `PRACS_M60E4` | M-60E4S | 다목적 기관총 | 4 | 2,200 | $2,800 |
| `PRACS_M60A2` | M-60A2 | 무료 보급 | 1 | 0 | $0 |
| `PRACS_Mk48` | Mk-48 (Railed) LMG | 고급 기관총 | 5 | 3,600 | $3,800 |
| `PRACS_Mk48_STD` | Mk-48 LMG | 고급 기관총 | 5 | 3,600 | $3,800 |
| `PRACS_Mk48_Para` | Mk-48 Para | 고급 기관총 | 5 | 3,600 | $3,800 |
| `PRACS_Mk48_light` | Mk-48 Light | 고급 기관총 | 5 | 3,600 | $3,800 |
| `PRACS_HK416_recon` | HK416 D10 (SOPMOD Stock/Desert) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `PRACS_HK416_m320_recon` | HK416 D10 (M320) | 현대 개량 소총 + 유탄발사기 | 3 | 1,200 | $2,850 |
| `PRACS_Commando_Mk10` | Mk 11 Mod 0 (EC/Desert) | 현대 지정사수총 | 4 | 2,200 | $3,000 |
| `PRACS_M249_Marine` | M249 | 경기관총 | 3 | 1,200 | $2,400 |
| `PRACS_M107` | M107 (Desert) | 대물 저격총 | 7 | 8,000 | $6,000 |
| `PRACS_galil_ACE23` | IMI Galil ACE-23 | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `PRACS_galil_ACE23_SF` | IMI Galil ACE-23k | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `PRACS_SLA_Aks74N` | AKS-74N | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_SLA_Aks74N_gp25` | AKS-74N (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `PRACS_SLA_Ak74` | AK-74 | 기본 전투소총 | 2 | 500 | $1,000 |
| `PRACS_SLA_Ak74_gp25` | AK-74 (GP-25) | 기본 전투소총 + 유탄발사기 | 3 | 1,200 | $1,650 |
| `PRACS_Ak105_esp_1` | AK-105 (Zenitco) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `PRACS_Ak105_esp_2` | AK-105 (Zenitco/B-33) | 현대 개량 소총 | 3 | 1,200 | $2,200 |
| `PRACS_SVDs_Recon` | SVDS | 지정사수총 | 3 | 1,200 | $2,200 |
| `PRACS_SVDs_Recon_2` | SVDM (NPZ) | 지정사수총 | 3 | 1,200 | $2,200 |
| `rhs_weap_pya` | MP-443 | 권총 | 1 | 0 | $400 |
| `rhs_weap_rsp30_white` | ROP-30 | 신호탄 발사기 | 1 | 0 | $100 |
| `rhs_weap_rsp30_red` | RSP-30 (Red) | 신호탄 발사기 | 1 | 0 | $100 |
| `rhs_weap_rsp30_green` | RSP-30 (Green) | 신호탄 발사기 | 1 | 0 | $100 |
| `rhs_weap_tr8` | TR-8 Periscope | 잠망경 | 1 | 0 | $150 |
| `rhs_weap_makarov_pm` | PM | 권총 | 1 | 0 | $400 |
| `rhs_weap_makarov_pmm` | PMM | 권총 | 1 | 0 | $400 |
| `rhs_weap_pb_6p9` | 6P9 | 소음 권총 | 3 | 1,200 | $750 |
| `rhs_weap_6p53` | 6P53 | 권총 | 1 | 0 | $400 |
| `rhs_weap_M320` | M320 GLM | 독립 유탄발사기 | 3 | 1,200 | $1,600 |
| `rhsusf_weap_m1911a1` | M1911A1 | 권총 | 1 | 0 | $400 |
| `rhsusf_weap_glock17g4` | Glock 17 | 권총 | 1 | 0 | $400 |
| `rhsusf_weap_m9` | M9 Beretta | 권총 | 1 | 0 | $400 |
| `rhs_weap_tt33` | TT-33 | 권총 | 1 | 0 | $400 |
| `rhs_weap_type94_new` | Type 94 Nambu | 권총 | 1 | 0 | $400 |
| `rhs_weap_cz99` | CZ99 | 권총 | 1 | 0 | $400 |
| `rhs_weap_cz99_etched` | CZ99 (Engraved) | 권총 | 1 | 0 | $400 |
| `UK3CB_USP` | HK USP Pistol | 권총 | 1 | 0 | $400 |
| `rhs_weap_rpg26` | RPG-26 | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_rpg18` | RPG-18 | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_rshg2` | RShG-2 | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_rpg7` | RPG-7V2 | RPG-7 | 3 | 1,200 | $1,800 |
| `rhs_weap_strela` | 9K32 | 대공 발사기 | 6 | 5,500 | $4,500 |
| `rhs_weap_igla` | 9K38 Igla | 대공 발사기 | 6 | 5,500 | $4,500 |
| `rhs_weap_smaw` | MK153 Mod 0 SMAW (Black) | 재사용 대전차 | 4 | 2,200 | $2,800 |
| `rhs_weap_smaw_green` | MK153 Mod 0 SMAW (Green) | 재사용 대전차 | 4 | 2,200 | $2,800 |
| `rhs_weap_maaws` | M3 MAAWS | 재사용 대전차 | 4 | 2,200 | $2,800 |
| `rhs_weap_M136` | M136 (HEAT) | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_M136_hedp` | M136 (HEDP) | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_M136_hp` | M136 (HP) | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_m72a7` | M72A7 | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_fim92` | FIM-92F | 무료 보급 | 1 | 0 | $0 |
| `rhs_weap_fgm148` | FGM-148 Javelin | 유도 대전차 | 7 | 8,000 | $6,500 |
| `rhs_weap_mk40_sraw` | Mk 40 Mod 0 SRAW | 유도 단발 대전차 | 5 | 3,600 | $3,200 |
| `rhs_weap_mk41_sraw` | Mk 41 Mod 0 SRAW-MPV | 유도 단발 대전차 | 5 | 3,600 | $3,200 |
| `rhs_weap_rpg75` | RPG-75 | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_m80` | RBR-M80 | 단발 대전차 | 2 | 500 | $900 |
| `rhs_weap_panzerfaust60` | Panzerfaust 60 | 단발 대전차 | 2 | 500 | $900 |
| `PRACS_SAAWS` | M3 SAAWS | 무료 보급 | 1 | 0 | $0 |
