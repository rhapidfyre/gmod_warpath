
--[[

	Delete this file if you do not want to use any of the base gamemode weapons.
	Note: Player will always spawn with "war_pistol" unless you remove it from 'sv/player.lua'

]]
local myupgrade = {}
myupgrade.name 		= "weapon_base" -- Must be in coding convention. Used for gamemode purposes.
myupgrade.title		= "Weapon Upgrade" -- Title for the player's menu
myupgrade.desc		= "Gives AR2, then Shotgun, then Crossbow" -- Should be short, to the point.
myupgrade.longdesc  = "Purchasing this upgrade will provide more weapon choices." 

-- Menu applicability
myupgrade.npc		= true -- True if npc upgrade (shows up in F4 NPC Menu)
myupgrade.player	= false -- True if player upgrade (shows up in C context menu)

myupgrade["cost"] = {}
myupgrade["cost"][1] 	= 1
myupgrade["cost"][2] 	= 1
myupgrade["cost"][3] 	= 1
myupgrade["cost"][4] 	= 1

myupgrade["increase"] = {}
myupgrade["increase"][1]  = "war_pistol"
myupgrade["increase"][2]  = "shotgun"
myupgrade["increase"][3]  = "ar2"
myupgrade["increase"][4]  = "crossbow"

myupgrade["level"] = {}
myupgrade["level"][1] = 1
myupgrade["level"][2] = 1

-- Adds the table info to the gamemode (REQUIRED)
hook.Add("InitPostEntity", "AddWeaponBase", function()
	table.insert(warpath_upgrades, myupgrade)
end)

-------------------------------------------------
-- Everything below should be server side only --
-------------------------------------------------
if SERVER then

	local function GiveWeapons(ply)
        print("(DEBUG) Running GiveWeapons(ply)")
		if ply:WarWeapons("war_shotgun") then 
            print("(DEBUG) Shotgun: Yes")
			ply:Give("war_shotgun")
		end
		if ply:WarWeapons("war_rifle") then 
            print("(DEBUG) Rifle: Yes")
			ply:Give("war_rifle")
		end
		if ply:WarWeapons("war_crossbow") then 
            print("(DEBUG) Crossbow: Yes")
			ply:Give("war_crossbow")
		end
	end

	local function UpgradeWeapons(args)
        local ply = args[4]
		if args[1] == myupgrade.name and !args[3] then
	
			local current = ply:GetUpgrade("weapon_base")
			local cost = myupgrade["cost"][current + 1]
			if cost <= ply:GetPoints() then
                print("(DEBUG) Successfully upgraded weapons!")
				ply:SetPoints(ply:GetPoints() - cost)
				ply:WarWeapons(myupgrade["increase"][current + 1], true)
			else
				print("(DEBUG) Insufficient points for weapons upgrade!")
			end
			GiveWeapons(ply)
	
		end
	
	end
		
	local metaTbl = FindMetaTable("Player")
	function metaTbl:WarWeapons(weapon, value)
    
		if weapon ~= nil then
        
            print("(DEBUG) WarWeapons Received")
			if self.wpntable == nil then
                print("(DEBUG) SWeapon Table was nil")
                self.wpntable = {}
               end
               
			if self.wpntable[weapon] == nil then
                print("(DEBUG) Weapon Slot was nil")
                self.wpntable[weapon] = false
            end
            
			if value then
                print("(DEBUG) Value set to "..tostring(value))
				self.wpntable[weapon] = value
			end
            
            print("(DEBUG) returning "..tostring(self.wpntable[weapon]))
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
	hook.Add("DoUpgrade", "GiveMeAName", UpgradeWeapons)
	
	hook.Add("OnPlayerSpawn", "Rearm", GiveWeapons)
end






