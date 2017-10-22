
--[[
	Do not change anything in this file!
	
	This is used to setup upgrade counts
	for the formulas to use in other Lua files.
]]


net.Receive("CL_NPCUpgrade", function(len, ply)

end)
net.Receive("CL_PLYUpgrade", function(len, ply)

end)


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
        [1]  = WEAPON_PROFICIENCY_POOR,
        [2]  = WEAPON_PROFICIENCY_AVERAGE,
        [3]  = WEAPON_PROFICIENCY_GOOD,
        [4]  = WEAPON_PROFICIENCY_VERY_GOOD,
        [5]  = WEAPON_PROFICIENCY_PERFECT
    }

    -- Team Levels
upgrades = {}
    upgrades[1] = {}
        upgrades[1]["points"]   = POINT_START
        upgrades[1]["health"]   = 1
        upgrades[1]["damage"]   = 1
        upgrades[1]["accuracy"] = 1
        upgrades[1]["speed"]    = 1
    upgrades[2] = {}
        upgrades[2]["points"]   = POINT_START
        upgrades[2]["health"]   = 1
        upgrades[2]["damage"]   = 1
        upgrades[2]["accuracy"] = 1
        upgrades[2]["speed"]    = 1
    upgrades[3] = {}
        upgrades[3]["points"]   = POINT_START
        upgrades[3]["health"]   = 1
        upgrades[3]["damage"]   = 1
        upgrades[3]["accuracy"] = 1
        upgrades[3]["speed"]    = 1
    upgrades[4] = {}
        upgrades[4]["points"]   = POINT_START
        upgrades[4]["health"]   = 1
        upgrades[4]["damage"]   = 1
        upgrades[4]["accuracy"] = 1
        upgrades[4]["speed"]    = 1
        