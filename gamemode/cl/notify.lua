
net.Receive("SV_Capture", function(len, ply)
    
    local point  = net.ReadInt(8)
    local cteam  = net.ReadInt(8)
    local myTeam = LocalPlayer():Team()
    local align
    
    if cteam == myTeam then
        align = "team_captured"
    else
        align = "enemy_captured"
    end
    
    surface.PlaySound("vox/"..align..".wav")
    timer.Simple(2.5, function() surface.PlaySound("vox/"..tostring(point)..".wav") end)

end)

net.Receive("SV_AllCaptured", function(len, ply)

    

end)