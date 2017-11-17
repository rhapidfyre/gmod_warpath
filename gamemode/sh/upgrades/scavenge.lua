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
myupgrade.name 		= "scavenge" -- Must be in coding convention. Used for gamemode purposes.
myupgrade.title		= "Death Scavenge" -- Title for the player's menu
myupgrade.desc		= "Explode on death. A fun time for all." -- Should be short, to the point.

-- Menu applicability
myupgrade.npc		= false -- True if npc upgrade (shows up in F4 NPC Menu)
myupgrade.player	= true -- True if player upgrade (shows up in C context menu)

-- Can be as long as you want. Full description of upgrade.
myupgrade.longdesc  = "Buying a level of this upgrade will increase the amount of health you have by the percentage bonus of your current level." 

-- Declares the base point cost for each upgrade level
-- KEY: The level for the player's request
-- VAL: Points required to purchase corresponding key level
myupgrade["cost"] = 1



----- THIS CONCLUDES THE MINIMUM REQUIREMENTS FOR THE INFO TABLE -----



-- Adds the table info to the gamemode (REQUIRED)
hook.Add("InitPostEntity", "AddUpgrade", function()
	--[[
	I Commented this out, so that this template isn't added to the gamemode.
	table.insert(warpath_upgrades, myupgrade)
	]]
end)

-------------------------------------------------
-- Everything below should be server side only --
-------------------------------------------------
if SERVER then

	local function SetHasScavenge(ply, bool)
		ply:SetUpgrade(myupgrade.name, bool)
	end

	local function GetHasScavenge(ply)
		local hasUp = ply:GetUpgrade(myupgrade.name) 
		if hasUp == 1 then return true
		else return false end
	end

	-- ADD YOUR FUNCTIONS HERE
	local function ScavengeUpgrade(args)
		if args[1] == myupgrade.name then
			local ply 		= args[4]
			local mylevel 	= ply:GetUpgrade(args[1])
			
			if mylevel == 0 then mylevel = false
			else mylevel = true end
			
			if !args[3] and !mylevel then
				local points = ply:GetPoints()
				local cost = myupgrade["cost"]
				if points >= cost then
					ply:SetPoints(ply:GetPoints()-cost)
					SetHasScavenge(ply, 1)
					
				end
			end
		end
	end
		

local function DeathScavengePlayer(ply, inf, atk)
	if atk:IsPlayer() && GetHasScavenge(ply) then
			local actwep = atk:GetActiveWeapon()
			if actwep:GetHoldType() != "melee" then
				local maxammo = actwep:GetMaxAmmo()
				print(actwep:GetMaxAmmo())
				atk:SetAmmo(math.Round(actwep:Ammo1()+(maxammo*.25)), actwep:GetPrimaryAmmoType())
				print((actwep:GetMaxAmmo()*.25))
			end
		
		
	end
end
	
	
local function DeathScavengeNPC(ply, inf, atk)
	if atk:IsPlayer() && GetHasScavenge(ply) then
			local actwep = atk:GetActiveWeapon()
			print(actwep)
			if actwep:GetHoldType() != "melee" then
				local maxammo = actwep:GetMaxAmmo()
				print(actwep:GetMaxAmmo())
				atk:SetAmmo(math.Round(actwep:Ammo1()+(maxammo*.05)), actwep:GetPrimaryAmmoType())
				print("Ammo is "..(actwep:GetMaxAmmo()*.05))
			end
		
		
	end
end	
hook.Add("PlayerDeath", "DeathScavengePlayer", DeathScavengePlayer)
hook.Add("NPCDeath", "DeathScavengeNPC", DeathScavengeNPC)
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
	hook.Add("DoUpgrade", "GiveScavenge", ScavengeUpgrade)
end






