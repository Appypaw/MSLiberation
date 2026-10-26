# 부착물·소음기 가격 및 해금

`presets/msl/custom_attachments.sqf`에 클래스별 가격과 레벨을 명시합니다. 현재 custom arsenal의 부착물 계열을 추출하며 의상·장구류가 섞인 섹션 제목에 의존하지 않습니다. 같은 제품의 색상·장착 위치·2D/3D/PiP·전환 상태는 같은 가격입니다. 레이저/라이트 복합 장치는 모드 전환에 관계없이 같은 가격을 적용합니다. PSO의 야간 조명 상태는 실제 야간 투시 조준경과 구분합니다.

기존 엔진의 scope·내부 클래스 필터는 유지합니다. 아래는 설정된 클래스이며 실제 게임에서 표시되는 품목은 모드 설정에 따라 줄어듭니다. 별도 야시경·헬멧 장착형 액세서리는 기존 장비 분류를 유지합니다. 자동 분류보다 이 프리셋을 우선하고 `MSL_priceOverrides`가 최종 예외입니다. 기본 의상 무료 정책은 유지합니다.

미션 재시작 후 적용됩니다. 정적 검증은 게임 내 호환성·실제 기능 검증을 대신하지 않습니다.

| 클래스 | 표시명 참고 | 분류 | 레벨 | 누적 XP | 가격 |
|---|---|---|---:|---:|---:|
| `rhs_silencer_base` | TGP-A | 소총 소음기 | 3 | 1,200 | $800 |
| `rhs_acc_grip_rk6` | rhs_acc_grip_rk6 | 수직 그립 | 2 | 500 | $200 |
| `rhs_acc_grip_rk2` | rhs_acc_grip_rk2 | 수직 그립 | 2 | 500 | $200 |
| `rhs_acc_tgpa` | TGP-A | 소총 소음기 | 3 | 1,200 | $800 |
| `rhs_acc_pbs1` | PBS-1 | 소총 소음기 | 3 | 1,200 | $800 |
| `rhs_acc_tgpv` | TGP-V | 소총 소음기 | 3 | 1,200 | $800 |
| `rhs_acc_tgpv2` | TGP-V2 | 소총 소음기 | 3 | 1,200 | $800 |
| `rhs_acc_dtk4short` | DTK-4 (5.45) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhs_acc_dtk4long` | DTK-4 (7.62) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhs_acc_dtk4screws` | DTK-4 (7.62)М | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhs_acc_pbs4` | PBS-4 | 소총 소음기 | 3 | 1,200 | $800 |
| `rhs_acc_6p9_suppressor` | 6P9 Supressor | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhs_acc_dtk3` | DТК-3 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtk` | DTK | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtkakm` | DTK | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtk1983` | DTK (1983) | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtk1` | DТК-1 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtk1l` | DТК-1L | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtk1p` | DТК-1P | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtk2` | DТК-2 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_uuk` | AK74M UKK | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_dtkrpk` | ShhPG RPK-74 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_ak5` | DPM-AK-5 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_pgs64` | PG S64 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_pgs64_74u` | PG S64 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_pgs64_74un` | PG S64 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhs_acc_1p29_pkp` | 1P29 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p29_asval` | 1P29 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p29_3d` | 1P29 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p29_pkp_3d` | 1P29 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p29_asval_3d` | 1P29 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p78_3d` | 1P78 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pkas_asval` | PK-AS | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_pkas_pkp` | PK-AS | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_okp7_base` | 1P63 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_okp7_dovetail` | OKP7 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_okp7_picatinny` | OKP7 (Picatinny) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_pso1m2` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_ironsight` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_ads` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_ads_night` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_ak` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_ak_ironsight` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_pkp` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_pkp_ironsight` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_asval` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m2_asval_ironsight` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_ironsight` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_ads` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_ads_night` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_ak` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_svd` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_pkp` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_ak_ironsight` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_svd_ironsight` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pso1m21_pkp_ironsight` | PSO-1M2-1 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_nita_3d` | NIT-A | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v2` | PGO-7V2 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v3` | PGO-7V3 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v_ak` | PGO-7V | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v2_ak` | PGO-7V2 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v3_ak` | PGO-7V3 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v_asval` | PGO-7V | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v2_asval` | PGO-7V2 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v3_asval` | PGO-7V3 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v_pkp` | PGO-7V | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v2_pkp` | PGO-7V2 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_pgo7v3_pkp` | PGO-7V2 | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_1pn34` | 1PN34 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhsusf_silencer_base` | TiTan | 소총 소음기 | 3 | 1,200 | $800 |
| `rhsusf_acc_M2010S` | TiTan | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M2010S_d` | TiTan (Desert) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M2010S_sa` | TiTan (Semi-arid) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M2010S_wd` | TiTan (Woodland) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_SR25S` | SR-25 Rifle Suppressor | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_SR25S_wd` | SR-25 Rifle Suppressor (Woodland) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_SR25S_d` | SR-25 Rifle Suppressor (Desert) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_rotex5_grey` | Rotex-5 (Grey) | 소총 소음기 | 3 | 1,200 | $800 |
| `rhsusf_acc_rotex5_tan` | Rotex-5 (Tan) | 소총 소음기 | 3 | 1,200 | $800 |
| `rhsusf_acc_nt4_black` | NT4 QDSS (Black) | 소총 소음기 | 3 | 1,200 | $800 |
| `rhsusf_acc_nt4_tan` | NT4 QDSS (Tan) | 소총 소음기 | 3 | 1,200 | $800 |
| `rhsusf_acc_omega9k` | SILENCERCO OMEGA 9K | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhsusf_acc_rotex_mp7` | Rotex-II (Black) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhsusf_acc_rotex_mp7_aor1` | Rotex-II (AOR1) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhsusf_acc_rotex_mp7_winter` | Rotex-II (Winter) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhsusf_acc_rotex_mp7_desert` | Rotex-II (Desert) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhsusf_m4muzzlebreak_base` | TiTan | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_SF3P556` | SF3P-556-1/2-28 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_SFMB556` | SFMB-556-1/2-28 | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_ARDEC_M240` | ARDEC 4-Prong | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_m14_flashsuppresor` | M14 SOCOM Flash Hider | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_m24_silencer_black` | M24 Supressor | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_m24_silencer_d` | M24 Supressor (Desert) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_m24_silencer_wd` | M24 Supressor (Woodland) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_m24_muzzlehider_black` | M24 15OX. Flash Hider | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_m24_muzzlehider_d` | M24 15OX. Flash Hider (Desert) | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_m24_muzzlehider_wd` | M24 15OX. Flash Hider (Woodland) | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsusf_acc_aac_scarh_silencer` | AAC SCAR-H SD | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_aac_762sd_silencer` | AAC 762-SD | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_aac_762sdn6_silencer` | AAC 762-SDN-6 | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_aac_m14dcqd_silencer` | M14 DCQD | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_aac_m14dcqd_silencer_d` | M14 DCQD (Desert) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_aac_m14dcqd_silencer_wd` | M14 DCQD (Woodland) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_T1_low` | SU-278/PVS LT661 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_T1_low_fwd` | SU-278/PVS LT661 (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_T1_low_fwd_ak` | AimPoint T1 LT661 (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RM05` | RM05 RMR LT726 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RM05_fwd` | RM05 RMR LT726 (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RM05_fwd_ak` | RM05 RMR LT726 (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_mrds` | MRDS | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_mrds_fwd` | MRDS (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_mrds_fwd_ak` | MRDS (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_mrds_c` | MRDS Coyote | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_mrds_fwd_c` | MRDS Coyote (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_mrds_fwd_c_ak` | MRDS Coyote (Forward) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_elcan_3d` | M145 MGO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_elcan_ard_3d` | M145 MGO (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ELCAN_pip` | M145 MGO (PiP) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ELCAN_ard_pip` | M145 MGO (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_su230_base_3d` | SU-230/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_su230_mrds_base` | SU-230/PVS MRDS | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230_mrds_base_3d` | SU-230/PVS MRDS | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230_3d` | SU-230/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_su230_mrds` | SU-230/PVS MRDS | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230_mrds_3d` | SU-230/PVS MRDS | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230a` | SU-230A/PVS | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_su230a_3d` | SU-230A/PVS | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_su230a_mrds` | SU-230A/PVS MRDS | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230a_mrds_3d` | SU-230A/PVS MRDS | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230_c_3d` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_su230_mrds_c` | SU-230/PVS MRDS Coyote | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230_mrds_c_3d` | SU-230/PVS MRDS Coyote | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230a_c` | SU-230A/PVS Coyote | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_su230a_c_3d` | SU-230A/PVS Coyote | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_su230a_mrds_c` | SU-230A/PVS MRDS Coyote | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_su230a_mrds_c_3d` | SU-230A/PVS MRDS Coyote | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_SpecterDR_A` | SU-230A/PVS | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_SpecterDR_3d` | SU-230/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_D_3D` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_OD_3D` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_A_3d` | SU-230A/PVS Coyote | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_SpecterDR_CX_3D` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_pvs27` | SU-230/PVS + AN/PVS-27 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhsusf_acc_ACOG2` | M150 RCO (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG3` | M150 RCO (ARD/Lens Cover) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_USMC` | AN/PVQ-31A RCO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG2_USMC` | AN/PVQ-31A (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG3_USMC` | AN/PVQ-31A (ARD/Lens Cover) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_3d` | M150 RCO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_wd_3d` | TA31RCO (Woodland) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_d_3d` | TA31RCO (Desert) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_sa_3d` | TA31RCO (Semi-Arid) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG2_3d` | M150 RCO (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG3_3d` | M150 RCO (ARD/Lens Cover) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_USMC_3d` | AN/PVQ-31A RCO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG2_USMC_3d` | AN/PVQ-31A (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG3_USMC_3d` | AN/PVQ-31A (ARD/Lens Cover) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_RMR_3d` | TA31RCO-RMR | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_ACOG_pip` | M150 RCO (PiP) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_wd_pip` | TA31RCO (Woodland) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_d_pip` | TA31RCO (Desert) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_sa_pip` | TA31RCO (Semi-Arid) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG2_pip` | M150 RCO (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG3_pip` | M150 RCO (ARD/Lens Cover) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_USMC_pip` | AN/PVQ-31A RCO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG2_USMC_pip` | AN/PVQ-31A (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG3_USMC_pip` | AN/PVQ-31A (ARD/Lens Cover) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_RMR_pip` | TA31RCO-RMR | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_ACOG_anpvs27` | M150 RCO + AN/PVS-27 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhsusf_acc_LEUPOLDMK4_2_mrds` | Mk. 4 M5 (MRDS) | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhsusf_acc_premier_mrds` | M8541A SSDS (MRDS) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M8541_mrds` | M8541 (MRDS) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50_md` | NXS 3.5-15x50 (mil-dot) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50f1_md` | NXS 3.5-15x50 F1 (mil-dot) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50f1_md_sun` | NXS 3.5-15x50 F1 (sunshade/mil-dot) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50f1_h58` | NXS 3.5-15x50 F1 (H58) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50f1_h58_sun` | NXS 3.5-15x50 F1 (sunshade/H58) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_5522x56_md` | NXS 5.5-22x56 (mil-dot) | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhsusf_acc_nxs_5522x56_md_sun` | NXS 5.5-22x56 (sunshade/mil-dot) | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhsusf_acc_M2A1` | M2A1 GL Sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_1` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_2` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_3` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_4` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_5` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_6` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_7` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_8` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_9` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_weap_optic_smaw_10` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhsgref_silencer_base` | 소음기(6.5 mm) | 소총 소음기 | 3 | 1,200 | $800 |
| `rhsgref_sdn6_suppressor` | AAC 762-SDN-6 (cover) | 고급·정밀 소음기 | 4 | 2,200 | $1,100 |
| `rhsgref_acc_zendl` | Zendl compensator | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsgref_acc_falMuzzle_l1a1` | L1A1 SLR Flash Hider | 소염기·제퇴기 | 1 | 0 | $200 |
| `rhsgref_acc_l2a2_3d` | L2A2 SUIT | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsgref_acc_l1a1_l2a2_3d` | L2A2 SUIT | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhssaf_silencer_base` | 소음기(6.5 mm) | 소총 소음기 | 3 | 1,200 | $800 |
| `rhssaf_acc_G36_Rotex` | G36 Rotex adapter | 소염기·제퇴기 | 1 | 0 | $200 |
| `uk3cb_optic_Kern2d` | Kern AARAU 4x24(2D) | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_muzzle_snds_M14` | M14 Suppressor | 소총 소음기 | 3 | 1,200 | $800 |
| `uk3cb_muzzle_snds_g3` | G3 Suppressor | 소총 소음기 | 3 | 1,200 | $800 |
| `uk3cb_muzzle_snds_HK33` | HK33 Suppressor | 소총 소음기 | 3 | 1,200 | $800 |
| `uk3cb_muzzle_snds_mp5` | AWC Agenda Six (9mm) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `uk3cb_muzzle_snds_mp510` | AWC Agenda Six (10mm) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `uk3cb_muzzle_snds_a6aug` | AWC Agenda Six (AUG-Thread) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `uk3cb_muzzle_snds_m42000aug` | M42000 (AUG-Thread) | 소총 소음기 | 3 | 1,200 | $800 |
| `UK3CB_Optic_G36dualoptic35x2d` | G36 Dual-Optic 3.5x(2D) | 고정 배율 조준경 | 2 | 500 | $600 |
| `UK3CB_Optic_G36Export35x2d` | G36 Export Optic 3.5x(2D) | 고정 배율 조준경 | 2 | 500 | $600 |
| `UK3CB_Optic_G36Dualoptic15x2d` | G36 Dual-Optic 1.5x(2D) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `UK3CB_Optic_G36Export15x2d` | G36 Export Optic 1.5x(2D) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `muzzle_snds_L` | 소음기(9mm) | 권총·기관단총 소음기 | 3 | 1,200 | $600 |
| `rhs_acc_harris_swivel` | Harris Bipod | 양각대 | 2 | 500 | $300 |
| `rhs_acc_2dpZenit` | 2DP | 전술 라이트 | 1 | 0 | $150 |
| `rhs_acc_2dpZenit_ris` | 2DP (RIS) | 전술 라이트 | 1 | 0 | $150 |
| `rhs_acc_perst3_2dp_light` | Perst-3/2DP (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhs_acc_perst3_2dp_light_h` | Perst-3/2DP (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_harris_bipod` | Harris Bipod | 양각대 | 2 | 500 | $300 |
| `rhsusf_acc_harris_swivel` | Harris Bipod | 양각대 | 2 | 500 | $300 |
| `rhsusf_acc_saw_bipod` | SAW Bipod | 양각대 | 2 | 500 | $300 |
| `rhsusf_acc_saw_lw_bipod` | SAW Improved Bipod | 양각대 | 2 | 500 | $300 |
| `rhsusf_acc_m14_bipod` | Multipurpose Bipod | 양각대 | 2 | 500 | $300 |
| `rhsusf_acc_rvg_blk` | RVG Grip (Black) | 수직 그립 | 2 | 500 | $200 |
| `rhsusf_acc_rvg_de` | RVG Grip (Dark Earth) | 수직 그립 | 2 | 500 | $200 |
| `rhsusf_acc_tdstubby_blk` | TD Stubby Grip (Black) | 수직 그립 | 2 | 500 | $200 |
| `rhsusf_acc_tdstubby_tan` | TD Stubby Grip (Tan) | 수직 그립 | 2 | 500 | $200 |
| `rhsusf_acc_anpeq15_light` | AN/PEQ-15/M952V (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_light` | AN/PEQ-15/M952V Black (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_light_h` | AN/PEQ-15/M952V (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_light_sc` | AN/PEQ-15/M952V (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_light_h` | AN/PEQ-15/M952V Black (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_light_sc` | AN/PEQ-15/M952V Black (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_wmx_light` | AN/PEQ-15 + WMX (light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_wmx_light_h` | AN/PEQ-15 + WMX (light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_wmx_light_sc` | AN/PEQ-15 + WMX (light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_light` | AN/PEQ-16A (Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_light_top` | AN/PEQ-16A (Top/Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_light_top_h` | AN/PEQ-16A (Top/Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_light_top_sc` | AN/PEQ-16A (Top/Light) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_M952V` | M952V | 전술 라이트 | 1 | 0 | $150 |
| `rhsusf_acc_wmx` | WMX Flashlight | 전술 라이트 | 1 | 0 | $150 |
| `rhsusf_acc_wmx_bk` | WMX Flashlight (Black) | 전술 라이트 | 1 | 0 | $150 |
| `uk3cb_optic_LRT_m14` | Leupold LR/T | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `uk3cb_optic_PVS4_base` | ARCO | 야간 조준경 | 5 | 3,600 | $2,200 |
| `uk3cb_optic_ZF4x_Base` | ARCO | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_LeupoldM3A` | LRPS | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `uk3cb_optic_ZF95_Base` | LRPS | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `uk3cb_optic_ZF95_g3` | Kahles ZF95 (G3) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `uk3cb_optic_LeupoldM3A_G3` | Leupold M3A (G3) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `uk3cb_muzzle_sks_bayonet` | SKS Bayonet Deployed | 기계식 보조 부품 | 1 | 0 | $100 |
| `optic_ACO_grn` | optic_ACO_grn | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_sniper_base` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p29` | 1P29 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_1p78` | 1P78 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhs_acc_pkas` | PK-AS | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_1p63` | 1P63 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp1` | EKP-1S-03 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp1b` | EKP-1S-03 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp1c` | EKP-1S-03 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp1d` | EKP-1S-03 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_02` | EKP-8-02 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_02b` | EKP-8-02 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_02c` | EKP-8-02 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_02d` | EKP-8-02 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_18` | EKP-8-18 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_18b` | EKP-8-18 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_18c` | EKP-8-18 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_ekp8_18d` | EKP-8-18 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_1p87` | 1P87 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_nita` | NIT-A | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_npz` | Rail Adapter | 레일 어댑터 | 1 | 0 | $100 |
| `rhs_acc_pgo7v` | PGO-7V | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_1pn93_base` | 1PN93-1 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhs_acc_1pn93_1` | 1PN93-1 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhs_acc_1pn93_2` | 1PN93-2 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhs_acc_dh520x56` | DH 5-20x56 | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhs_acc_rakursPM` | 1P76 Rakurs-PM | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_sniper_base` | Mk. 4 ER/T 3.5-10x M3 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_compm4` | M68 CCO | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_T1_high` | SU-278/PVS LT660 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RX01` | RX01 Reflex | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RX01_tan` | RX01 Tan Reflex | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RX01_NoFilter` | RX01 (w/o Filter) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_RX01_NoFilter_tan` | RX01 Tan (w/o Filter) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_eotech_552` | M552 CCO | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_eotech_552_d` | M552 CCO (Desert) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_eotech_552_wd` | M552 CCO (Woodland) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_anpvs27` | AN/PVS-27 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhsusf_acc_anpas13gv1` | AN/PAS-13G(V)1 | 열상 조준경 | 7 | 8,000 | $4,500 |
| `rhsusf_acc_LEUPOLDMK4` | Mk. 4 ER/T 3.5-10x M3 | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_LEUPOLDMK4_d` | Mk. 4 M3 (Desert) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_LEUPOLDMK4_wd` | Mk. 4 M3 (Woodland) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_ELCAN` | M145 MGO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ELCAN_ard` | M145 MGO (ARD) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_su230_base` | SU-230/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_su230` | SU-230/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_su230_c` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR` | SU-230/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_D` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_OD` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_SpecterDR_CX` | SU-230/PVS Coyote | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_ACOG` | M150 RCO | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_wd` | TA31RCO (Woodland) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_d` | TA31RCO (Desert) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_sa` | TA31RCO (Semi-Arid) | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsusf_acc_ACOG_RMR` | TA31RCO-RMR | 배율·도트 복합 조준경 | 3 | 1,200 | $900 |
| `rhsusf_acc_LEUPOLDMK4_2` | Mk. 4 ER/T 6.5-20x M5 | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhsusf_acc_LEUPOLDMK4_2_d` | Mk. 4 M5 (Desert) | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhsusf_acc_premier` | M8541A SSDS | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_premier_low` | M8541A (low mount) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_premier_anpvs27` | M8541A + AN/PVS-27 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhsusf_acc_M8541` | M8541 | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M8541_d` | M8541 (Desert) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M8541_wd` | M8541 (Woodland) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M8541_low` | M8541 (low mount) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M8541_low_d` | M8541 (low mount/Desert) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_M8541_low_wd` | M8541 (low mount/Woodland) | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50_base` | NXS 3.5-15x50 | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_3515x50f1_base` | NXS 3.5-15x50 F1 | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `rhsusf_acc_nxs_5522x56_base` | NXS 5.5-22x56 | 초고배율 조준경 | 5 | 3,600 | $1,400 |
| `rhsusf_acc_EOTECH` | EXPS3 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_eotech_xps3` | XPS3 | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsusf_acc_ACOG_MDO` | SU-260/P (MDO) | 중장거리 전투 조준경 | 3 | 1,200 | $850 |
| `rhsusf_acc_g33_xps3` | G33 + XPS3 | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_g33_xps3_flip` | G33 + XPS3 | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_g33_xps3_tan` | G33 + XPS3 (Tan) | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_g33_xps3_tan_flip` | G33 + XPS3 (Tan) | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_g33_T1` | G33 + SU-278/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhsusf_acc_g33_T1_flip` | G33 + SU-278/PVS | 가변·확대경 복합 조준경 | 3 | 1,200 | $750 |
| `rhs_weap_optic_smaw` | SMAW sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_optic_maaws` | M3 MAAWS sight | 유탄·대전차 조준경 | 2 | 500 | $350 |
| `rhs_acc_scope_base` | PSO-1M2 | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsgref_acc_RX01_camo` | RX01 Camo Reflex | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhsgref_acc_RX01_NoFilter_camo` | RX01 Camo (w/o Filter) | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_mtz` | MTZ Rail | 레일 어댑터 | 1 | 0 | $100 |
| `rhsgref_mg42_acc_AAsight` | MG42 AA Sight | 기계식 보조 부품 | 1 | 0 | $100 |
| `rhsgref_acc_l2a2` | L2A2 SUIT | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsgref_acc_l1a1_l2a2` | L2A2 SUIT | 고정 배율 조준경 | 2 | 500 | $600 |
| `rhsgref_acc_anpvs2_base` | AN/PVS-2 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `rhsgref_acc_l1a1_anpvs2` | AN/PVS-2 | 야간 조준경 | 5 | 3,600 | $2,200 |
| `uk3cb_optic_SUIT_FNFAL` | SUIT | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_Kern` | Kern AARAU 4x24 | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_artel_m14` | Redfield AR-TEL | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_PVS4_M14` | AN/PVS4(M14-Mount) | 야간 조준경 | 5 | 3,600 | $2,200 |
| `uk3cb_optic_ZFSG1` | Zeiss Diavari-DA | 정밀 조준경 | 4 | 2,200 | $1,100 |
| `uk3cb_optic_accupoint_g3` | Accupoint TR20 | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_PVS4_G3` | AN/PVS4(G3-Mount) | 야간 조준경 | 5 | 3,600 | $2,200 |
| `uk3cb_optic_STANAGZF2D_G3` | Hensoldt ZF(2D) | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_STANAGZF_G3` | Hensoldt ZF | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_sro` | SRO | 도트·저배율 조준경 | 2 | 500 | $350 |
| `uk3cb_optic_no32` | Scope, No32 | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_no32_vintage` | Scope, No32 (Vintage) | 고정 배율 조준경 | 2 | 500 | $600 |
| `uk3cb_optic_no32_distressed` | Scope, No32 (Worn) | 고정 배율 조준경 | 2 | 500 | $600 |
| `UK3CB_Optic_G36dualoptic35x` | G36 Dual-Optic 3.5x | 고정 배율 조준경 | 2 | 500 | $600 |
| `UK3CB_Optic_G36Export35x` | G36 Export Optic 3.5x | 고정 배율 조준경 | 2 | 500 | $600 |
| `UK3CB_Optic_G36Dualoptic15x` | G36 Dual-Optic 1.5x | 도트·저배율 조준경 | 2 | 500 | $350 |
| `UK3CB_Optic_G36Export15x` | G36 Export Optic 1.5x | 도트·저배율 조준경 | 2 | 500 | $350 |
| `rhs_acc_perst1ik` | Perst-1IK | 레이저 모듈 | 2 | 500 | $300 |
| `rhs_acc_perst1ik_ris` | Perst-1IK (RIS) | 레이저 모듈 | 2 | 500 | $300 |
| `rhs_acc_perst3` | Perst-3 | 레이저 모듈 | 2 | 500 | $300 |
| `rhs_acc_perst3_top` | Perst-3 (Top) | 레이저 모듈 | 2 | 500 | $300 |
| `rhs_acc_perst3_top_h` | Perst-3 (Top) | 레이저 모듈 | 2 | 500 | $300 |
| `rhs_acc_perst3_2dp` | Perst-3/2DP (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhs_acc_perst3_2dp_h` | Perst-3/2DP (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhs_acc_at4_handler` | AT-4 Peep hole handler | 기계식 보조 부품 | 1 | 0 | $100 |
| `rhsusf_acc_anpeq15A` | AN/PEQ-15A | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15` | AN/PEQ-15/M952V (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk` | AN/PEQ-15/M952V Black (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_h` | AN/PEQ-15/M952V (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_sc` | AN/PEQ-15/M952V (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_h` | AN/PEQ-15/M952V Black (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_sc` | AN/PEQ-15/M952V Black (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_wmx` | AN/PEQ-15 + WMX (laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_wmx_h` | AN/PEQ-15 + WMX (laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_wmx_sc` | AN/PEQ-15 + WMX (laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_top` | AN/PEQ-15 (Top) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_top` | AN/PEQ-15 Black (Top) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_top_h` | AN/PEQ-15 (Top) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_top_h` | AN/PEQ-15 Black (Top) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_top_sc` | AN/PEQ-15 (Top) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15_bk_top_sc` | AN/PEQ-15 Black (Top) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15side` | AN/PEQ-15 | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq15side_bk` | AN/PEQ-15 Black | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a` | AN/PEQ-16A (Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_top` | AN/PEQ-16A (Top/Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_top_h` | AN/PEQ-16A (Top/Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsusf_acc_anpeq16a_top_sc` | AN/PEQ-16A (Top/Laser) | 레이저·복합 모듈 | 3 | 1,200 | $450 |
| `rhsgref_K98k_acc_sighthood_add` | K98k Sight Hood | 기계식 보조 부품 | 1 | 0 | $100 |
| `acc_flashlight_pistol` | Pistol Flashlight | 전술 라이트 | 1 | 0 | $150 |
