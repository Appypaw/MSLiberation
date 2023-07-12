/*
    Needed Mods:
    - None

    Optional Mods:
*/

/*
    --- Support classnames ---
    Each of these should be unique.
    The same classnames for different purposes may cause various unpredictable issues with player actions.
    Or not, just don't try!
*/
FOB_typename = "Land_Cargo_HQ_V1_F";                                    // This is the main FOB HQ building.
FOB_box_typename = "B_Slingload_01_Cargo_F";                            // This is the FOB as a container.
FOB_truck_typename = "rhsusf_M1078A1P2_B_WD_CP_fmtv_usarmy";            // This is the FOB as a vehicle.
Arsenal_typename = "B_supplyCrate_F";                                   // This is the virtual arsenal as portable supply crates.
Respawn_truck_typename = "PRACS_M250_AMB";   // This is the mobile respawn (and medical) truck.
huron_typename = "RHS_CH_47F";                                          // This is Spartan 01, a multipurpose mobile respawn as a helicopter.
crewman_classname = "PRACS_QSB_Crew";                    // This defines the crew for vehicles.
pilot_classname = "PRACS_Heli_pilot";                          // This defines the pilot for helicopters.
KP_liberation_little_bird_classname = "RHS_MELB_MH6M";                  // These are the little birds which spawn on the Freedom or at Chimera base.
KP_liberation_boat_classname = "B_Boat_Transport_01_F";                 // These are the boats which spawn at the stern of the Freedom.
KP_liberation_truck_classname = "rhsusf_M977A4_BKIT_usarmy_wd";         // These are the trucks which are used in the logistic convoy system.
KP_liberation_small_storage_building = "ContainmentArea_02_sand_F";     // A small storage area for resources.
KP_liberation_large_storage_building = "ContainmentArea_01_sand_F";     // A large storage area for resources.
KP_liberation_recycle_building = "Land_RepairDepot_01_tan_F";           // The building defined to unlock FOB recycling functionality.
KP_liberation_air_vehicle_building = "Land_Mil_ControlTower";             // The building defined to unlock FOB air vehicle functionality.
KP_liberation_heli_slot_building = "Land_HelipadSquare_F";              // The helipad used to increase the GLOBAL rotary-wing cap.
KP_liberation_plane_slot_building = "Land_TentHangar_V1_F";             // The hangar used to increase the GLOBAL fixed-wing cap.
KP_liberation_supply_crate = "CargoNet_01_box_F";                       // This defines the supply crates, as in resources.
KP_liberation_ammo_crate = "B_CargoNet_01_ammo_F";                      // This defines the ammunition crates.
KP_liberation_fuel_crate = "CargoNet_01_barrels_F";                     // This defines the fuel crates.

/*
    --- Friendly classnames ---
    Each array below represents one of the 7 pages within the build menu.
    Format: ["vehicle_classname",supplies,ammunition,fuel],
    Example: ["B_APC_Tracked_01_AA_F",300,150,150],
    The above example is the NATO IFV-6a Cheetah, it costs 300 supplies, 150 ammunition and 150 fuel to build.
    IMPORTANT: The last element inside each array must have no comma at the end!
*/
infantry_units = [
    ["rhsusf_airforce_jetpilot",1000,0,0]                                 // Pilot
];

