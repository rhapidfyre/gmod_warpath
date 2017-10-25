print("OPEN!!!!!!!!!!!!!!!!")
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

myupgrade.playerlist = {}

-- Called by hook at bottom to add to global table
local function AddToGame()
	table.insert(ups, myupgrade)
end

local function HPFormula(ply)
	local mylevel 	= myupgrade.playerlist[ply:SteamID64()]
	local hpMax 	= ply:GetMaxHealth()
	local hpMod 	= ply:GetMaxHealth() * myupgrade.increase[mylevel]
	-- Sets the new max health for player
	ply:SetMaxHealth(hpMax + hpMod)
	print(ply:GetMaxHealth())
end

local function CheckHPUpgrade(ply)
	if ply:Team() < 5 and ply:Team() > 0 then
		HPFormula(ply)
	end
end

-- Called by hook at bottom to preform upgrades
-- args: See REQUIRED below for values
local function MyUpgradeFunction(args)
	if SERVER then
	
		if args[1] == "health_base" then
		
			local ply = args[3]
		
			-- Use this to determine if purchase was successful
			local flag = false
		
			-- If the round was reset, reset all players.
			if args[2] == "reset" then
				table.Empty(myupgrade.playerlist)
			end
			
			if args[2] == "upgrade" then
			
				local mylevel = myupgrade.playerlist[ply:SteamID64()]
				local plyinfo = {}
				
				if !IsValid(mylevel) or mylevel == nil then
					plyinfo[ply:SteamID64()] = 0					
				end
				
				local plylevel = plyinfo[ply:SteamID64()]
				if plylevel < 10 then
					local cost = myupgrade["cost"][plylevel + 1]
					if cost <= ply:GetPoints() then
						ply:SetPoint(ply:GetPoints() - cost)
						plyinfo[ply:SteamID64()] = plylevel + 1
						flag = true
					end
				end
			end
			
			-- If flag is true then the upgrade/downgrade/reset was successful.
			if flag then
				HPFormula(ply)
			end
			
		end
	
	end
end

-------------------------------------------------------------
------------------- REQUIRED --------------------------------
-------------------------------------------------------------
--[[

 This will be called every time an upgrade is purchased.
	VARARG[1] = upgrade name (myupgrade.name)
	
	VARARG[2] =
		"upgrade"	= Player is purchasing upgrade
		"reset"		= Round is over and upgrades are being reset (don't do anything if you don't want it to reset)
		"downgrade" = Player is refunding the upgrade
		
	VARARG[3] = Entity Player
	
]]
hook.Add("CheckUpgrade", MyUpgradeFunction, vararg)
net.Receive("CL_PLYUpgrade", function(len, ply)
	print("HI!!!!!!!!!!!!!!!!!")
	local uptype = net.ReadString()
	local action = net.ReadString()
	local temptbl = {}
	temptbl[1] = uptype
	temptbl[2] = action
	temptbl[3] = ply
	MyUpgradeFunction(temptbl)
end)
hook.Add("PostGamemodeLoaded", "AddUpgrade", AddToGame)
-------------------------------------------------------------
hook.Add("PlayerSpawn", "CheckHPUpgrade", CheckUpgrade)








