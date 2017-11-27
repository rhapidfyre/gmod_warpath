
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
		if ((victim:Health()+dmg*.2)>victim:GetMaxHealth()) then
			victim:SetHealth( victim:Health()+(dmg*.2))
		else
			victim:SetHealth(victim:GetMaxHealth())
	
		end
	else
		victim:SetHealth(victim:GetMaxHealth())
	end
	print ("NPC now has "..victim:Health().." Health!") 

end

function GM:EntityTakeDamage( ent, info )

    if info:GetDamageType() == DMG_CLUB then
        info:SetDamage(10)
    end

	if info:GetAttacker():IsNPC() && info:GetAttacker():Team() == 0 then
		info:ScaleDamage(2.25)
	end
	
    if ent:IsNPC() then
        if info:GetAttacker():IsPlayer() && ent:Team() == info:GetAttacker():Team() then
				info:SetDamage(0)
				--HealDamage(info, ent)

					Redirect(ent)
		else
			--info:SetDamage(0)
			Redirect(ent)
		end
     end

end