light_vehicles = [
    ["B_Quadbike_01_F",30,0,15],                                        // Quad Bike
    ["UK3CB_B_M1030_NATO",30,0,15],                                     // Motor
    ["UK3CB_C_Octavia",50,0,25],                                        // Civ Car
    ["UK3CB_C_Lada",50,0,25],                                        // Civ Car
    ["UK3CB_C_Hilux_Open",50,0,25],                                        // Civ Car
    ["UK3CB_C_Hatchback",50,0,25],                                        // Civ Car
    ["UK3CB_C_Sedan",50,0,25],                                        // Civ Car
    ["UK3CB_C_Skoda",50,0,25],                                        // Civ Car
    ["UK3CB_C_S1203",50,0,25],                                        // Civ Car
    ["UK3CB_C_Gaz24",50,0,25],                                        // Civ Car
    ["UK3CB_C_Golf",50,0,25],                                        // Civ Car
    ["rhsusf_mrzr4_d",50,0,25],
    ["PRACS_SUV",75,0,35],
    ["UK3CB_I_LandRover_Closed_CDF",75,0,35],
    ["rhsgref_cdf_reg_uaz_open",75,0,35],
    ["UK3CB_TKM_I_Hilux_Zu23_Front",75,150,35],
    ["UK3CB_TKM_I_Hilux_Rocket",75,200,35],
    ["UK3CB_TKM_I_Hilux_Mortar",75,175,35],
    ["UK3CB_ION_I_Woodland_LSV_01",75,0,35],                        // PMC Car
    ["UK3CB_ION_I_Woodland_Pickup",75,0,35],                        // PMC Car
    ["UK3CB_ION_I_Woodland_LSV_02",75,0,35],                        // PMC Car
    ["UK3CB_ION_I_Woodland_Landcruiser",75,0,35],                        // PMC Car
    ["UK3CB_ION_I_Woodland_MB4WD_Unarmed",75,0,35],                        // PMC Car
    ["UK3CB_ION_I_Woodland_Pickup_M2",75,40,35],                     // PMC Armored Car
    ["UK3CB_ION_I_Woodland_Hilux_M2",75,40,35],                     // PMC Armored Car
    ["UK3CB_ION_I_Woodland_SUV_Armed",75,100,35],                     // PMC Armored Car
    ["UK3CB_TKA_I_LR_SF_M2",100,100,50],
    ["UK3CB_TKA_I_LR_SF_AGS30",100,100,50],
    ["PRACS_M1025",100,0,50],                                        // M1025A2
    ["PRACS_M1025_M2",100,40,50],                                    // M1025A2 (M2)
    ["PRACS_M1025_Mk19",100,60,50],                                  // M1025A2 (Mk19)
    ["PRACS_M966_TOW",100,100,50],                                   // M966 TOW
    ["PRACS_M1165_M134_QSB",120,120,50],
    ["PRACS_M1165_Mk19",120,120,50],
    ["PRACS_M998_cargo_topped",100,0,50],                             // M1097A2 (2D)
    ["PRACS_M998_cargo_open",100,0,50],                             // M1097A2 (2D / open back)
    ["rhsusf_M1232_usarmy_wd",150,0,60],                                // M1232
    ["rhsusf_M1232_M2_usarmy_wd",150,40,60],                            // M1232 (M2)
    ["rhsusf_M1232_MK19_usarmy_wd",150,60,60],                          // M1232 (Mk19)
    ["rhsusf_M1230a1_usarmy_wd",150,0,60],                              // M1230A1 (MEDEVAC)
    ["rhsusf_M1237_M2_usarmy_wd",170,40,60],
    ["rhsusf_M1237_MK19_usarmy_wd",170,60,60],
    ["rhsusf_m1240a1_m2_uik_usarmy_wd",150,40,60],
    ["rhsusf_m1240a1_mk19_uik_usarmy_wd",150,60,60],
    ["rhsusf_m1240a1_m2crows_usarmy_wd",160,40,60],
    ["rhsusf_m1240a1_mk19crows_usarmy_wd",160,60,60],
    ["UK3CB_B_MaxxPro_M2_US_W",150,40,60],
    ["UK3CB_B_MaxxPro_MK19_US_W",150,60,60],
    ["rhsusf_CGRCAT1A2_usmc_wd",140,0,60],
    ["rhsusf_CGRCAT1A2_M2_usmc_wd",160,40,60],
    ["rhsusf_CGRCAT1A2_Mk19_usmc_wd",160,60,60],
    ["rhsusf_M1083A1P2_wd_open_fmtv_usarmy",200,0,75],                  // M1083A1P2 Transport
    ["rhsusf_M1083A1P2_wd_fmtv_usarmy",205,0,75],                       // M1083A1P2 Transport (Covered)
    ["rhsusf_M1083A1P2_WD_flatbed_fmtv_usarmy",150,0,50],               // M1083A1P2
    ["rhsusf_M977A4_BKIT_usarmy_wd",200,0,75],                          // M977A4 BKIT
    ["B_Boat_Transport_01_F",100,0,25],                                 // Assault Boat
    ["B_Boat_Armed_01_minigun_F",200,80,75],                            // Speedboat Minigun
    ["rhsusf_mkvsoc",250,200,100],                                      // Mk.V SOCOM
    ["B_SDV_01_F",150,0,50]                                             // SDV
];

