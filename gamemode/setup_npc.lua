
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
function Hostility()

    for _,npc in pairs (ents.FindByClass("npc_*")) do
        for _,ent in pairs (ents.FindByClass("npc_*")) do
            if npc ~= ent then
                
                print("[DEBUG] Checking "..tostring(npc).." (TEAM "..tostring(npc:GetWarTeam())..") against "..tostring(ent).." (TEAM "..tostring(ent:GetWarTeam())..")")
                
                if (npc:GetWarTeam() == ent:GetWarTeam()) then
                    npc:AddEntityRelationship(ent, D_LI, 99)
                    print("[DEBUG] Relationship: [FRIENDLY]")
                    
                else
                    npc:AddEntityRelationship(ent, D_HT, 99)
                    print("[DEBUG] Relationship: [HOSTILE]")
                    
                end
            end
        end
        
        for _,ply in pairs (player.GetAll()) do
        
            MsgC(Color(255,255,255), "[DEBUG] Checking "..tostring(npc).." against "..tostring(ply))
            if npc:GetWarTeam() == ply:Team() then
                npc:AddEntityRelationship(ply, D_LI, 99)
                MsgC(Color(80,255,80), " [FRIENDLY]\n")
            
            else
                npc:AddEntityRelationship(ply, D_HT, 99)
                MsgC(Color(255,80,80), " [ENEMY]\n")
                
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
        if npc:GetWarTeam() ~= 5 then
            if !(CombatSchedules(npc)) then
            
                local flag = false
                local minimum = nil
                local move_to
                for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
                
                    if zone:GetKeyValues()["TeamNum"] ~= npc:GetWarTeam() then
                    
                        if minimum == nil then minimum = zone end
                        
                        local dist = npc:GetPos():Distance(zone:GetPos())
                        if (dist < npc:GetPos():Distance(minimum:GetPos())) then
                            minimum = zone;
                        end
                        
                        flag = true
                        
                    end
                end
                
                if flag then
                    
                    --local speed = { SCHED_FORCED_GO, SCHED_FORCED_GO_RUN }
                    npc:SetSaveValue("m_VecLastPosition", minimum:GetPos())
                    npc:SetSchedule(SCHED_FORCED_GO_RUN /*table.Random(speed)*/)
                    
                    
                else
                    npc:Fire("StartPatrolling")
                    
                end
            end
        end
    end
end