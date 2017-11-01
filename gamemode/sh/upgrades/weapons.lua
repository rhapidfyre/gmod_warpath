
--[[

	Delete this file if you do not want to use any of the base gamemode weapons.
	Note: Player will always spawn with "war_pistol" unless you remove it from 'sv/player.lua'

]]
local myupgrade = {}
myupgrade.name 		= "weapon_base" -- Must be in coding convention. Used for gamemode purposes.
myupgrade.title		= "Weapon Upgrade" -- Title for the player's menu
myupgrade.desc		= "Gives AR2, Shotgun, and Crossbow" -- Should be short, to the point.
myupgrade.longdesc  = "Purchasing this upgrade will provide more weapon choices." 

myupgrade["cost"] = {}
myupgrade["cost"][1] 	= 1
myupgrade["cost"][2] 	= 1
myupgrade["cost"][3] 	= 1

myupgrade["increase"] = {}
myupgrade["increase"][1]  = "war_shotgun"
myupgrade["increase"][2]  = "war_rifle"
myupgrade["increase"][3]  = "war_crossbow"



-- Adds the table info to the gamemode (REQUIRED)
hook.Add("PostGamemodeLoaded", "AddUpgrade", function()
	table.insert(warpath.upgrades, myupgrade)
end)

-------------------------------------------------
-- Everything below should be server side only --
-------------------------------------------------
if SERVER then

	local function GiveWeapons(ply)
		if ply:WarWeapons("war_shotgun") then 
			ply:Give("war_shotgun")
		end
		if ply:WarWeapons("war_rifle") then 
			ply:Give("war_rifle")
		end
		if ply:WarWeapons("war_crossbow") then 
			ply:Give("war_crossbow")
		end
	end
	
	local function MyFunction(args)
		
		if args[1] == myupgrade.name and !(args[3]) then
	
			local current = ply:GetUpgrade("weapon_base")
			local cost = myupgrade["cost"][current + 1]
			if cost <= ply:GetPoints() then
				ply:SetPoints(ply:GetPoints() - cost)
				ply:WarWeapons(myupgrade["increase"][current + 1]
			else
				print("(DEBUG) Insufficient points for weapons upgrade!")
			end
			GiveWeapons(ply)
	
		end
	
	end
		
	local metaTbl = FindMetaTable("Player")
	function metaTbl:WarWeapons(weapon, value)
		if IsValid(weapon) then
			if self.wpntable == nil then self.wpntable = {} end
			if self.wpntable[weapon] == nil then self.wpntable[weapon] = {} end
			if value then
				self.wpntable[weapon] = value
			end
			return self.wpntable[weapon]
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
	hook.Add("DoUpgrade", "GiveMeAName", MyFunction)
	
	hook.Add("OnPlayerSpawn", "Rearm", GiveWeapons)
end






