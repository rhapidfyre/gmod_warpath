
--
--
--
function SpawnpointChange()

    -- Void for now

end

--
-- Hostility()
--
-- Loops through each NPC for each NPC, and builds a hate list based on team
--
function Hostility(npc, npcTeam)
    if npc:Team() ~= 5 and npc:Team() ~= 0 then
        for _,ply in pairs (player.GetAll()) do
        
            if ply:Team() == npcTeam then
                npc:AddEntityRelationship(ply, D_LI, 99)
            
            else
                npc:AddEntityRelationship(ply, D_HT, 99)
                
            end
        
        end
    end
end

function HostilityPly(pl)
    if IsValid(pl) then
        local plTeam = pl:Team()
        for _,npc in pairs (ents.FindByClass("npc_combine_s")) do
            if IsValid(npc) then
                if npc:Team() == plTeam then
                    npc:AddEntityRelationship(pl, D_LI, 99)
                
                else
                    npc:AddEntityRelationship(pl, D_HT, 99)
                    
                end
            end
        end
    end
end

--
-- AssaultPoint()
--
-- Tells NPCs to attack the nearest control point if they're not in combat
--
local combat = {
    SCHED_CHASE_ENEMY,
    SCHED_CHASE_ENEMY_FAILED,
    SCHED_COMBAT_FACE,
    SCHED_COMBAT_PATROL,
    SCHED_COMBAT_STAND,
    SCHED_COMBAT_SWEEP,
    SCHED_COMBAT_WALK,
    SCHED_COWER,
    SCHED_ESTABLISH_LINE_OF_FIRE,
    SCHED_ESTABLISH_LINE_OF_FIRE_FALLBACK,
    SCHED_FAIL_ESTABLISH_LINE_OF_FIRE,
    SCHED_HIDE_AND_RELOAD,
    SCHED_INVESTIGATE_SOUND,
    SCHED_INTERACTION_MOVE_TO_PARTNER,
    SCHED_INTERACTION_WAIT_FOR_PARTNER,
    SCHED_MELEE_ATTACK1,
    SCHED_MELEE_ATTACK2,
    SCHED_MOVE_AWAY,
    SCHED_MOVE_AWAY_END,
    SCHED_MOVE_AWAY_FAIL,
    SCHED_MOVE_AWAY_FROM_ENEMY,
    SCHED_MOVE_TO_WEAPON_RANGE,
    SCHED_RANGE_ATTACK1,
    SCHED_RANGE_ATTACK2,
    SCHED_RELOAD,
    SCHED_RUN_FROM_ENEMY,
    SCHED_RUN_FROM_ENEMY_FALLBACK,
    SCHED_RUN_FROM_ENEMY_MOB,
    SCHED_RUN_RANDOM,
    SCHED_SHOOT_ENEMY_COVER,
    SCHED_SMALL_FLINCH,
    SCHED_SPECIAL_ATTACK1,
    SCHED_SPECIAL_ATTACK2,
    SCHED_STANDOFF,
    SCHED_SWITCH_TO_PENDING_WEAPON,
    SCHED_TAKE_COVER_FROM_BEST_SOUND,
    SCHED_TAKE_COVER_FROM_ENEMY,
    SCHED_TAKE_COVER_FROM_ORIGIN,
    SCHED_TARGET_CHASE,
    SCHED_TARGET_FACE,
    SCHED_WAKE_ANGRY
}

local function CombatSchedules(npc)
    for s,_ in pairs (combat) do
        if npc:IsCurrentSchedule(combat[s]) then
            return true
        end
    end
    return false
end

function AssaultPoint(npc)
    if IsValid(npc) and npc ~= nil then
        if npc:Team() < 3 and npc:Team() > 0 then
            if !(CombatSchedules(npc)) then
                
                /*
                -- Sends NPCs to the nearest control point that they don't control
                local flag = false
                local minimum = nil
                for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
                
                    if zone:GetKeyValues()["TeamNum"] ~= npc:Team() then
                    
                        if minimum == nil then minimum = zone end
                        
                        local dist = npc:GetPos():Distance(zone:GetPos())
                        if (dist < npc:GetPos():Distance(minimum:GetPos())) then
                            minimum = zone;
                        end
                        
                        flag = true
                        
                    end
                end
                */
                -- Sends NPCs to a random control points that they don't control
                local flag = false
                local minimum = {}
                
                for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
                    if zone:GetKeyValues()["TeamNum"] ~= npc:Team() then
                    
                        table.insert(minimum, zone:GetPos())
                        flag = true
                        
                    end
                end
                
                if flag then
                
                    local speed = { SCHED_FORCED_GO, SCHED_FORCED_GO_RUN }
                    local setSpeed = table.Random(speed)
                    local vect = table.Random(minimum)
                    
                    if npc:GetNWBool("HasGoal") then
                        npc:SetSaveValue("m_VecLastPosition", npc:GetNWVector("GoalVector"))
                        npc:SetSchedule(npc:GetNWString("GoalSpeed"))
                    else
                        npc:SetSaveValue("m_VecLastPosition", table.Random(minimum)/*minimum:GetPos()*/)
                        npc:SetSchedule(setSpeed)
                    end
                    
                    npc:SetNWBool("HasGoal", true)
                    npc:SetNWString("GoalSpeed", setSpeed)
                    npc:SetNWVector("GoalVector", vect)
                    
                else
                    npc:Fire("StartPatrolling")
                end
                
            end
        end
    end
end

-- DEBUG : Find a better way to implement this
timer.Create("SendAll", 6, 0, function()
    for _,npc in pairs (ents.FindByClass("npc_*")) do
        if IsValid(npc) then
            if !(npc:IsCurrentSchedule(SCHED_FORCED_GO)) and !(npc:IsCurrentSchedule(SCHED_FORCED_GO_RUN)) then
                AssaultPoint(npc)
            end
        end
    end
end)