heavy_vehicles = [
    ["rhsgref_cdf_btr60",200,40,100],
    ["PRACS_M113_M2",200,40,100],                                  // M113A3 (M2)
    ["PRACS_M113_mk19",200,60,100],                             // M113A3 (Mk19)
    ["PRACS_M163_VADS",200,150,100],
    ["PRACS_M163_MACHBET",250,200,100],
    ["PRACS_M548_MPQ64",150,0,100],
    ["PRACS_M727_IHAWK",200,150,100],
    ["PRACS_m48_chapparal",200,150,100],
    ["PRACS_M1117",200,100,100],                                        // M1117
    ["rhsusf_stryker_m1126_m2_wd",250,50,150],
    ["rhsusf_stryker_m1126_mk19_wd",250,60,150],
    ["rhsusf_stryker_m1132_m2_wd",300,50,150],
    ["rhsusf_stryker_m1134_wd",275,50,150],
    ["PRACS_BMR_A3_GA1",250,150,150],
    ["PRACS_BMR_A3_M3_SFOD",275,150,150],
    ["PRACS_BMR_ATGM",300,200,150],
    ["PRACS_VEC_M242",220,100,120],
    ["PRACS_VEC_MGS",250,200,120],
    ["PRACS_Pizarro",350,175,150],
    ["PRACS_FV107",350,200,200],
    ["PRACS_FV101",350,200,200],
    ["UK3CB_I_T34_CDF",250,250,250],
    ["UK3CB_I_T55_CDF",350,250,250],
    ["rhsgref_cdf_t72bb_tv",500,250,250],
    ["rhsgref_cdf_t80b_tv",650,250,250],
    ["PRACS_M60S",400,250,250],
    ["PRACS_M60A3",450,250,250],
    ["UK3CB_KRG_I_FV4201",500,250,250],
    ["PRACS_M1A1_AIM",600,250,250],
    ["RHS_M2A2_BUSKI_WD",600,200,150],                                  // M2A2ODS (Busk I)
    ["RHS_M2A3_BUSKIII_wd",600,250,175],                                // M2A3 (Busk III)
    ["RHS_M6_wd",600,250,175],                                          // M6A2
    ["rhsusf_m1a1aim_tuski_wd",800,350,250],                            // M1A1SA (Tusk I)
    ["rhsusf_m1a2sep1tuskiiwd_usarmy",1000,400,250],                     // M1A2SEPv1 (Tusk II)
    ["PRACS_M109A6",1200,2000,300],                                 // M109A6
    ["rhsgref_cdf_reg_BM21",600,1200,250],
    ["UK3CB_KRG_I_M270_Avenger",300,500,250],
    ["UK3CB_KRG_I_M939_MLRS",650,1200,250],
    ["UK3CB_KRG_I_MTVR_MLRS",500,1200,250],
    ["rhsusf_M142_usarmy_WD",1750,2400,250],
    ["PRACS_M430",1500,2300,250],
    ["PRACS_M270",2000,2500,500]
];

air_vehicles = [
    ["RHS_MELB_MH6M",200,0,100],                                        // MH-6M Little Bird
    ["PRACS_RAH6",200,200,100],                                      // AH-6M Pawnee
    ["UK3CB_ION_I_Woodland_MELB_AH6M_M",200,200,100],
    ["PRACS_UH1H",225,0,125],                                     // UH-1Y (Unarmed)
    ["PRACS_Sa330_Puma",250,0,125],
    ["PRACS_UH1H_CAS",225,200,125],                                        // UH-1Y (Ground Suppression)
    ["UK3CB_ION_I_Woodland_Cessna_T41_Armed_M134",150,100,50],
    ["PRACS_Sa330_Puma_SOCAT",400,200,200],
    ["UK3CB_ION_I_Woodland_Orca_Armed_MULTI",400,200,200],
    ["PRACS_CH53",300,50,200],
    ["PRACS_AH1S",500,400,200],
    ["RHS_AH1Z",750,500,200],                                           // AH-1Z (Multi-Role)
    ["RHS_AH64D_wd",1000,750,250],                                       // AH-64D (Multi-Role)
    ["RHS_UH60M2",250,0,150],                                           // UH-60M (Unarmed)
    ["RHS_UH60M",250,80,150],                                           // UH-60M
    ["RHS_UH60M_MEV2",300,0,150],                                       // UH-60M MEV2
    ["RHS_CH_47F_10",275,80,175],                                       // CH-47 Chinook (Armed)
    ["PRACS_C130",200,0,250],                                     // C-130J Super Hercules (Cargo)
    ["PRACS_E2C",250,0,250],
    ["rhs_l159_CDF",300,500,300],
    ["PRACS_Mohawk",350,750,250],
    ["PRACS_P3C",300,500,200],
    ["PRACS_MirageIII",800,500,350],
    ["PRACS_MirageV",850,500,350],
    ["PRACS_F16",1000,600,400],
    ["PRACS_F16CJ",1000,700,400],
    ["PRACS_F16CJR",1000,700,400],
    ["PRACS_A4M",700,800,350],
    ["RHS_A10",1000,1000,400],                                          // A-10A (CAS)
    ["rhsusf_f22",1800,2000,500]
];

