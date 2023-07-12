/*
    Needed Mods:
    - None

    Optional Mods:
    - None
*/

// Enemy infantry classes
opfor_officer = "PRACS_SLA_Guards_Infantry_SL";                                          // Officer
opfor_squad_leader = "PRACS_SLA_Guards_Infantry_SL";                                  // Squad Leader
opfor_team_leader = "PRACS_SLA_Guards_Infantry_TL";                                   // Team Leader
opfor_sentry = "PRACS_SLA_Guards_Infantry_RKT";                                      // Rifleman (Lite)
opfor_rifleman = "PRACS_SLA_Guards_Infantry";                                         // Rifleman
opfor_rpg = "PRACS_SLA_Guards_Infantry_RPG";                                          // Rifleman (LAT)
opfor_grenadier = "PRACS_SLA_Guards_Infantry_GRE";                                     // Grenadier
opfor_machinegunner = "PRACS_SLA_Guards_Infantry_MG";                                 // Autorifleman
opfor_heavygunner = "PRACS_SLA_Guards_Infantry_MG";                                  // Heavy Gunner
opfor_marksman = "PRACS_SLA_Guards_Infantry_M";                                       // Marksman
opfor_sharpshooter = "PRACS_SLA_Guards_Infantry_M";                                // Sharpshooter
opfor_sniper = "PRACS_SLA_Especas_M";                                            // Sniper
opfor_at = "PRACS_SLA_Guards_Infantry_RPG_AT";                                            // AT Specialist
opfor_aa = "PRACS_SLA_Guards_Infantry_AA";                                            // AA Specialist
opfor_medic = "PRACS_SLA_Guards_Infantry_Medic";                                              // Combat Life Saver
opfor_engineer = "PRACS_SLA_Guards_Infantry_ENG";                                        // Engineer
opfor_paratrooper = "PRACS_SLA_Especas_Recon_FAC";                                   // Paratrooper

// Enemy vehicles used by secondary objectives.
opfor_mrap = "PRACS_SLA_UAZ_DSHKM";                                             // Ifrit
opfor_mrap_armed = "PRACS_SLA_Tigr";                                   // Ifrit (HMG)
opfor_transport_helo = "PRACS_SLA_Mi8amt";                   // Mi-290 Taru (Bench)
opfor_transport_truck = "PRACS_SLA_URAL";                         // Tempest Transport (Covered)
opfor_ammobox_transport = "RHS_Ural_Open_MSV_01";                     // Tempest Transport (Open) -> Has to be able to transport resource crates!
opfor_fuel_truck = "PRACS_SLA_URAL_Fuel";                                 // Tempest Fuel
opfor_ammo_truck = "PRACS_SLA_Ural_Ammo";                                 // Tempest Ammo
opfor_fuel_container = "Land_Pod_Heli_Transport_04_fuel_F";             // Taru Fuel Pod
opfor_ammo_container = "Land_Pod_Heli_Transport_04_ammo_F";             // Taru Ammo Pod
opfor_flag = "PRACS_SLA_Flag";                                             // Flag

/* Adding a value to these arrays below will add them to a one out of however many in the array, random pick chance.
Therefore, adding the same value twice or three times means they are more likely to be chosen more often. */

/* Militia infantry. Lightweight soldier classnames the game will pick from randomly as sector defenders.
Think of them like garrison or military police forces, which are more meant to control the local population instead of fighting enemy armies. */
militia_squad = [
    "PRACS_SLA_A_Infantry",                                                     // Rifleman (Lite)
    "PRACS_SLA_A_Infantry",                                                     // Rifleman (Lite)
    "PRACS_SLA_A_Infantry",                                                     // Rifleman (Lite)
    "PRACS_SLA_A_Infantry",                                                     // Rifleman (Lite)
    "PRACS_SLA_A_Infantry_O",                                                     // Rifleman
    "PRACS_SLA_A_Infantry_SL",                                                     // Rifleman
    "PRACS_SLA_A_Infantry_RKT",                                                 // Rifleman (AT)
    "PRACS_SLA_A_Infantry_MG",                                                  // Autorifleman
    "PRACS_SLA_A_Infantry_M",                                                   // Marksman
    "PRACS_SLA_A_Infantry_Medic",                                               // Medic
    "PRACS_SLA_A_Infantry_ENG"                                                    // Engineer
];

// Militia vehicles. Lightweight vehicle classnames the game will pick from randomly as sector defenders. Can also be empty for only infantry milita.
militia_vehicles = [
    "PRACS_SLA_UAZ_DSHKMd"                                                  // Qilin (armed)
];

