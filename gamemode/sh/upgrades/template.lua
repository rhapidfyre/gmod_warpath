
--[[
---------- MIN. REQUIRED ---------
This is the minimum amount of table info needed so that
all the menus work correctly. This table is inserted into the gamemode
so it can be used by the player(s).

If you do not include each of these keys, the upgrade will error.

This file is shared, so clients can build the information without
having to network information between server and client.

]]

local myupgrade = {}
myupgrade.name 		= "health_base" -- Must be in coding convention. Used for gamemode purposes.
myupgrade.title		= "Health Upgrade" -- Title for the player's menu
myupgrade.desc		= "Increase to Max Hit Points" -- Should be short, to the point.

-- Can be as long as you want. Full description of upgrade.
myupgrade.longdesc  = "Buying a level of this upgrade will increase the amount of health you have by the percentage bonus of your current level." 

-- Declares the base point cost for each upgrade level
-- KEY: The level for the player's request
-- VAL: Points required to purchase corresponding key level
myupgrade["cost"] = {}
myupgrade["cost"][1] 	= 1
myupgrade["cost"][2] 	= 2
myupgrade["cost"][3] 	= 3
myupgrade["cost"][4] 	= 4
myupgrade["cost"][5] 	= 5
myupgrade["cost"][6] 	= 6
myupgrade["cost"][7] 	= 7
myupgrade["cost"][8] 	= 8
myupgrade["cost"][9] 	= 9
myupgrade["cost"][10] 	= 10

-- Declares what percentage increase health gives
-- KEY: Player's current level
-- VAL: Value to add (in this case, HP to add per level)
myupgrade["increase"] = {}
myupgrade["increase"][1]  = 10
myupgrade["increase"][2]  = 25
myupgrade["increase"][3]  = 50
myupgrade["increase"][4]  = 75
myupgrade["increase"][5]  = 100
myupgrade["increase"][6]  = 125
myupgrade["increase"][7]  = 150
myupgrade["increase"][8]  = 175
myupgrade["increase"][9]  = 200
myupgrade["increase"][10] = 500

----- THIS CONCLUDES THE MINIMUM REQUIREMENTS FOR THE INFO TABLE -----



-- Adds the table info to the gamemode (REQUIRED)
hook.Add("PostGamemodeLoaded", "AddUpgrade", function()
	--[[
	I Commented this out, so that this template isn't added to the gamemode.
	table.insert(ups, myupgrade)
	]]
end)

-------------------------------------------------
-- Everything below should be server side only --
-------------------------------------------------
if SERVER then

	-- ADD YOUR FUNCTIONS HERE
	local function MyFunction(args)
		-- Do Stuff
	end
		
		
	--[[
		args[1] =
			upgrade name (myupgrade.name)
		
		args[2] =
			"upgrade"	= Player is purchasing upgrade
			"reset"		= Round is over and upgrades are being reset (don't do anything if you don't want it to reset)
			"downgrade" = Player is refunding the upgrade
			
		args[3] =
			Entity; Player
	]]
	hook.Add("DoUpgrade", "GiveMeAName", MyFunction)
end






