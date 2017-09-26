
local round 		= {}
round.timeleft 		= -1
round.status		= ROUND_END
round.in_progress	= false
round.count			= 0

--[[
	CheckReady()
	Returns true if any players are on a playable team and ready to play
]]
local function CheckReady()

	local flag = false
	
	for _,pl in pairs (players.GetAll()) do
		if ply:Team() > 0 and ply:Team() < 5 then
			flag = true
		end
	end
	
	return flag
	
end

--[[
	round.Prep()
	Terminates the intermission round and respawns all the players
	Sends input to [war_capture_zone] to disable control point capturing
]]
local function round.Prep()

	-- Round Controller
	round.status 	== ROUND_PREP
	round.timeleft 	== TIME_PREP

	-- Reset Map
	game.CleanUpMap(false)
	
	-- Reset Upgrades
	
	-- Weapon Strip Players and Dispurse Default Weaponry
	
	-- Respawn Players
	
	-- Disable Control Point Capturing
	for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
		zone:Input("DisableCapture")
	end
	
end

--[[
	round.Begin()
	Respawns all dead players and begins the round
	Sends input to [war_capture_zone] to re-enable control point capturing
]]
local function round.Begin()

	-- Round Controller
	round.status 	== ROUND_ACTIVE
	round.timeleft	== TIME_ROUND

	-- Respawn dead players that are on a playable teams
	
	-- Enable Control Point Capturing
	for _,zone in pairs (ents.FindByClass("war_capture_zone")) do
		zone:Input("EnableCapture")
	end
	
end

--[[
	round.End()
	Terminates the active round, disables spawning.
	Sends input to [war_capture_zone] to disable control point capturing
]]
local function round.End()

	-- Round Controller
	round.status 	== ROUND_END
	round.timelfet 	== TIME_END

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
	
end

--[[
	round.Stale()
	Disables the round controller if no players are on playable teams
]]
local function round.Stale()

	if timer.Exists("RoundControl") then timer.Remove("RoundControl") end
	if !timer.Exists("RoundStale")  then timer.Create("RoundStale", 1, 0, round.Stale) end
	
	round.timeleft = 0
	round.status = ROUND_STALE
	round.in_progress = false
	
	if CheckReady() then
		
		round.timeleft 	= TIME_PREP
		round.status 	= ROUND_PREP
		
		if timer.Exists("RoundStale") then timer.Remove("RoundControl") end
		if !timer.Exists("RoundSContr")  then timer.Create("RoundStale", 1, 0, round.Stale) end
	
	end

end

--[[
	round.Controller()
	Controls timeleft and round status
]]
local function round.Controller()
	
	-- If time expires change round status
	if round.timeleft <= 0 then
	
		if 		round.status == ROUND_STALE then	--Do Nothing
		elseif 	round.status == ROUND_END 	then 	round.Prep()
		elseif 	round.status == ROUND_PREP 	then 	round.Begin()
		else 										round.End()
		end
	
	end
	
	round.clock() -- Should this go at the top of the function? Test it. [DEBUG]
	
end

timer.Create("RoundControl", 1, 0, round.Controller)

--[[
	round.Clock()
	Sends the timeleft counter to clients
]]
local function round.clock()
	
	-- Never allow a round time to exceed 10 minutes
	if round.timeleft > 600 then round.timeleft = 600 end
	
	-- Send clients the current time
	net.Start("SV_Clock")
		net.WriteInt(round.timeleft, 12)
		net.Broadcast()
		
end

























