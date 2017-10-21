
--[[---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( ent, info )
   Desc: The entity has received damage
-----------------------------------------------------------]]
function GM:EntityTakeDamage( ent, info )

    if info:GetDamageType() == DMG_CLUB then
        info:SetDamage(10)
    end

    if ent:IsNPC() then
        if (ent:IsCurrentSchedule(SCHED_FORCED_GO)) or (ent:IsCurrentSchedule(SCHED_FORCED_GO_RUN)) then
            ent:SetSchedule(SCHED_ALERT_FACE)
        end
    end
end