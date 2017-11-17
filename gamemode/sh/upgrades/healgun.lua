





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
myupgrade.name 		= "revenge" -- Must be in coding convention. Used for gamemode purposes.
myupgrade.title		= "Death Revenge" -- Title for the player's menu
myupgrade.desc		= "Stuff" -- Should be short, to the point.

-- Can be as long as you want. Full description of upgrade.
myupgrade.longdesc  = "Buying a level of this upgrade will increase the amount of health you have by the percentage bonus of your current level." 

-- Declares the base point cost for each upgrade level
-- KEY: The level for the player's request
-- VAL: Points required to purchase corresponding key level
myupgrade["cost"] = {}
myupgrade["cost"][1] 	= 1


-- Declares what percentage increase health gives
-- KEY: Player's current level
-- VAL: Value to add (in this case, HP to add per level)
myupgrade["increase"] = {}
myupgrade["increase"][0]  = false
myupgrade["increase"][1]  = true


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

	local function SetHasRevenge (ply, bool)
		ply:SetUpgrade(myupgrade.name, bool)
	end

	local function GetHasRevenge(ply)
		return ply:GetUpgrade(myupgrade.name)
	end

	-- ADD YOUR FUNCTIONS HERE
	local function RevengeUpgrade(args)
		if args[1] == myupgrade.name then
			local ply 		= args[4]
			local mylevel 	= ply:GetUpgrade(args[1])
			
			if args[2] == "reset" then
				-- set ply:upgr(myupgr.name) to 0
			end
			
			if !args[3] and mylevel == 0 then
				local points = ply:GetPoints()
				local cost = myupgrade["cost"][1]
				if points >= cost then
					ply:SetPoints(ply:GetPoints()-cost)
					SetHasRevenge(ply,1)
					
				end
			end
		end
	end
		

local function DeathRevenge(ply, inf, atk)
  if ply:LastHitGroup() != HITGROUP_HEAD && GetHasRevenge(ply) then
		timer.Simple(1,function()
		local effectdata = EffectData()
		effectdata:SetEntity(ply)
		effectdata:SetOrigin(ply:GetPos())	

		util.Effect("Explosion", effectdata)
		util.BlastDamage(ply, ply, ply:GetPos(), 200, 200)
		
		end)--timer
	end
end
	
hook.Add("PlayerDeath", "DoHPUpgrade", DeathRevenge)
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
	hook.Add("DoUpgrade", "GiveRevenge", RevengeUpgrade)
end