// All enemy vehicles that can spawn as sector defenders and patrols at high enemy combat readiness (aggression levels).
opfor_vehicles = [
    "PRACS_SLA_ZU23",
    "PRACS_SLA_ZPU4",
    "PRACS_SLA_S60",
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (HMG)
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (GMG)
    "PRACS_SLA_UAZ_AGS",                                                  // Ifrit (GMG)
    "PRACS_SLA_UAZ_SPG9",
    "PRACS_SLA_Tigr",
    "PRACS_SLA_URAL_Zu23",
    "PRACS_SLA_BTR60",
    "PRACS_SLA_BTR80",
    "PRACS_SLA_BTR80A",
    "PRACS_SLA_Type63",
    "PRACS_SLA_BMD2",
    "PRACS_SLA_BMP2",
    "PRACS_SLA_BMP1",
    "PRACS_SLA_BRDM",
    "PRACS_SLA_BRDM_ATGM",
    "PRACS_SLA_2S6M_Tunguska",
    "PRACS_SLA_ZSU23",
    "PRACS_SLA_SA8",
    "PRACS_SLA_SA9",
    "PRACS_SLA_SA17",
    "PRACS_SLA_MTLB_ZU23",
    "PRACS_SLA_T72B",                                                    // Qilin (AT)
    "PRACS_SLA_T72BV",                                        // BTR-K Kamysh
    "PRACS_SLA_T80U",                                        // BTR-K Kamysh
    "rhs_t80um",                                                // T-140 Angara
    "rhs_t90a_tv"                                                // T-140K Angara
];

// All enemy vehicles that can spawn as sector defenders and patrols but at a lower enemy combat readiness (aggression levels).
opfor_vehicles_low_intensity = [
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (HMG)
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (HMG)
    "PRACS_SLA_BRDM",
    "PRACS_SLA_Tigr",                                                    // Qilin (AT)
    "PRACS_SLA_UAZ_SPG9",                                          // MSE-3 Marid
    "PRACS_SLA_BTR60"
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at high enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles = [
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (HMG)
    "PRACS_SLA_UAZ_AGS",                                                  // Ifrit (GMG)
    "PRACS_SLA_BTR60",                                                  // Ifrit (GMG)
    "PRACS_SLA_UAZ_SPG9",                                                    // Qilin (AT)
    "PRACS_SLA_URAL",                                           // Tempest Transport
    "PRACS_SLA_URAL_Open",                                             // Tempest Transport (Covered)
    "PRACS_SLA_Type63",                                        // BTR-K Kamysh
    "PRACS_SLA_BTR80",                                        // BTR-K Kamysh
    "PRACS_SLA_BTR80A",                                            // ZSU-39 Tigris
    "PRACS_SLA_BMP2",                                            // ZSU-39 Tigris
    "PRACS_SLA_BMP1",
    "PRACS_SLA_BRDM",
    "PRACS_SLA_T72B",                                                // T-100 Varsuk
    "PRACS_SLA_T72B",                                                // T-100 Varsuk
    "PRACS_SLA_T72BV",                                                // T-140 Angara
    "PRACS_SLA_T80U",                                               // T-140K Angara
    "PRACS_SLA_Mi8amt",                                 // Po-30 Orca (Armed)
    "PRACS_SLA_ZSU23",
    "PRACS_SLA_URAL_Zu23",
    "PRACS_SLA_MTLB_ZU23",
    "PRACS_SLA_SA17",
    "PRACS_SLA_SA8",
    "rhs_t90a_tv",
    "rhs_t80um",
    "PRACS_SLA_BMD2",
    "PRACS_SLA_2S6M_Tunguska",                                 // Po-30 Orca (Armed)
    "PRACS_SLA_Mi24V_UPK",                                      // Mi-290 Taru (Bench)
    "PRACS_SLA_Mi24D"                                 // Mi-48 Kajman
];

// All enemy vehicles that can spawn as battlegroups, either assaulting or as reinforcements, at lower enemy combat readiness (aggression levels).
opfor_battlegroup_vehicles_low_intensity = [
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (HMG)
    "PRACS_SLA_UAZ_DSHKM",                                                  // Ifrit (HMG)
    "PRACS_SLA_URAL",                                           // Tempest Transport
    "PRACS_SLA_Tigr",                                          // MSE-3 Marid
    "PRACS_SLA_URAL_Zu23",                                        // BTR-K Kamysh
    "PRACS_SLA_BTR60",                                            // ZSU-39 Tigris
    "PRACS_SLA_BTR80",                                 // Po-30 Orca (Armed)
    "PRACS_SLA_Mi8amt"                                       // Mi-290 Taru (Bench)
];

/* All vehicles that spawn within battlegroups (see the above 2 arrays) and also hold 8 soldiers as passengers.
If something in this array can't hold all 8 soldiers then buggy behaviours may occur.    */
opfor_troup_transports = [
    "PRACS_SLA_URAL_Open",                                           // Tempest Transport
    "PRACS_SLA_URAL",                                             // Tempest Transport (Covered)
    "PRACS_SLA_Mi8amt"                                  // Po-30 Orca (Armed)
];

// Enemy rotary-wings that will need to spawn in flight.
opfor_choppers = [
    "PRACS_SLA_Mi8amt",                                      // Mi-290 Taru (Bench)
    "PRACS_SLA_Mi17Sh_UPK",
    "PRACS_SLA_Mi17Sh",
    "PRACS_SLA_Mi24D",                                 // Po-30 Orca (Armed)
    "PRACS_SLA_Mi24V_UPK"                                 // Mi-48 Kajman
];

// Enemy fixed-wings that will need to spawn in the air.
opfor_air = [
    "PRACS_SLA_MiG21",                                  // To-199 Neophron (CAS)
    "PRACS_SLA_MiG23",
    "PRACS_SLA_MiG23",
    "PRACS_SLA_MiG27",
    "PRACS_SLA_MiG27",
    "PRACS_SLA_SU22",
    "PRACS_SLA_Su25",
    "rhs_mig29s_vvsc"                                              // To-201 Shikra
];
