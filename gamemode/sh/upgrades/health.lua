----------------------------------
---------- MIN. REQUIRED ---------
----------------------------------
local myupgrade = {}
myupgrade.name 		= "health_base" -- Short name, used for upgrade detection/code purposes, keep short and in coding convention
myupgrade.title		= "Health Upgrade"
myupgrade.desc		= "Increase to Max Hit Points" -- Should be in the form of an improper sentence
myupgrade.longdesc  = "Buying a level of this upgrade will increase the amount of health you have by the percentage bonus of your current level." -- Proper grammar/punctuation, as long as you want.

-- Menu applicability
myupgrade.npc		= true -- True if npc upgrade (shows up in F4 NPC Menu)
myupgrade.player	= true -- True if player upgrade (shows up in C context menu)

-- Declares the base point cost for each upgrade level
-- KEY: Level in Question
-- VAL: Price to purchase level KEY
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
----------------------------------
---------------------------------- (end required)

-- Declares what value increase health gives
-- KEY: Current level
-- VAL: value increase
myupgrade["increase"] = {}
myupgrade["increase"][0]  = 0
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

myupgrade["level"] = {}
myupgrade["level"][1] = 1
myupgrade["level"][2] = 1




-- Adds the table info to the gamemode
hook.Add("InitPostEntity", "AddHealthBase", function()
    table.insert(warpath_upgrades, myupgrade)
end)
------------------------------------------
-- Everything below is server side only --
------------------------------------------
if SERVER then

	local function HPFormula(ply)
		local mylevel 	= ply:GetUpgrade("health_base")
		local hpMax 	= ply:GetMaxHealth()
		local hpMod 	= myupgrade["increase"][mylevel]
		-- Sets the new max health for player
		ply:SetMaxHealth(hpMax + hpMod)
		
		ply:SetHealth(ply:Health() + hpMod)
		if ply:Health() > ply:GetMaxHealth() then ply:SetHealth(ply:Health() + hpMod) end
	end
	
	-- Checks NPC Health Upgrade everytime it's purchased
	hook.Add("OnEntityCreated", "NPCHPUpgrade", function(ent)
		if ent:IsNPC() then
			timer.Simple(3, function()
			local warteam = ent:GetWarTeam()
				if warteam > 0 and warteam < 3 then
					local npclevel = myupgrade["level"][warteam]
					ent:SetMaxHealth(ent:GetMaxHealth() + myupgrade["increase"][npclevel])
					ent:SetHealth(ent:GetMaxHealth())
				end
			end)--timer end
		end
	end)
	
	-- Checks the player's upgrade everytime they respawn on a playable team
	hook.Add("PlayerSpawn", "CheckHPUpgrade", function(ply)
		if ply:Team() < 5 and ply:Team() > 0 then
			if ply:GetUpgrade("health_base") > 0 then
				HPFormula(ply)
			end
		end
	end)
	
	-- Called by hook at bottom to preform upgrades
	-- args: See REQUIRED below for values
	local function DoHealthUpgrade(args)
		
		if args[1] == myupgrade.name then
		
			local ply = args[4]
			
			-- PLY Upgrade
			if !args[3] then
			
				-- Use this to determine if purchase was successful
				local success = false
			
				-- If the round was reset, reset all players.
				if args[2] == "reset" then
					ply:ResetUpgrades()
				end
				
				if args[2] == "upgrade" then
				
					local mylevel = ply:GetUpgrade(args[1])
					
					if mylevel < 10 then
						local cost = myupgrade["cost"][mylevel + 1]
						if cost <= ply:GetPoints() then
							ply:SetPoints(ply:GetPoints() - cost)
							ply:SetUpgrade(args[1], mylevel + 1)
							success = true
						else
							print("(DEBUG) Insufficient points for upgrade... ["..ply:GetPoints()..", need "..cost.."]")
						end
					else
						print("(DEBUG) Level already maximized!")
					end
				end
				
				-- If flag is true then the upgrade/downgrade/reset was successful.
				if success then
					HPFormula(ply)
				end
				
			-- NPC Upgrade
			else
				local pts = GetGlobalInt("WP_T"..ply:Team().."Points")
                print(pts)
				local tlevel = myupgrade["level"][ply:Team()]
				local cost = myupgrade["cost"][tlevel + 1]
				if myupgrade["level"][ply:Team()] < 10 then
					if cost <= pts then
						myupgrade["level"][ply:Team()] = tlevel + 1
                        SetGlobalInt("WP_T"..ply:Team().."Points", pts - cost)
						print("(DEBUG) Team upgrade level for health_base increased to "..myupgrade["level"][ply:Team()]..".")
					else
						print("(DEBUG) Not enough team points for NPC upgrade..")
					end
				else
					print("(DEBUG) Team upgrade level is already maximum.")
				end
				
			end
		end
		
	end
	
	-- Called everytime an upgrade is purchased
	hook.Add("DoUpgrade", "DoHPUpgrade", DoHealthUpgrade)

end






