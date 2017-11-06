
local lastShow = CurTime()
local endgame = nil

local function DisplayVictory(victor)
	
	if lastShow > CurTime() then
		if endgame == nil then
			local endgame = vgui.Create("DFrame")
			endgame:SetSize(ScrW()*0.75, ScrH()*0.4)
			endgame:Center()
			endgame:ShowCloseButton(false)
			
			
			
			endgame:MakePopup()
		end
		if endgame ~= nil then
			if !endgame:IsVisible() then endgame:SetVisible(true) end
		end
	else
		if endgame ~= nil then
			endgame:Close()
			endgame:Remove()
			endgame = nil
		end
	end	
	
end

net.Receive("SV_Capture", function(len, ply)
    
    local point  = net.ReadInt(8)
    local cteam  = net.ReadInt(8)
    local myTeam = LocalPlayer():Team()
    local align
    
    if cteam == myTeam then
        align = "team_captured"
    elseif cteam == 2 then
        align = "blue_captured"
    elseif cteam == 1 then
        align = "red_captured"
    elseif cteam == 3 then
        align = "yellow_captured"
    elseif cteam == 4 then
        align = "green_captured"
    else
        align = "enemy_captured"
    end
    
    surface.PlaySound("vox/"..align..".wav")
    timer.Simple(2.5, function() surface.PlaySound("vox/"..tostring(point)..".wav") end)

end)

net.Receive("SV_Victory", function(len, ply)

    local cteam = net.ReadInt(8)
    if cteam == LocalPlayer():Team() then
        surface.PlaySound("vox/all_secured.wav")
    else
        surface.PlaySound("vox/all_captured.wav")
    end
	lastShow = CurTime() + TIME_END
	DisplayVictory(victor)
	
end)