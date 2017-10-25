
--[[
	Do not change anything in this file!
	
	This is used to setup upgrade counts
	for the formulas to use in other Lua files.
]]

net.Receive("CL_NPCUpgrade", function(len, ply)

end)
net.Receive("CL_PLYUpgrade", function(len, ply)

end)

local function NPCWeaponUp(ply, weaponname)

	local teamnum = ply:Team()
	local pts     = upgrades[teamnum]["points"]
	local cost    = weapon_cost["NPC"][weaponname]
	
	if cost <= pts then
		upweapons[teamnum][weaponname] = true
		upgrades[teamnum]["points"] = pts - cost
	end

end

local function NPCUpgrading(ply, upgrade)

    local teamnum = ply:Team()
    
    -- Assigns current point count to "pts"
    local pts = upgrades[teamnum]["points"]
    
    -- Retrieves current upgrade level to "curr"
    local curr = upgrades[teamnum][upgrade]
    
    -- Assigns cost of next upgrade level to "cost"
    local cost = upgrade_cost[upgrade][curr]

    if cost <= pts then
    
		if curr < 10 then
	
			upgrades[teamnum][upgrade] = curr + 1
			net.Start("SV_UpgradeSuccess")
				net.Send(ply)
				
		else
			net.Start("SV_UpgradeFail")
				net.WriteString("This ability is already maximized!!")
				net.Send(ply)
				
		end
			
			-- Subtract the cost from the team's points pool
        upgrades[teamnum]["points"] = pts - cost
        
    else
        net.Start("SV_UpgradeFail")
            net.WriteString("Your team does not have enough points for that upgrade!!")
            net.Send(ply)
            
    end
    
end

-- Runs NPCUpgrading
net.Receive("CL_NPCUpgrade", function(len, ply)
	local upgrade = net.ReadString()
	if upgrade == "weapon" then
		local wpn = net.ReadString()
		NPCWeaponUp(ply, wpn)
	else
		NPCUpgrading(ply, net.ReadString())
	end
end)