static_vehicles = [
    ["UK3CB_TKM_I_Searchlight",5,0,0],
    ["PRACS_M102",100,200,0],
    ["RHS_M119_WD",100,200,0],                                          // M119A2
    ["PRACS_M1",120,300,0],
    ["PRACS_M114",100,300,0],
    ["PRACS_M115",150,400,0],
    ["PRACS_M198",150,350,0],
    ["PRACS_MPQ64_Sentinel",50,0,0],
    ["PRACS_MiM23_HAWK",100,250,0],
    ["B_SAM_System_03_F",250,500,0]                                     // MIM-145 Defender
];

buildings = [
    ["Land_TargetPopup_ACR",0,0,0],
    ["TargetStatic_ACR",0,0,0],
    ["Land_Cargo_House_V1_F",0,0,0],
    ["Land_Cargo_Patrol_V1_F",0,0,0],
    ["Land_Cargo_Tower_V1_F",0,0,0],
    ["Flag_NATO_F",0,0,0],
    ["Flag_US_F",0,0,0],
    ["BWA3_Flag_Ger_F",0,0,0],
    ["Flag_UK_F",0,0,0],
    ["Flag_White_F",0,0,0],
    ["Land_Medevac_house_V1_F",0,0,0],
    ["Land_Medevac_HQ_V1_F",0,0,0],
    ["Flag_RedCrystal_F",0,0,0],
    ["CamoNet_BLUFOR_F",0,0,0],
    ["CamoNet_BLUFOR_open_F",0,0,0],
    ["CamoNet_BLUFOR_big_F",0,0,0],
    ["Land_PortableLight_single_F",0,0,0],
    ["Land_PortableLight_double_F",0,0,0],
    ["Land_LampSolar_F",0,0,0],
    ["Land_LampHalogen_F",0,0,0],
    ["Land_LampStreet_small_F",0,0,0],
    ["Land_LampAirport_F",0,0,0],
    ["Land_HelipadCircle_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["Land_HelipadRescue_F",0,0,0],                                     // Strictly aesthetic - as in it does not increase helicopter cap!
    ["PortableHelipadLight_01_blue_F",0,0,0],
    ["PortableHelipadLight_01_green_F",0,0,0],
    ["PortableHelipadLight_01_red_F",0,0,0],
    ["Land_CampingChair_V1_F",0,0,0],
    ["Land_CampingChair_V2_F",0,0,0],
    ["Land_CampingTable_F",0,0,0],
    ["MapBoard_altis_F",0,0,0],
    ["MapBoard_stratis_F",0,0,0],
    ["MapBoard_seismic_F",0,0,0],
    ["Land_Pallet_MilBoxes_F",0,0,0],
    ["Land_PaperBox_open_empty_F",0,0,0],
    ["Land_PaperBox_open_full_F",0,0,0],
    ["Land_PaperBox_closed_F",0,0,0],
    ["Land_DieselGroundPowerUnit_01_F",0,0,0],
    ["Land_ToolTrolley_02_F",0,0,0],
    ["Land_WeldingTrolley_01_F",0,0,0],
    ["Land_Workbench_01_F",0,0,0],
    ["Land_GasTank_01_blue_F",0,0,0],
    ["Land_GasTank_01_khaki_F",0,0,0],
    ["Land_GasTank_01_yellow_F",0,0,0],
    ["Land_GasTank_02_F",0,0,0],
    ["Land_BarrelWater_F",0,0,0],
    ["Land_BarrelWater_grey_F",0,0,0],
    ["Land_WaterBarrel_F",0,0,0],
    ["Land_WaterTank_F",0,0,0],
    ["Land_BagFence_Round_F",0,0,0],
    ["Land_BagFence_Short_F",0,0,0],
    ["Land_BagFence_Long_F",0,0,0],
    ["Land_BagFence_Corner_F",0,0,0],
    ["Land_BagFence_End_F",0,0,0],
    ["Land_BagBunker_Small_F",0,0,0],
    ["Land_BagBunker_Large_F",0,0,0],
    ["Land_BagBunker_Tower_F",0,0,0],
    ["Land_HBarrier_1_F",0,0,0],
    ["Land_HBarrier_3_F",0,0,0],
    ["Land_HBarrier_5_F",0,0,0],
    ["Land_HBarrier_Big_F",0,0,0],
    ["Land_HBarrierWall4_F",0,0,0],
    ["Land_HBarrierWall6_F",0,0,0],
    ["Land_HBarrierWall_corner_F",0,0,0],
    ["Land_HBarrierWall_corridor_F",0,0,0],
    ["Land_HBarrierTower_F",0,0,0],
    ["Land_CncBarrierMedium_F",0,0,0],
    ["Land_CncBarrierMedium4_F",0,0,0],
    ["Land_Concrete_SmallWall_4m_F",0,0,0],
    ["Land_Concrete_SmallWall_8m_F",0,0,0],
    ["Land_CncShelter_F",0,0,0],
    ["Land_CncWall1_F",0,0,0],
    ["Land_CncWall4_F",0,0,0],
    ["Land_Sign_WarningMilitaryArea_F",0,0,0],
    ["Land_Sign_WarningMilAreaSmall_F",0,0,0],
    ["Land_Sign_WarningMilitaryVehicles_F",0,0,0],
    ["Land_Razorwire_F",0,0,0],
    ["Land_Barrack2",0,0,0],
    ["PRACS_sing_flag",0,0,0],
    ["Land_ClutterCutter_large_F",0,0,0]
];

support_vehicles = [
    [Arsenal_typename,100,200,0],
    [Respawn_truck_typename,200,0,100],
    [FOB_box_typename,300,500,0],
    [FOB_truck_typename,300,500,75],
    [KP_liberation_small_storage_building,0,0,0],
    [KP_liberation_large_storage_building,0,0,0],
    [KP_liberation_recycle_building,200,0,0],
    [KP_liberation_air_vehicle_building,1000,0,0],
    [KP_liberation_heli_slot_building,100,0,0],
    [KP_liberation_plane_slot_building,200,0,0],
    ["ACE_medicalSupplyCrate_advanced",50,0,0],
    ["ACE_Box_82mm_Mo_HE",50,40,0],
    ["ACE_Box_82mm_Mo_Smoke",50,10,0],
    ["ACE_Box_82mm_Mo_Illum",50,10,0],
    ["ACE_Wheel",10,0,0],
    ["ACE_Track",10,0,0],
    ["USAF_missileCart_W_AGM114",50,150,0],                             // Missile Cart (AGM-114)
    ["USAF_missileCart_AGMMix",50,150,0],                               // Missile Cart (AGM-65 Mix)
    ["USAF_missileCart_AGM1",50,150,0],                                 // Missile Cart (AGM-65D)
    ["USAF_missileCart_AGM2",50,150,0],                                 // Missile Cart (AGM-65E)
    ["USAF_missileCart_AGM3",50,150,0],                                 // Missile Cart (AGM-65K)
    ["USAF_missileCart_AA1",50,150,0],                                  // Missile Cart (AIM-9M/AIM-120)
    ["USAF_missileCart_AA2",50,150,0],                                  // Missile Cart (AIM-9X/AIM-120)
    ["USAF_missileCart_GBU12_green",50,150,0],                          // Missile Cart (GBU12 Green)
    ["USAF_missileCart_GBU12_maritime",50,150,0],                       // Missile Cart (GBU12 Maritime)
    ["USAF_missileCart_GBU12",50,150,0],                                // Missile Cart (GBU12)
    ["USAF_missileCart_Gbu31",50,150,0],                                // Missile Cart (GBU31)
    ["USAF_missileCart_GBU39",50,150,0],                                // Missile Cart (GBU39)
    ["USAF_missileCart_Mk82",50,150,0],                                 // Missile Cart (Mk82)
    ["B_APC_Tracked_01_CRV_F",500,250,350],                             // CRV-6e Bobcat
    ["PRACS_m548_arty_tender",125,200,75],
    ["PRACS_m548_ammo",125,300,75],
    ["PRACS_M250_Ammo",125,300,75],
    ["rhsusf_M977A4_REPAIR_BKIT_usarmy_wd",325,0,75],                   // M977A4 Repair
    ["rhsusf_M978A4_BKIT_usarmy_wd",125,0,275],                         // M978A4 Fuel
    ["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",125,200,75],                   // M977A4 Ammo
    ["B_Slingload_01_Repair_F",275,0,0],                                // Huron Repair
    ["B_Slingload_01_Fuel_F",75,0,200],                                 // Huron Fuel
    ["B_Slingload_01_Ammo_F",75,200,0]                                  // Huron Ammo
];

/*
    --- Squads ---
    Pre-made squads for the commander build menu.
    These shouldn't exceed 10 members.
*/

// Light infantry squad.
blufor_squad_inf_light = [
    "rhsusf_army_ocp_teamleader",
    "rhsusf_army_ocp_rifleman",
    "rhsusf_army_ocp_rifleman",
    "rhsusf_army_ocp_riflemanat",
    "rhsusf_army_ocp_grenadier",
    "rhsusf_army_ocp_autorifleman",
    "rhsusf_army_ocp_autorifleman",
    "rhsusf_army_ocp_marksman",
    "rhsusf_army_ocp_medic",
    "rhsusf_army_ocp_engineer"
];

// Heavy infantry squad.
blufor_squad_inf = [
    "rhsusf_army_ocp_teamleader",
    "rhsusf_army_ocp_riflemanat",
    "rhsusf_army_ocp_riflemanat",
    "rhsusf_army_ocp_grenadier",
    "rhsusf_army_ocp_autorifleman",
    "rhsusf_army_ocp_autorifleman",
    "rhsusf_army_ocp_machinegunner",
    "rhsusf_army_ocp_marksman",
    "rhsusf_army_ocp_medic",
    "rhsusf_army_ocp_engineer"
];

// AT specialists squad.
blufor_squad_at = [
    "rhsusf_army_ocp_teamleader",
    "rhsusf_army_ocp_rifleman",
    "rhsusf_army_ocp_rifleman",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_javelin",
    "rhsusf_army_ocp_medic",
    "rhsusf_army_ocp_rifleman"
];

// AA specialists squad.
blufor_squad_aa = [
    "rhsusf_army_ocp_teamleader",
    "rhsusf_army_ocp_rifleman",
    "rhsusf_army_ocp_rifleman",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_aa",
    "rhsusf_army_ocp_medic",
    "rhsusf_army_ocp_rifleman"
];

// Force recon squad.
blufor_squad_recon = [
    "rhsusf_usmc_recon_marpat_wd_teamleader",
    "rhsusf_usmc_recon_marpat_wd_rifleman",
    "rhsusf_usmc_recon_marpat_wd_rifleman",
    "rhsusf_usmc_recon_marpat_wd_rifleman_at",
    "rhsusf_usmc_recon_marpat_wd_autorifleman",
    "rhsusf_usmc_recon_marpat_wd_machinegunner",
    "rhsusf_usmc_recon_marpat_wd_marksman",
    "rhsusf_usmc_recon_marpat_wd_sniper_M107",
    "rhsusf_army_ucp_medic",
    "rhsusf_army_ucp_engineer"
];

// Paratroopers squad (The units of this squad will automatically get parachutes on build)
blufor_squad_para = [
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st",
    "rhsusf_army_ocp_rifleman_101st"
];

/*
    --- Elite vehicles ---
    Classnames below have to be unlocked by capturing military bases.
    Which base locks a vehicle is randomized on the first start of the campaign.
*/
elite_vehicles = [
    "rhsusf_m1a1aim_tuski_wd",                                          // M1A1SA (Tusk I)
    "rhsusf_m1a2sep1tuskiiwd_usarmy",                                   // M1A2SEPv1 (Tusk II)
    "USAF_A10",                                                         // A-10C Thunderbolt II
    "RHS_AH1Z",                                                // F-35A Lightning II
    "RHS_M2A3_BUSKIII_wd",                                                        // F-35A Lightning II (Heavy)
    "RHS_A10",                                                          // A-10A (CAS)
    "RHS_M2A2_BUSKI_WD",                                                         // F-15C Eagle
    "rhsgref_cdf_t80b_tv",                                                         // F-15D Eagle
    "PRACS_M109A6",                                                         // F-15E Strike Eagle
    "RHS_AH64D_wd",                                                      // F/A-18 E Super Hornet
    "PRACS_M430",                                                      // F/A-18 F Super Hornet
    "PRACS_M270",                                             // F/A-181 Black Wasp II
    "RHS_A10",                                     // F/A-181 Black Wasp II (Stealth)
    "rhsusf_f22"                                               // V-44 X Blackfish (Armed)
];
