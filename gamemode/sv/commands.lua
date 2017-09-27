
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
