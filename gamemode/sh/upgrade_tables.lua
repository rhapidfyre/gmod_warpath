
ups = {}
















weapon_cost = {}
	weapon_cost["NPC"] = {}
	weapon_cost["NPC"]["weapon_ar2"]	  = 1
	weapon_cost["NPC"]["weapon_shotgun"]  = 1
	weapon_cost["NPC"]["weapon_crossbow"] = 1

upgrade_cost = {}
    upgrade_cost["health"] = {
        [1]  = 1, [2]  = 2, [3]  = 3, [4]  = 4, [5]  = 5,
        [6]  = 6, [7]  = 7, [8]  = 8, [9]  = 9, [10] = 10
    }
    upgrade_cost["damage"] = {
        [1]  = 1, [2]  = 2, [3]  = 3, [4]  = 4, [5]  = 5,
        [6]  = 6, [7]  = 7, [8]  = 8, [9]  = 9, [10] = 10
    }
    upgrade_cost["accuracy"] = {
        [1]  = 1, [2]  = 2, [3]  = 3, [4]  = 4, [5]  = 5,
        [6]  = 6, [7]  = 7, [8]  = 8, [9]  = 9, [10] = 10
    }
    upgrade_cost["speed"] = {
        [1]  = 1, [2]  = 2, [3]  = 3, [4]  = 4, [5]  = 5,
        [6]  = 6, [7]  = 7, [8]  = 8, [9]  = 9, [10] = 10
    }
    upgrade_cost["weapon"] = {
        [1]  = 1, [2]  = 2, [3]  = 3, [4]  = 4, [5]  = 5,
        [6]  = 6, [7]  = 7, [8]  = 8, [9]  = 9, [10] = 10
    }
    
    -- Level Definitions
upgrade_info = {}
    upgrade_info["perc"] = {
        [1]  = 0.00,
        [2]  = 0.25,
        [3]  = 0.50,
        [4]  = 0.75,
        [5]  = 1.00,
        [6]  = 1.25,
        [7]  = 1.50,
        [8]  = 1.75,
        [9]  = 2.00,
        [10] = 5.00
    }
    upgrade_info["accu"] = {
        [1]   = WEAPON_PROFICIENCY_POOR,
        [2]   = WEAPON_PROFICIENCY_POOR,
        [3]   = WEAPON_PROFICIENCY_POOR,
        [4]   = WEAPON_PROFICIENCY_POOR,
        [5]   = WEAPON_PROFICIENCY_POOR,
        [6]   = WEAPON_PROFICIENCY_POOR,
        [7]   = WEAPON_PROFICIENCY_AVERAGE,
        [8]   = WEAPON_PROFICIENCY_GOOD,
        [9]   = WEAPON_PROFICIENCY_VERY_GOOD,
        [10]  = WEAPON_PROFICIENCY_PERFECT
    }
    upgrade_info["weapon"] = {
        [1]  = "weapon_smg1",
        [2]  = "weapon_smg1",
        [3]  = "weapon_smg1",
        [4]  = "weapon_smg1",
        [5]  = "weapon_smg1",
        [6]  = "weapon_smg1",
        [7]  = "weapon_ar2",
        [8]  = "weapon_ar2",
        [9]  = "weapon_ar2",
        [10]  = "weapon_ar2"
    }

    -- Team Levels
upgrades = {}
    upgrades[1] = {}
        upgrades[1]["points"]   = POINT_START
        upgrades[1]["spent"]    = 0
        upgrades[1]["health"]   = 1
        upgrades[1]["damage"]   = 1
        upgrades[1]["accuracy"] = 6
        upgrades[1]["speed"]    = 1
    upgrades[2] = {}
        upgrades[2]["points"]   = POINT_START
        upgrades[2]["spent"]    = 0
        upgrades[2]["health"]   = 1
        upgrades[2]["damage"]   = 1
        upgrades[2]["accuracy"] = 6
        upgrades[2]["speed"]    = 1
        upgrades[2]["weapon"]   = 1
    upgrades[3] = {}
        upgrades[3]["points"]   = POINT_START
        upgrades[3]["spent"]    = 0
        upgrades[3]["health"]   = 1
        upgrades[3]["damage"]   = 1
        upgrades[3]["accuracy"] = 6
        upgrades[3]["speed"]    = 1
        upgrades[3]["weapon"]   = 1
    upgrades[4] = {}
        upgrades[4]["points"]   = POINT_START
        upgrades[4]["spent"]    = 0
        upgrades[4]["health"]   = 1
        upgrades[4]["damage"]   = 1
        upgrades[4]["accuracy"] = 6
        upgrades[4]["speed"]    = 1
        upgrades[4]["weapon"]   = 1
		
upweapons = {}
	upweapons[1] = {}
		upweapons[1]["weapon_ar2"] 		= false
		upweapons[1]["weapon_shotgun"] 	= false
		upweapons[1]["weapon_crossbow"] = false
	upweapons[2] = {}
		upweapons[2]["weapon_ar2"] 		= false
		upweapons[2]["weapon_shotgun"] 	= false
		upweapons[2]["weapon_crossbow"] = false
	upweapons[3] = {}
		upweapons[3]["weapon_ar2"] 		= false
		upweapons[3]["weapon_shotgun"] 	= false
		upweapons[3]["weapon_crossbow"] = false
	upweapons[4] = {}
		upweapons[4]["weapon_ar2"] 		= false
		upweapons[4]["weapon_shotgun"] 	= false
		upweapons[4]["weapon_crossbow"] = false