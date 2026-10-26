// MS Liberation campaign configuration. Loaded after faction presets on every machine.
MSL_enabled = true;
MSL_startingCash = 1500;
MSL_captureCash = 350;
MSL_captureXP = 150;
MSL_killXP = 10;
MSL_sellRatio = 0.35;
MSL_captureHold = 60;
MSL_captureCoreRadius = 45;
MSL_captureResidual = 2;
MSL_linkDistance = 2500;
MSL_supplyCooldown = 900;
MSL_supplySignalTimeout = 180;
MSL_supplySignalRadius = 120;
MSL_supplyPlaneCandidates = ["PRACS_C130", "RHS_C130J", "B_T_VTOL_01_infantry_F"];
MSL_supplyCrate = "B_supplyCrate_F";
MSL_supplySignalsDay = ["SmokeShell", "SmokeShellGreen", "SmokeShellBlue", "SmokeShellOrange", "SmokeShellPurple", "SmokeShellRed", "SmokeShellYellow"];
MSL_supplySignalsNight = ["F_40mm_White", "F_40mm_Green", "F_40mm_Red", "F_40mm_Yellow", "F_Signal_Red", "F_Signal_Green", "F_Signal_White", "Chemlight_green", "Chemlight_red", "Chemlight_blue", "Chemlight_yellow"];
MSL_specopsCandidates = ["PRACS_SLA_Especas_Recon_FAC", "PRACS_SLA_Especas_M"];
MSL_airCAS = ["PRACS_SLA_MiG27", "PRACS_SLA_SU22", "PRACS_SLA_Su25"];
MSL_airCAP = ["PRACS_SLA_MiG21", "PRACS_SLA_MiG23", "rhs_mig29s_vvsc"];
MSL_transportHelos = ["PRACS_SLA_Mi8amt"];
// Explicit weapon preset; local overrides below take final precedence for paid equipment.
[] call compileFinal preprocessFileLineNumbers "presets\msl\custom_weapons.sqf";
[] call compileFinal preprocessFileLineNumbers "presets\msl\custom_attachments.sqf";
// [class, purchase price, required level]; overrides generated category prices.
MSL_priceOverrides = [];

// Equipment tiers: [category, purchase price, required level]. Camo variants share stats.
// Basic kit remains free via MSL_freeKits; these are replacement/upgrade shop prices.
MSL_equipmentTiers = [
    ["item",120,1], ["goggles",50,1],
    ["uniform",0,1], ["ghillie",700,4], ["wetsuit",450,3],
    ["headgear",100,1], ["helmet",350,2], ["helmet_heavy",650,4],
    ["vest",200,1], ["armor_light",550,2], ["armor",900,3], ["armor_heavy",1500,4],
    ["backpack",250,1], ["backpack_medium",450,2], ["backpack_large",650,3],
    ["radio_pack",500,2], ["static_pack",3500,4],
    ["optic",350,2], ["optic_medium",650,3], ["optic_long",1100,4],
    ["optic_night",2200,5], ["optic_thermal",4500,7],
    ["muzzle",200,1], ["suppressor",800,3], ["pointer",300,2], ["bipod",250,2],
    ["nvg",2000,5], ["nvg_thermal",5000,7],
    ["binocular",150,1], ["rangefinder",750,3], ["designator",1800,5],
    ["navigation",250,2], ["radio",100,1], ["medical",350,1],
    ["toolkit",400,1], ["detector",500,2], ["uav_terminal",1500,4]
];

// Residual enemies require continuous suppression; 0 enemies only require the core hold.
MSL_captureClearanceRadius = 350; // Full clearance area; core remains 45m.
MSL_captureSuppression = 450; // 7m30s; set 300..600 for 5..10 minutes.
MSL_terminalRadius = 100; // Main base only. FOBs retain field shopping, not banking/progression.
// Cumulative XP per level, strictly increasing, starting at zero.
MSL_levelThresholds = [0,500,1200,2200,3600,5500,8000,11000,15000,20000];
MSL_levelTitles = ["RECRUIT","OPERATOR","SPECIALIST","VETERAN","NIGHT OPS","PATHFINDER","ELITE","VANGUARD","COMMANDO","LEGEND"];
// Category rules; exact class names are also accepted and override categories.
MSL_unlockRules = [["weapon_pistol",1],["weapon_rifle",2],["weapon_launcher",4],["optic",2],["suppressor",3],["nvg",5],["armor",3],["item",1],["magazine",1],["backpack",1],["goggles",1]];
MSL_defenseEnabled = true;
MSL_defenseSectorCooldown = 2700;
MSL_defenseCash = 650;
MSL_defenseXP = 250;
MSL_dogtagCash = 100;
MSL_dogtagXP = 30;
MSL_dogtagRange = 3;

// Contextual operations: no periodic defense/isolated-raid generator.
MSL_scenarioCooldown = 2700; // At least 45m between large contextual defenses.
MSL_cityCounterChance = 0.35;
MSL_fobCounterChance = 0.30;
MSL_cityCounterDelay = [180,420];
MSL_fobCounterDelay = [240,510]; // +60s warning: departure roughly 5..10m after construction.
MSL_defenseHoldRange = [600,1200];
MSL_defenseWaveGap = [150,240];
MSL_defenseAliveLimit = 16;
MSL_evacCooldown = 1200;
MSL_evacHelos = ["PRACS_CH53","RHS_UH60M","B_Heli_Transport_01_F"];
MSL_evacApproachDelay = [90,180];
MSL_evacBoardTime = 90;
MSL_evacFlightTimeout = 360;
MSL_evacCash = 250;
MSL_evacXP = 100;

// Free armory kits: [id, label, primary, launcher]. Shared by every player role.
MSL_spawnUniform = "PRACS_M10_SDPM_uniform";
MSL_freeKits = [
    ["cetme","CETME / 소총수","PRACS_CETME",""],
    ["hk33","HK33 / 소총수","PRACS_HK33",""],
    ["m16","M16A2 / 소총수","UK3CB_M16A2",""],
    ["mg","M60 / 기관총수","PRACS_M60A2",""],
    ["at","SAAWS / 대전차","PRACS_HK33","PRACS_SAAWS"],
    ["aa","Stinger / 대공","PRACS_HK33","rhs_weap_fim92"]
];
