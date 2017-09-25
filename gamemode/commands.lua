
concommand.Add("war_printlist", function(ply, cmd, args)

        MsgC(Color(255,255,255), "\n\n[DEBUG] ~~~~~~~~ START ~~~~~~~~\n")
        
    local tbl = ents.FindByClass("war_capture_zone")
    for _,zone in pairs (tbl) do
    
        MsgC(Color(255,80,80), "COMMAND POINT #")
        MsgC(Color(255,255,0), tostring(zone:GetName()))
        print(" is controlled by "..team.GetName(zone:GetKeyValues()["TeamNum"]))
        
    end
        MsgC(Color(255,255,255), "[DEBUG] ~~~~~~~~~ END ~~~~~~~~~\n")

end)
concommand.Add("war_setteam", function(ply, cmd, args)

    ply:SetTeam(args[1])
    print("[DEBUG] [ADMIN COMMAND] Set player "..tostring(ply).." to team #"..tostring(ply:Team()))
    
end)