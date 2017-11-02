
-- What does this variable do? (DEBUG)
points = {}
points[1] = 5
points[2] = 5
points[3] = 5
points[4] = 5

round 		        = {}
round.timeleft 		= -1
round.status		= ROUND_END
round.in_progress	= false
round.count			= 0

--[[
	round.Prep()
	Terminates the intermission round and respawns all the players
	Sends input to [war_capture_zone] to disable control point capturing
]]
function round.Prep()

	-- Round Controller
	round.status 	    = ROUND_PREP
    round.in_progress   = false

	-- Reset Map
	game.CleanUpMap(false)
	
    -- Resets Upgrades to Level 1 & points to POINT_START (variables.lua)
    for k,v in pairs(player.GetAll()) do
        v:SetPoints(0)
    end
	SetGlobalInt("WP_T1Points", POINT_START)
	SetGlobalInt("WP_T2Points", POINT_START)
	
    timer.Simple(1, function()
        for _,ply in pairs (player.GetAll()) do
		
            -- Respawn/Reset Players
            if IsPlaying(ply) then ply:Spawn() end
            
            -- Weapon Strip 
			ply:StripWeapons()
			ply:StripAmmo()
            
            -- Disperse Weaponry (Loadout)
            ply:Give("weapon_crowbar")
            ply:Give("war_pistol")
	    ply:GiveAmmo(90, "pistol", false)

	    ply:SetRunSpeed(ply:GetMaxSpeed())
			
            if ply:GetHasAR2()      then ply:Give("war_rifle") end
            if ply:GetHasShotty()   then ply:Give("weapon_shotgun") end
            if ply:GetHasBow()      then ply:Give("weapon_crossbow") end
            if ply:GetHasFrag()     then ply:Give("weapon_frag") end
            
            
        end
    end)
	
	-- Build HUD Info
	for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
        if      zone:GetName() == "CAP_POINT_1" then SetGlobalInt("CmdPoint1", zone:GetKeyValues()["TeamNum"])
        elseif  zone:GetName() == "CAP_POINT_2" then SetGlobalInt("CmdPoint2", zone:GetKeyValues()["TeamNum"])
        elseif  zone:GetName() == "CAP_POINT_3" then SetGlobalInt("CmdPoint3", zone:GetKeyValues()["TeamNum"])
        elseif  zone:GetName() == "CAP_POINT_4" then SetGlobalInt("CmdPoint4", zone:GetKeyValues()["TeamNum"])
        else                                         SetGlobalInt("CmdPoint5", zone:GetKeyValues()["TeamNum"])
        end
	end
    
	timer.Simple(TIME_PREP, round.Begin)
	
end

--[[
	round.Begin()
	Respawns all dead players and begins the round
]]
function round.Begin()

	-- Round Controller
	round.status 	    = ROUND_ACTIVE
    round.in_progress   = true
    round.count         = round.count + 1
	
end

--[[
	round.End()
	Terminates the active round, disables spawning.
	Sends input to [war_capture_zone] to disable control point capturing
]]
function round.End()

    -- If there's no players when this round ends, go stale.
    if !CheckReady() then round.Stale() end

	-- Round Controller
	round.status 	    = ROUND_END
    round.in_progress   = false
	timer.Simple(TIME_END, round.Prep)
	
end

--[[
	round.Victory()
	Awards the winning team points then calls round.End()
]]
function round.Victory(winteam)

    PrintMessage(HUD_PRINTTALK, team.GetName(winteam).." captured all command points!")
    
    -- Distributes points (variables.lua)
    for k,v in pairs(player.GetAll()) do
        if v:Team() == winteam then team.SetScore(v, team.GetScore(v) + SCORE_WIN)
        else                        team.SetScore(v, team.GetScore(v) + SCORE_LOSE)
        end
    end
    
    round.End()
    
end
hook.Add("RoundWin", round.Victory, winteam)

--[[
	round.Stale()
	Disables the round controller if no players are on playable teams
]]
function round.Stale()

	
	round.status = ROUND_STALE
	round.in_progress = false
	
	if CheckReady() then
    
        round.Prep()
		
        -- Remove the stale timer
		if timer.Exists("RoundStale") then timer.Remove("RoundStale") end
        
    else
    
        -- If nobody is ready, run this function every 3 seconds.
        if !timer.Exists("RoundStale")  then timer.Create("RoundStale", 3, 0, round.Stale) end
    
	end
    

end

function RoundActive()
    return round.in_progress
end

timer.Create("AwardPoints", POINT_DIST, 0, function()

    if round.status == ROUND_ACTIVE then
	
        for _,v in pairs(ents.FindByClass("war_capture_zone")) do
            local teamNum = v:GetKeyValues()["TeamNum"]
            if teamNum == 1 or teamNum == 2 then
			
				local pts = GetGlobalInt("WP_T"..teamNum.."Points")
                SetGlobalInt("WP_T"..teamNum.."Points", pts + POINT_TIME)
				team.SetScore(teamNum, team.GetScore(teamNum) + 1)
				
            end
        end
		
    end

end)

timer.Create("CheckEndGame", 30, 0, function()

	if (round.count >= MAX_ROUNDS) or (CurTime() >= MAX_TIME) then
	
		-- Show Scoreboard
		-- Voice Announcement
		
		-- 3 second delay
		-- Show map vote option
		
			-- If there is only one "war_" map detected, restart current map.
	
	end

end)

round.Stale()














