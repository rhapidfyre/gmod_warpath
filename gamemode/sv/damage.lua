
--[[---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( ent, info )
   Desc: The entity has received damage
-----------------------------------------------------------]]
local function Redirect(npc)
    if (ent:IsCurrentSchedule(SCHED_FORCED_GO)) or (ent:IsCurrentSchedule(SCHED_FORCED_GO_RUN)) then
        ent:SetSchedule(SCHED_ALERT_FACE)
    end
end

function GM:EntityTakeDamage( ent, info )

    if info:GetDamageType() == DMG_CLUB then
        info:SetDamage(10)
    end

    if ent:IsNPC() then
        if info:GetAttacker():IsPlayer() then
            if ent:GetWarTeam() == info:GetAttacker():Team() then
                info:SetDamage(0)
            else
                Redirect(npc)
            end
        else
            Redirect(npc)
        end
    end
end