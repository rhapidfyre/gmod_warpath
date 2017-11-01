----------------------------------
---------- MIN. REQUIRED ---------
----------------------------------
local myupgrade = {}
myupgrade.name 		= "health_base" -- Short name, used for upgrade detection/code purposes, keep short and in coding convention
myupgrade.title		= "Health Upgrade"
myupgrade.desc		= "Increase to Max Hit Points" -- Should be in the form of an improper sentence
myupgrade.longdesc  = "Buying a level of this upgrade will increase the amount of health you have by the percentage bonus of your current level." -- Proper grammar/punctuation, as long as you want.

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

-- Declares what percentage increase health gives
-- KEY: Current level
-- VAL: Percentage increase
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


-- Adds the table info to the gamemode
hook.Add("PostGamemodeLoaded", "AddUpgrade", function()
	table.insert(ups, myupgrade)
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
		
			if args[1] == "health_base" then
			
				local ply = args[4]
			
				-- Use this to determine if purchase was successful
				local flag = false
			
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
							flag = true
						else
							print("(DEBUG) Insufficient points for upgrade... ["..ply:GetPoints()..", need "..cost.."]")
						end
					else
						print("(DEBUG) Level already maximized!")
					end
				end
				
				-- If flag is true then the upgrade/downgrade/reset was successful.
				if flag then
					HPFormula(ply)
				end
				
			end
		
	end
	
	-- Called everytime an upgrade is purchased
	hook.Add("DoUpgrade", "DoHPUpgrade", DoHealthUpgrade)

end






