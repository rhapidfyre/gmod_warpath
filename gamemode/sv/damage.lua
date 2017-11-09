
-- Redirect takes NPCs who are NOT in combat, and makes them ENGAGE TARGETS
local function Redirect(npc)
    if (npc:IsCurrentSchedule(SCHED_FORCED_GO)) or (npc:IsCurrentSchedule(SCHED_FORCED_GO_RUN)) then
        npc:SetSchedule(SCHED_ALERT_FACE)
    end
end

--[[---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( ent, info )
   Desc: The entity has received damage
-----------------------------------------------------------]]
local function HealDamage(info, victim)
	local dmg = info:GetDamage()
	print(dmg*.1)
		info:SetDamage(0)
	if victim:Health() < victim:GetMaxHealth() then 
		if ((victim:Health()+dmg*.1)>victim:GetMaxHealth()) then
			victim:SetHealth( victim:Health()+(dmg*.1))
		else
			victim:SetHealth(victim:GetMaxHealth())
	
		end
	else
		victim:SetHealth(victim:GetMaxHealth())
	end
	print ("Player now has "..victim:Health().." Health!") 

end

function GM:EntityTakeDamage( ent, info )

    if info:GetDamageType() == DMG_CLUB then
        info:SetDamage(10)
    end

    if ent:IsNPC() then
        if info:GetAttacker():IsPlayer() && info:GetAttacker():GetHasHealGun() then
            if (ent:GetWarTeam() == info:GetAttacker():Team()) then
				HealDamage(info, ent)
					Redirect(ent)
			else
				Redirect(ent)
			end
		else
			Redirect(ent)
		end
    else
	--[[if ent:IsPlayer() then
		local atk = info:GetAttacker()
		
		if atk:IsPlayer() then
			if (ent:Team() == atk:Team()) then
				CalcDamage(info, ent)
			end
		elseif atk:IsNPC() then
			if (ent:Team() == atk:GetWarTeam()) then
				CalcDamage(info, ent)
			end
		end]]
     end
print(info:GetDamage())
end


	--[[
	-- Damage Upgrade Modifier
	if ent:IsNPC() or ent:IsPlayer() then

		local attacker = info:GetAttacker()
		if IsValid(attacker) then
			if attacker:IsNPC() then
					
				if attacker:GetWarTeam() > 0 and attacker:GetWarTeam() < 5 then
					local teamnum = attacker:GetWarTeam()
					local level = upgrades[teamnum]["damage"]
					info:ScaleDamage(upgrade_info["perc"][level])
				end
					
			elseif attacker:IsPlayer() then
			
					local teamnum = attacker:Team()
					local level = upgrades[teamnum]["damage"]
					info:ScaleDamage(upgrade_info["perc"][level])
					
			end
		end
	
	end	
	
	]]