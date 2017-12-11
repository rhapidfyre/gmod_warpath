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
myupgrade.desc		= "Kill stuff to get ammo back. Headshots are important." -- Should be short, to the point.

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
hook.Add("InitPostEntity", "AddScavengeUpgrade", function()
	
	table.insert(warpath_upgrades, myupgrade)
	
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
		if hasUp != 0 then return true
		else return false end
	end

	-- ADD YOUR FUNCTIONS HERE
	local function ScavengeUpgrade(args)
		if args[1] == myupgrade.name then
			local ply 		= args[4]
			local mylevel 	= ply:GetUpgrade(args[1])
			
			if mylevel == 0 then mylevel = false
			else mylevel = true end
			
			if args[3] and !mylevel then
				local points = ply:GetPoints()
				local cost = myupgrade["cost"]
				if points >= cost then
					ply:SetPoints(ply:GetPoints()-cost)
					SetHasScavenge(ply, 1)
					print("DEBUG Death Scavenge purchased")
					
				end
			end
		end
	end
		

local function DeathScavengePlayer(ply, inf, atk)
	print("DEBUG Player scavenge")
	if IsValid(atk) then
		if atk:IsPlayer() && GetHasScavenge(atk) then
				local actwep = atk:GetActiveWeapon()
				if actwep:GetHoldType() != "melee"  || actwep:GetHoldType() != nil then
					local maxammo = GetMaxAmmo(ply, actwep)
					print(GetMaxAmmo(ply, actwep))
					atk:SetAmmo(math.Round((actwep.Owner:GetAmmoCount( actwep:GetPrimaryAmmoType()))+(maxammo*.25)), actwep:GetPrimaryAmmoType())
					print((GetMaxAmmo(ply, actwep)*.25))
				end
			
		end
	end
end
	
local function DeathScavengeNPC(ent, atk, inf)
	print("DEBUG NPC scavenge")
	if IsValid(atk) then
		if atk:IsPlayer() && GetHasScavenge(atk) then
				local actwep = atk:GetActiveWeapon()
				print(actwep)
				if actwep:GetHoldType() != "melee" || actwep:GetHoldType() != nil then
					local maxammo = GetMaxAmmo(ply, actwep)
					print(GetMaxAmmo(ply, actwep))
					atk:SetAmmo(math.Round((actwep.Owner:GetAmmoCount( actwep:GetPrimaryAmmoType()))+(maxammo*.05)), actwep:GetPrimaryAmmoType())
					print("Ammo is "..(GetMaxAmmo(ply, actwep)*.05))
				end
			
		end
	end
end	
hook.Add("DoPlayerDeath", "DeathScavengePlayer", DeathScavengePlayer)
hook.Add("OnNPCKilled", "DeathScavengeNPC", DeathScavengeNPC)
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






