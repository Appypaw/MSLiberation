/*
    Needed Mods:
    - None

    Optional Mods:
    - None
*/

/* Classnames of the guerilla faction which is friendly or hostile, depending on the civil reputation
Standard loadout of the units will be replaced with a scripted one, which depends on the guerilla strength, after spawn */
KP_liberation_guerilla_units = [
    "UK3CB_CHD_I_TL",
    "UK3CB_CHD_I_ENG",
    "UK3CB_CHD_I_MK",
    "UK3CB_CHD_I_MD",
    "UK3CB_CHD_I_RIF_1",
    "UK3CB_CHD_I_LAT",
    "UK3CB_CHD_I_AR",
    "UK3CB_CHD_I_DEM"
];

// Armed vehicles
KP_liberation_guerilla_vehicles = [
    "UK3CB_CHD_I_Hilux_Pkm",
    "UK3CB_CHD_I_Hilux_Spg9",
    "UK3CB_CHD_I_Hilux_M2",
    "UK3CB_CHD_I_LR_M2",
    "UK3CB_CHD_I_Pickup_GMG"
];

/* Guerilla Equipment
There are 3 tiers for every category. If the strength of the guerillas will increase, they'll have higher tier equipment. */

/* Weapons - You've to add the weapons as array like
["Weaponclassname","Magazineclassname","magazine amount","optic","tripod"]
You can leave optic and tripod empty with "" */
KP_liberation_guerilla_weapons_1 = [
    ["uk3cb_ak47","rhs_30Rnd_762x39mm_bakelite",4,"",""],
    ["rhs_weap_ak74","rhs_30Rnd_545x39_7N6M_AK",4,"",""],
    ["rhs_weap_akm","rhs_30Rnd_762x39mm_bakelite",4,"",""],
    ["rhs_weap_aks74u","30Rnd_45ACP_Mag_SMG_01",4,"",""],
    ["rhs_weap_savz61","rhsgref_20rnd_765x17_vz61",4,"",""],
    ["UK3CB_CZ550","UK3CB_CZ550_5rnd_Mag",4,"",""],
    ["UK3CB_M16A1","rhs_mag_30Rnd_556x45_M855A1_Stanag",4,"",""],
    ["uk3cb_sks_01","uk3cb_10rnd_magazine_sks",4,"",""],
    ["rhs_weap_mg42","rhsgref_50Rnd_792x57_SmE_drum",2,"",""]
];

KP_liberation_guerilla_weapons_2 = [
    ["rhs_weap_ak74n","rhs_30Rnd_545x39_7N6M_AK",4,"rhs_acc_ekp8_02",""],
    ["rhs_weap_ak74n_gp25","rhs_30Rnd_545x39_7N6M_AK",4,"rhs_acc_ekp8_02",""],
    ["rhs_weap_m16a4","rhs_mag_30Rnd_556x45_M855A1_Stanag",4,"rhsusf_acc_eotech_xps3",""],
    ["UK3CB_M21","UK3CB_M14_20rnd_762x51",4,"uk3cb_optic_artel_m14",""],
    ["UK3CB_M60","UK3CB_M60_100rnd_762x51",3,"",""],
    ["rhs_weap_pkm","rhs_100Rnd_762x54mmR",5,"",""]
];

KP_liberation_guerilla_weapons_3 = [
    ["rhs_weap_svds","rhs_10Rnd_762x54mmR_7N1",4,"rhs_acc_pso1m2",""],
    ["rhs_weap_vss_grip_npz","rhs_10rnd_9x39mm_SP5",4,"Tier1_EXPS3_0_G33_Riser_Black_Up","rhs_acc_grip_rk2"],
    ["rhs_weap_m4a1_blockII_bk","rhs_mag_30Rnd_556x45_M855A1_Stanag",5,"rhsusf_acc_compm4","Tier1_DD_VFG_Black"],
    ["rhs_weap_mk17_LB","rhs_mag_20Rnd_SCAR_762x51_m80_ball",4,"rhsusf_acc_ACOG","Tier1_KAC_VFG_DE"],
    ["rhs_weap_ak74mr","rhs_30Rnd_545x39_7N10_AK",5,"rhs_acc_1p87","rhs_acc_grip_rk6"],
    ["UK3CB_G36V","UK3CB_G36_30rnd_556x45",5,"Tier1_Elcan_156_C1_Black","rhsusf_acc_harris_bipod"],
    ["rhs_weap_m24sws","rhsusf_5Rnd_762x51_m118_special_Mag",5,"rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_harris_swivel"]
];

