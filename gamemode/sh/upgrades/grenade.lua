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
myupgrade.name 		= "grenade" -- Must be in coding convention. Used for gamemode purposes.
myupgrade.title		= "Grenade" -- Title for the player's menu
myupgrade.desc		= "Click to get a grenade!" -- Should be short, to the point.

-- Menu applicability
myupgrade.npc		= false -- True if npc upgrade (shows up in F4 NPC Menu)
myupgrade.player	= true -- True if player upgrade (shows up in C context menu)
myupgrade.stat		= false -- True if not a perk upgrade

-- Can be as long as you want. Full description of upgrade.
myupgrade.longdesc  = "Buying a level of this upgrade will increase the amount of health you have by the percentage bonus of your current level." 

-- Declares the base point cost for each upgrade level
-- KEY: The level for the player's request
-- VAL: Points required to purchase corresponding key level
myupgrade["cost"] = 1



----- THIS CONCLUDES THE MINIMUM REQUIREMENTS FOR THE INFO TABLE -----



-- Adds the table info to the gamemode (REQUIRED)
hook.Add("InitPostEntity", "AddGrenadeUpgrade", function()
	
	--I Commented this out, so that this template isn't added to the gamemode.
	table.insert(warpath_upgrades, myupgrade)
	
end)

-------------------------------------------------
-- Everything below should be server side only --
-------------------------------------------------
if SERVER then

	local function SetHasGrenade (ply, bool)
		ply:SetUpgrade(myupgrade.name, bool)
	end

	local function GetHasGrenade(ply)
		local hasUp = ply:GetUpgrade(myupgrade.name) 
		if hasUp != 0 then return true
		else return false end
	end
	
	local function Grenade(ply)

		 --if (ply:GetPoints() >=1) then
		
			if GetHasGrenade(ply) == false then
				ply:Give("weapon_frag")
				print("DEBUG Here's a grenade for you!")
			elseif GetHasGrenade(ply) == true then
				ply:GiveAmmo(1, 10, false)
				print("DEBUG Another one!")
			else
			end
		--end
end

	-- ADD YOUR FUNCTIONS HERE
	local function GrenadeUpgrade(args)
		if args[1] == myupgrade.name then
			local ply 		= args[4]
			local mylevel 	= ply:GetUpgrade(args[1])

			if mylevel == 0 then 
			print("DEBUG Grenade is false")
			mylevel = false
			else mylevel = true end
			
			if args[3] and !mylevel then
				local points = ply:GetPoints()
				local cost = myupgrade["cost"]
				if points >= cost then
					ply:SetPoints(ply:GetPoints() - 1)
					Grenade(ply)
					if GetHasGrenade(ply) == false then SetHasGrenade(ply,1) end
					print("Purchased Grenade")
					
				end
			end
		end
	end
		

	
		--[[
		args[1] =
			upgrade name (myupgrade.name)
		
		args[2] =
			"upgrade"	= Player is purchasing upgrade
			"reset"		= Round is over and upgrades are being reset (don't do anything if you don't want it to reset)
			"downgrade" = Player is refunding the upgrade
			
		args[3] =
			BOOLEAN		= True if team upgrade, false if player upgrade
			
		args[4] =
			Entity; Player
	]]
	hook.Add("DoUpgrade", "GiveGrenade", GrenadeUpgrade)
end






