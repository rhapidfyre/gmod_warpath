
local teamMenu = nil

function GM:ShowTeam()

    if IsValid(teamMenu) then
        if ((LocalPlayer():Team() > 0 and LocalPlayer():Team() < 4) or LocalPlayer():Team() == TEAM_UNASSIGNED) then
            teamMenu:Remove()
            teamMenu = nil
        end
    else
        
        timer.Simple(0.1, function()
            teamMenu = vgui.Create("DFrame")
            teamMenu:SetTitle("")
            teamMenu:SetSize(ScrW()*0.4,ScrH()*0.2)
            teamMenu:Center()
            teamMenu:ShowCloseButton(false)
            teamMenu.Paint = function()
                draw.RoundedBox(16,0,0,teamMenu:GetWide(),teamMenu:GetTall(),Color(180,180,180,120))
            end
            
            
            local t1_title = vgui.Create("DPanel", teamMenu)
            t1_title:SetSize(teamMenu:GetWide()/2 - 3,teamMenu:GetTall() * 0.65)
            t1_title:SetPos(2, 2)
            t1_title.Paint = function()
                draw.RoundedBoxEx(16,0,0,t1_title:GetWide(),t1_title:GetTall(),Color(0,0,0,220),true,false,false,false)
                draw.SimpleTextOutlined(team.GetName(1), "ScoreMain", (t1_title:GetWide()/2), t1_title:GetTall()*0.3, team.GetColor(1), 1, 1, 0, color_white)
                draw.SimpleTextOutlined("Players: "..#team.GetPlayers(1), "HUDScore2", (t1_title:GetWide()/2), t1_title:GetTall()*0.66, color_white, 1, 1, 0, color_white)
            end
            
            local t1_button = vgui.Create("DButton", t1_title)
            t1_button:SetSize(t1_title:GetWide(), t1_title:GetTall())
            t1_button:SetPos(0, 0)
            t1_button:SetText("")
            t1_button.Paint = function()
                local t1color = team.GetColor(1)
                if t1_button:IsHovered() then
                    draw.RoundedBoxEx(16,0,0,t1_button:GetWide(),t1_button:GetTall(),Color(t1color.r, t1color.g, t1color.b,40),true,false,false,false)
                end
            end
            function t1_button:OnCursorEntered()
                surface.PlaySound("buttons/lightswitch2.wav")
            end
            function t1_button.DoClick()
                self:HideTeam()
                RunConsoleCommand("changeteam", 1)
            end
            
            local t2_title = vgui.Create("DPanel", teamMenu)
            t2_title:SetSize(teamMenu:GetWide()/2 - 3,teamMenu:GetTall() * 0.65)
            t2_title:SetPos(teamMenu:GetWide()/2 + 1, 2)
            t2_title.Paint = function()
                draw.RoundedBoxEx(16,0,0,t2_title:GetWide(),t2_title:GetTall(),Color(0,0,0,220),false,true,false,false)
                draw.SimpleTextOutlined(team.GetName(2), "ScoreMain", (t2_title:GetWide()/2), t2_title:GetTall()*0.3, team.GetColor(2), 1, 1, 0, color_white)
                draw.SimpleTextOutlined("Players: "..#team.GetPlayers(2), "HUDScore2", (t2_title:GetWide()/2), t2_title:GetTall()*0.66, color_white, 1, 1, 0, color_white)
            end
        
            local t2_button = vgui.Create("DButton", t2_title)
            t2_button:SetSize(t2_title:GetWide(), t2_title:GetTall())
            t2_button:SetPos(0, 0)
            t2_button:SetText("")
            t2_button.Paint = function()
                local t2color = team.GetColor(2)
                if t2_button:IsHovered() then
                    draw.RoundedBoxEx(16,0,0,t2_button:GetWide(),t2_button:GetTall(),Color(t2color.r, t2color.g, t2color.b,40),false,true,false,false)
                end
            end
            function t2_button:OnCursorEntered()
                surface.PlaySound("buttons/lightswitch2.wav")
            end
            function t2_button.DoClick()
                self:HideTeam()
                RunConsoleCommand("changeteam", 2)
            end
            
            local t3_title = vgui.Create("DPanel", teamMenu)
            t3_title:SetSize(teamMenu:GetWide() - 4,(teamMenu:GetTall() * 0.35) - 4)
            t3_title:SetPos(2, teamMenu:GetTall() * 0.65 + 4)
            t3_title.Paint = function()
                draw.RoundedBoxEx(16,0,0,t3_title:GetWide(),t3_title:GetTall(),Color(0,0,0,220),false,false,true,true)
                draw.SimpleTextOutlined("SPECTATE", "ScoreMain", t3_title:GetWide()/2, t3_title:GetTall()/2, Color(200,200,200), 1, 1, 0, color_white)
            end
        
            local t3_button = vgui.Create("DButton", t3_title)
            t3_button:SetSize(t3_title:GetWide(), t3_title:GetTall())
            t3_button:SetPos(0, 0)
            t3_button:SetText("")
            t3_button.Paint = function()
                if t3_button:IsHovered() then
                    draw.RoundedBoxEx(16,0,0,t3_button:GetWide(),t3_button:GetTall(),Color(200, 200, 200,40),false,false,true,true)
                end
            end
            function t3_button:OnCursorEntered()
                surface.PlaySound("buttons/lightswitch2.wav")
            end
            function t3_button.DoClick()
                self:HideTeam()
                RunConsoleCommand("changeteam", TEAM_SPECTATOR)
            end
            
            teamMenu:MakePopup()
            teamMenu:SetKeyboardInputEnabled(false)
            
        end)
    end
end

function GM:HideTeam()

	if ( IsValid(teamMenu) ) then
		teamMenu:Remove()
		teamMenu = nil
	end
    
end