// Uniforms
KP_liberation_guerilla_uniforms_1 = [
    "UK3CB_ION_B_U_SF_Uniform_Jeans_Tshirt_04_DES",
    "UK3CB_ION_B_U_SF_Uniform_Jeans_Tshirt_10_WDL",
    "UK3CB_ION_B_U_SF_Uniform_Jeans_Tshirt_03_DES",
    "UK3CB_ION_B_U_SF_Uniform_Jeans_Tshirt_06_WDL",
    "UK3CB_MEI_B_U_Jeans_Tshirt_02",
    "UK3CB_CW_US_B_Early_U_SF_CombatUniform_03_ERDL_OLI",
    "UK3CB_CHC_C_U_WOOD_04",
    "UK3CB_CHC_C_U_WOOD_01",
    "UK3CB_CHC_C_U_WOOD_02",
    "UK3CB_CHC_C_U_Pilot_01",
    "UK3CB_ADC_C_Hunter_U_07",
    "UK3CB_ADC_C_Hunter_U_09",
    "UK3CB_NAP_B_U_Pilot_FLK"
];

KP_liberation_guerilla_uniforms_2 = [
    "UK3CB_CHD_B_U_H_Pilot_Uniform_03",
    "UK3CB_ADM_B_U_CombatUniform_01_MAR_DES_DDPM",
    "UK3CB_CHD_B_U_CombatUniform_08",
    "UK3CB_ADE_O_U_04",
    "UK3CB_ADE_O_U_04_B",
    "UK3CB_ADE_O_U_04_C",
    "UK3CB_ADE_O_U_04_D",
    "UK3CB_MEI_B_U_CombatUniform_WDL_02_JEANS_WHITE",
    "UK3CB_B_U_CombatUniform_Shortsleeve_02_WDL",
    "UK3CB_CHD_B_U_CombatSmock_05"
];

KP_liberation_guerilla_uniforms_3 = [
    "USP_TSHIRT2_G3C_MX_BLK_RGR",
    "USP_TSHIRT2_G3C_MX_BLK_MCB",
    "USP_TSHIRT_G3C_KP_OR_NAV_GRY",
    "USP_SOFTSHELL_G3C_KP_MX_BLK_KHK",
    "USP_PCU_G3C",
    "USP_RUGBY_G3C_KP_MX_RGR_MCB",
    "USP_G3C_CU_MX",
    "UK3CB_APD_B_U_66sh122_CombatSmock_Gloves_04_EKAM",
    "UK3CB_LSM_B_U_CombatSmock_31"
];

// Vests
KP_liberation_guerilla_vests_1 = [
    "UK3CB_TKP_I_V_6Sh92_Tan",
    "rhs_6sh92_vsr",
    "rhs_6sh92_vsr_vog_headset",
    "UK3CB_TKA_I_V_6Sh92_Radio_Des",
    "PRACS_aircrew_vest",
    "rhs_belt_sks",
    "rhs_belt_holster",
    "rhsgref_chestrig",
    "rhsgref_chicom",
    "UK3CB_V_Pouch",
    "UK3CB_MD99_VEST_Net_KHK"
];

KP_liberation_guerilla_vests_2 = [
    "PRACS_RFP_CIRAS",
    "PRACS_QSB_CIRAS_Officer",
    "rhs_6sh92_digi",
    "rhs_6b5_rifleman",
    "UK3CB_ARD_B_V_6b5_Rifleman_Desert",
    "rhs_6b5_medic_khaki",
    "rhsgref_6b23_ttsko_mountain_nco",
    "rhsgref_6b23_ttsko_mountain_sniper",
    "UK3CB_V_MBAV_GRENADIER_BLK"
];

KP_liberation_guerilla_vests_3 = [
    "UK3CB_V_MBAV_LIGHT_BLK",
    "UK3CB_APD_B_MBAV_MEDIC_BLK",
    "rhsusf_plateframe_grenadier",
    "rhsusf_spcs_ocp_grenadier",
    "rhsusf_spcs_ucp_machinegunner",
    "UK3CB_ION_B_V_MD_BLK_02",
    "rhs_6sh117_nco_azart",
    "UK3CB_LDF_B_V_CREW_Vest_KKZ10_GEO",
    "UK3CB_LDF_B_V_MG_Vest_KKZ10_GEO"
];

// Headgear
KP_liberation_guerilla_headgear_1 = [
    "",
    "",
    "",
    "",
    "USP_BASEBALL_CAP_M81",
    "USP_BASEBALL_CAP_RT6_BD",
    "UK3CB_NFA_B_H_M88_Field_Cap_ALP",
    "rhs_gssh18"
];

KP_liberation_guerilla_headgear_2 = [
    "rhsgref_fieldcap_ttsko_digi",
    "rhsgref_fieldcap_ttsko_forest",
    "rhsgref_fieldcap_ttsko_mountain",
    "rhsusf_protech_helmet"
];

KP_liberation_guerilla_headgear_3 = [
    "rhsgref_M56",
    "H_Watchcap_blk",
    "rhs_ssh68",
    "rhsgref_ssh68_emr",
    "rhs_tsh4"
];

// Facegear. Applies for tier 2 and 3.
KP_liberation_guerilla_facegear = [
    "",
    "",
    "",
    "UK3CB_G_Bandanna_sport_brown_check",
    "UK3CB_G_Face_Wrap_01",
    "UK3CB_G_Bandanna_aviator_brown_check",
    "USP_SHEMAGH",
    "USP_FORETREX",
    "USP_GATORZ_SMB2_BLK",
    "USP_BALACLAVA_ESS_SMC1_M81"
];
