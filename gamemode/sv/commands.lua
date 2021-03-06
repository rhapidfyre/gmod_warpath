
function GM:ShowHelp(ply)
    ply:ConCommand("war_helpsettings")
end

function GM:ShowSpare1(ply)
    ply:ConCommand("war_modelselect")
end

function GM:ShowSpare2(ply)
	ply:ConCommand("war_npcupgrades")
end

--Forces supplied player to given team #
concommand.Add("war_admin_setteam", function(ply, cmd, args)
end)
concommand.Add("abcid", function(ply, cmd, args)
print(ply:SteamID64())
end)
concommand.Add("debug_setpoints", function(ply, cmd, args)
    ply:SetPoints(args[1])
    print(ply:GetPoints())
end)

-- Sets given control point to given team #
concommand.Add("war_admin_setcontrol", function(ply, cmd, args)
end)

-- Kills all NPCs
concommand.Add("war_admin_killnpc", function(ply, cmd, args)
end)

-- Kills all Players
concommand.Add("war_admin_killall", function(ply, cmd, args)
end)

-- Forces given team # to win
-- If no team given, game acts as if time expired
concommand.Add("war_admin_force", function(ply, cmd, args)
end)

concommand.Add("war_setteam", function(ply, cmd, args)
    ply:SetTeam(args[1])
    print("[DEBUG] [ADMIN COMMAND] Setting you to team #"..tostring(ply:Team()))
    
end)

concommand.Add("war_printspawns", function(ply, cmd, args)
    print("\n")
    for _,spawn in pairs (ents.FindByClass("war_spawnpoint")) do
        print("targetname =    "..tostring(spawn:GetName()))
        PrintTable(spawn:GetKeyValues())
        print("\n")
    end
end)
--[[
concommand.Add("war_showteamcolor", function(ply, cmd, args)
	ShowTeamColor = args[1]
end)
]]