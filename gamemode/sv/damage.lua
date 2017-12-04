
-- Redirect takes NPCs who are NOT in combat, and makes them ENGAGE TARGETS
function Redirect(npc)
	if npc:IsNPC() then
		if (npc:IsCurrentSchedule(SCHED_FORCED_GO)) or (npc:IsCurrentSchedule(SCHED_FORCED_GO_RUN)) then
			npc:SetSchedule(SCHED_ALERT_FACE)
		end
	end
end

--[[---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( ent, info )
   Desc: The entity has received damage
-----------------------------------------------------------]]


function GM:EntityTakeDamage( ent, info )

    if info:GetDamageType() == DMG_CLUB then
        info:SetDamage(10)
    end

	if info:GetAttacker():IsNPC() && info:GetAttacker():Team() == 5 then
		info:ScaleDamage(2.25)
	end
	

end