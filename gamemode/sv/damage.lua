
--[[---------------------------------------------------------
   Name: gamemode:EntityTakeDamage( ent, info )
   Desc: The entity has received damage
-----------------------------------------------------------]]
local function Redirect(npc)
    if (npc:IsCurrentSchedule(SCHED_FORCED_GO)) or (npc:IsCurrentSchedule(SCHED_FORCED_GO_RUN)) then
        npc:SetSchedule(SCHED_ALERT_FACE)
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
                Redirect(ent)
            end
        else
            Redirect(ent)
        end
    end
end