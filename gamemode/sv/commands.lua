
--[[
ADMIN COMMANDS:
    -- Toggle Indicators
    -- Force Win
    -- Force Capture Point Change
    -- Reset Round
    -- Force Team Change
    -- Run Team Balance
    -- Kill All NPCs (args: If no team provided, kill all)
    -- Kill All Players (args: No team = All)
    -- Print Entity Information (Cap Points, Spawners)
]]

--Forces supplied player to given team #
concommand.Add("war_indicator", function(ply, cmd, args)
end)

-- Immediately ends the round and awards victory to given team
concommand.Add("war_forcewin", function(ply, cmd, args)
end)

-- Immediately changes the capture point as if an NPC touched it
concommand.Add("war_change_cappoint", function(ply, cmd, args)
end)

-- Immediately ends the round and goes into cooldown phase
concommand.Add("war_resetround", function(ply, cmd, args)
end)

-- Allows the admin to set any player to any team
-- Is not immune to the auto balancer
concommand.Add("war_setteam", function(ply, cmd, args)
end)

-- Forces the autobalancer to run immediately.
-- Living players who are chosen WILL be killed and notified.
concommand.Add("war_balance", function(ply, cmd, args)
	-- Run balancer
	-- Slay player
	-- Award -1 death and 1 frag to make up for the suicide
end)

--[[
	Kills all players/NPCs who are not already dead
]]
concommand.Add("war_killnpc", function(ply, cmd, args)
	-- CAREFUL! Killing NPCs MUST run the input that reduces the self.maxmobs of the spawner entity!!
	MsgAll(Color(200,80,80), "Admin "..ply:GetName().." has slain all living NPCs!")
end)

concommand.Add("war_killply", function(ply, cmd, args)
	MsgAll(Color(200,80,80), "Admin "..ply:GetName().." has slain all living players!")
end)

--[[
	Prints the spawner / command point info to the console
	This will only show command point info once the game goes live
]]
concommand.Add("war_info", function(ply, cmd, args)
	ply:PrintMessage(HUD_PRINTCONSOLE, "~~~~~~~~~~~~~~~~~~~~NPC SPAWNERS~~~~~~~~~~~~~~~~~~~~~~~")
	for k,v in pairs(ents.FindByClass("war_npcspawner")) do
		ply:PrintMessage(HUD_PRINTCONSOLE, "Spawner ID #"..v:GetName().." @ "..v:GetPos())
		ply:PrintMessage(HUD_PRINTCONSOLE, "Team #"..team.GetName(v:GetKeyValues()["TeamNum"]))
	end
	ply:PrintMessage(HUD_PRINTCONSOLE, "~~~~~~~~~~~~~~~~~~~~PLY SPAWNERS~~~~~~~~~~~~~~~~~~~~~~~")
	for k,v in pairs(ents.FindByClass("war_spawner")) do
		ply:PrintMessage(HUD_PRINTCONSOLE, "Spawner ID #"..v:GetName().." @ "..v:GetPos())
		ply:PrintMessage(HUD_PRINTCONSOLE, "Team #"..team.GetName(v:GetKeyValues()["TeamNum"]))
	end
	ply:PrintMessage(HUD_PRINTCONSOLE, "~~~~~~~~~~~~~~~~~~~CAPTURE POINTS~~~~~~~~~~~~~~~~~~~~~~")
	for k,v in pairs(ents.FindByClass("war_npcspawner")) do
		ply:PrintMessage(HUD_PRINTCONSOLE, "Capture Point ["..v:GetName().."] @ "..v:GetPos())
		ply:PrintMessage(HUD_PRINTCONSOLE, "Team #"..team.GetName(v:GetKeyValues()["TeamNum"]))
	end
	ply:PrintMessage(HUD_PRINTCONSOLE, "~~~~~~~~~~~~~~~~~~~~~~~~END~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
end)

