
points = {}
points[1] = 5
points[2] = 5
points[3] = 5
points[4] = 5

local round 		= {}
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

    print("[DEBUG] [RoundControl] Beginning preparation round...")
	-- Round Controller
	round.status 	    = ROUND_PREP
	round.timeleft 	    = TIME_PREP
    round.in_progress   = false

	-- Reset Map
	game.CleanUpMap(false)
	
	-- Reset Upgrades
	
    timer.Simple(1, function()
        for _,ply in pairs (player.GetAll()) do
            -- Respawn
            if IsPlaying(ply) then ply:Spawn() end
            
            -- Weapon Strip 
            
            -- Disperse Weaponry
            
        end
    end)
	
	-- Disable Control Point Capturing & Build HUD Info
	for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
		zone:Input("DisableCapture")
        if      zone:GetName() == "CAP_POINT_1" then SetGlobalInt("CmdPoint1", zone:GetKeyValues()["TeamNum"])
        elseif  zone:GetName() == "CAP_POINT_2" then SetGlobalInt("CmdPoint2", zone:GetKeyValues()["TeamNum"])
        elseif  zone:GetName() == "CAP_POINT_3" then SetGlobalInt("CmdPoint3", zone:GetKeyValues()["TeamNum"])
        elseif  zone:GetName() == "CAP_POINT_4" then SetGlobalInt("CmdPoint4", zone:GetKeyValues()["TeamNum"])
        else                                         SetGlobalInt("CmdPoint5", zone:GetKeyValues()["TeamNum"])
        end
	end
    
    --SetGlobalString("CmdPoints", util.TableToJSON(points))
    
	
end

--[[
	round.Begin()
	Respawns all dead players and begins the round
	Sends input to [war_capture_zone] to re-enable control point capturing
]]
function round.Begin()

    print("[DEBUG] [RoundControl] Control Points unlocked. The round has begun!")
	-- Round Controller
	round.status 	    = ROUND_ACTIVE
	round.timeleft	    = TIME_ROUND
    round.in_progress   = true
	
	-- Enable Control Point Capturing
	for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
		zone:Input("EnableCapture")
	end
	
    -- Resets Upgrades to Level 1 & points to POINTS_START(variables.lua)
    for i = 1, 4, 1 do
        upgrades[i]["points"]   = POINT_START
        upgrades[i]["health"]   = 1
        upgrades[i]["damage"]   = 1
        upgrades[i]["accuracy"] = 1
        upgrades[i]["speed"]    = 1
    end
    
end

--[[
	round.End()
	Terminates the active round, disables spawning.
	Sends input to [war_capture_zone] to disable control point capturing
]]
function round.End()

    print("[DEBUG] [RoundControl] The round has ended.")
	-- Round Controller
	round.status 	    = ROUND_END
	round.timeleft 	    = TIME_END
    round.in_progress   = false

	-- Disable Player Spawning

	-- Disable Capturing
	for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
		zone:Input("DisableCapture")
	end
	
	-- Announce Winners
	
	-- Check if game is complete
	if (MAX_TIME < CurTime() or MAX_ROUNDS > round.count) and !(FOREVER_GAME) then
		
		-- Stop the round controller
		timer.Remove("RoundControl")
		
		-- Call a map vote
		hook.Call("WAR_MapVote")
		
	end
    
    -- Check for Victors
	
end

--[[
	round.Victory()
	Awards the winning team points then calls round.End()
]]
function round.Victory(winteam)

    PrintMessage(HUD_PRINTTALK, team.GetName().." has won round #"..round.count.."!")
    
    -- Distributes points (variables.lua)
    for k,v in pairs(player.GetAll()) do
        if v:Team() == winteam then team.SetScore(v, team.GetScore(v) + SCORE_WIN)
        else                        team.SetScore(v, team.GetScore(v) + SCORE_LOSE)
        end
    end
    
    round.End()
    
end

--[[
	round.Stale()
	Disables the round controller if no players are on playable teams
]]
function round.Stale()

	if timer.Exists("RoundControl") then timer.Remove("RoundControl") end
	if !timer.Exists("RoundStale")  then timer.Create("RoundStale", 1, 0, round.Stale) end
	
	round.timeleft = 0
	round.status = ROUND_STALE
	round.in_progress = false
	
	if CheckReady() then
        print("[DEBUG] [RoundControl] A player is waiting, the game will begin!")
		round.timeleft 	= TIME_PREP
		round.status 	= ROUND_PREP
		
		if  timer.Exists("RoundStale")      then timer.Remove("RoundStale") end
		if !timer.Exists("RoundControl")    then timer.Create("RoundControl", 1, 0, round.Controller) end
        
	else
        print("[DEBUG] [RoundControl] Game Stale - No Players Waiting!")
        
	end

end

--[[
	round.Controller()
	Controls timeleft and round status
]]
function round.Controller()
	
    
	-- If time expires change round status
	if round.timeleft <= 0 then
	
		if 		round.status == ROUND_STALE then	--Do Nothing
		elseif 	round.status == ROUND_END 	then 	round.Prep()
		elseif 	round.status == ROUND_PREP 	then 	round.Begin()
		else 										round.End()
		end
	
	end
    
    if !CheckReady() then
        round.Stale()
    end
	
	round.clock() -- Should this go at the top of the function? Test it. [DEBUG]
    round.timeleft = round.timeleft - 1
	
end

timer.Create("RoundControl", 1, 0, round.Controller)

--[[
	round.Clock()
	Sends the timeleft counter to clients
]]
function round.clock()
	
    print("[DEBUG] [TimeLeft] Time remaining (in seconds): "..tostring(round.timeleft))
	-- Never allow a round time to exceed 10 minutes
	if round.timeleft > 600 then round.timeleft = 600 end
	
	-- Send clients the current time
	net.Start("SV_Clock")
		net.WriteInt(round.timeleft, 12)
        net.WriteInt(round.status, 8)
		net.Broadcast()
    SetGlobalInt("RoundTimeLeft", round.timeleft)
    SetGlobalInt("RoundStatus", round.status)
end

function RoundActive()
    return round.in_progress
end

timer.Create("AwardPoints", 1, 0, function()

    if round.status = ROUND_ACTIVE then
    
        if ((CurTime() % 30) == 0) then
        
            for k,v in pairs(ents.FindByClass("war_capture_zone")) do
            
                local temp = v:GetKeyValues()["TeamNum"]
                upgrades[temp]["points"] = upgrades[temp]["points"] + POINT_TIME
            
            end
        
        end
    
    end

end)























