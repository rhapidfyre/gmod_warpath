
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
            teamMenu:SetSize(ScrW()*0.4,ScrH()*0.1)
            teamMenu:Center()
            teamMenu:ShowCloseButton(false)
            teamMenu.Paint = function()
                draw.RoundedBox(0,0,0,teamMenu:GetWide(),teamMenu:GetTall(),Color(80,80,80))
            end
            
            
            local t1_title = vgui.Create("DPanel", teamMenu)
            t1_title:SetSize(teamMenu:GetWide()/2 - 3,teamMenu:GetTall() - 4)
            t1_title:SetPos(2, 2)
            t1_title.Paint = function()
                draw.RoundedBox(0,0,0,teamMenu:GetWide(),teamMenu:GetTall(),Color(25,25,25))
                draw.SimpleTextOutlined(team.GetName(1), "ScoreMain", (teamMenu:GetWide()/2)/2, teamMenu:GetTall()*0.5, color_white, 1, 1, 0, color_white)
            end
            
            local t1_button = vgui.Create("DButton", t1_title)
            t1_button:SetSize(t1_title:GetWide(), t1_title:GetTall())
            t1_button:SetPos(0, 0)
            t1_button:SetText("")
            t1_button.Paint = function()
                local t1color = team.GetColor(1)
                if t1_button:IsHovered() then
                    draw.RoundedBox(0,0,0,t1_button:GetWide(),t1_button:GetTall(),Color(t1color.r, t1color.g, t1color.b,40))
                end
            end
            function t1_button.DoClick()
                self:HideTeam()
                RunConsoleCommand("changeteam", 1)
            end
            
            local t2_title = vgui.Create("DPanel", teamMenu)
            t2_title:SetSize(teamMenu:GetWide()/2 - 3,teamMenu:GetTall() - 4)
            t2_title:SetPos(teamMenu:GetWide()/2 + 1, 2)
            t2_title.Paint = function()
                draw.RoundedBox(0,0,0,teamMenu:GetWide(),teamMenu:GetTall(),Color(25,25,25))
                draw.SimpleTextOutlined(team.GetName(2), "ScoreMain", (teamMenu:GetWide()/2)/2, teamMenu:GetTall()*0.5, color_white, 1, 1, 0, color_white)
            end
        
            local t2_button = vgui.Create("DButton", t2_title)
            t2_button:SetSize(t2_title:GetWide(), t2_title:GetTall())
            t2_button:SetPos(0, 0)
            t2_button:SetText("")
            t2_button.Paint = function()
                local t2color = team.GetColor(2)
                if t2_button:IsHovered() then
                    draw.RoundedBox(0,0,0,t2_button:GetWide(),t2_button:GetTall(),Color(t2color.r, t2color.g, t2color.b,40))
                end
            end
            function t2_button.DoClick()
                self:HideTeam()
                RunConsoleCommand("changeteam", 2)
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