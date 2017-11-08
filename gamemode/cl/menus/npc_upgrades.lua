
local F4Menu  = nil
local upName  = "None Selected"
local upDesc  = "No Details"
local upLong  = "This menu is for buying upgrades that will affect your NPCs. The points will come from the team balance. Be careful, this uses the point balance for the ENTIRE team! You must hover an upgrade to see extended information regarding the upgrade you wish to purchase."
local upCost  = {}
local upLevel = 0

local function GameF4Menu()
	
	if F4Menu == nil then
		F4Menu = vgui.Create("DFrame")
		F4Menu:SetSize(ScrW() * 0.4,ScrH() * 0.6)
		F4Menu:Center()
		F4Menu:SetVisible(true)
		F4Menu:ShowCloseButton(false)
		F4Menu:SetDeleteOnClose(false)
		F4Menu:SetDraggable(false)
		F4Menu:SetTitle("NPC Upgrades - Press F4 again to Close")
		F4Menu.Paint = function()
			draw.RoundedBox(0,0,0,F4Menu:GetWide(),F4Menu:GetTall(),Color(80,80,80))
		end
		
		local LeftMenu  = vgui.Create("DPanel", F4Menu)
		LeftMenu:SetSize((F4Menu:GetWide()*0.33)-8, (F4Menu:GetTall()-8))
		LeftMenu:SetPos(4, 4)
		LeftMenu.Paint = function()
			draw.RoundedBox(4,0,0,LeftMenu:GetWide(),LeftMenu:GetTall(),Color(40,40,40))
		end
		
		local RightMenu = vgui.Create("DPanel", F4Menu)
		RightMenu:SetSize((F4Menu:GetWide()*0.66)-8, (F4Menu:GetTall()-8))
		RightMenu:SetPos((F4Menu:GetWide()*0.33), 4)
		RightMenu.Paint = function()
			draw.RoundedBox(4,0,0,RightMenu:GetWide(),RightMenu:GetTall(),Color(20,20,20))
            
            draw.SimpleText("TEAM POINTS", "ChatFont", RightMenu:GetWide()/2, 16, Color(255,255,0), 1, 1)
            draw.SimpleText(GetGlobalInt("WP_T"..LocalPlayer():Team().."Points"), "ChatFont", RightMenu:GetWide()/2, 32, team.GetColor(LocalPlayer():Team()), 1, 1)
            
            draw.SimpleText("Title", "ChatFont", RightMenu:GetWide()/2, 16+16+16+16, Color(200,255,200), 1, 1)
            draw.SimpleText(upName, "ChatFont", RightMenu:GetWide()/2, 32+16+16+16, team.GetColor(LocalPlayer():Team()), 1, 1)
            
            draw.SimpleText(upDesc, "ChatFont", RightMenu:GetWide()/2, 64+16+16+16+16+16, team.GetColor(LocalPlayer():Team()), 1, 1)
            
            draw.SimpleText("Current Level", "ChatFont", RightMenu:GetWide()/2, 96+16+16+16+16+16+16+16+16, Color(200,255,200), 1, 1)
            draw.SimpleText(upLevel, "ChatFont", RightMenu:GetWide()/2, 128+16+16+16+16+16+16+16, team.GetColor(LocalPlayer():Team()), 1, 1)
		
		end
		
		local RightWrap = vgui.Create("DLabel", RightMenu)
		RightWrap:SetText(upLong)
		RightWrap:SetAutoStretchVertical(true)
		RightWrap:SetWide(RightMenu:GetWide() * 0.8)
		RightWrap:SetWrap(true)
		RightWrap:Center()
		
		PrintTable(warpath_upgrades)
		if warpath_upgrades ~= nil then
        
			local x = 6
			local y = 8
            
			for _,v in pairs (warpath_upgrades) do
            
				local selector  = vgui.Create("DButton", LeftMenu)
				selector:SetSize(LeftMenu:GetWide() - 12, 24)
				selector:SetPos(x, y)
				selector:SetText(v["title"])
                selector.Paint = function()
                    if selector:IsHovered() then
                        draw.RoundedBox(4,0,0,selector:GetWide(),selector:GetTall(),Color(120,120,120))
                        draw.RoundedBox(4,1,1,selector:GetWide()-2,selector:GetTall()-2,team.GetColor(LocalPlayer():Team()))
                        upName  = v["title"]
                        upDesc  = v["desc"]
                        upLong  = v["longdesc"]
                        upCost  = v["cost"]
                        upLevel = v["level"][LocalPlayer():Team()]
                    else
                        draw.RoundedBox(4,0,0,selector:GetWide(),selector:GetTall(),Color(120,120,120))
                        draw.RoundedBox(4,1,1,selector:GetWide()-2,selector:GetTall()-2,Color(90,90,90))
                    end
                end
                selector.DoClick = function()
                    net.Start("CL_Upgrade")
                    net.WriteString("health_base")
                    net.WriteString("upgrade")
                    net.WriteBool(true)
                    net.SendToServer()
                    surface.PlaySound("garrysmod/ui_click.wav")
                end
                function selector:OnCursorEntered()
                    surface.PlaySound("buttons/lightswitch2.wav")
                end
				
				y = y + 32
			
			end
            
		end
		gui.EnableScreenClicker(true)
		
	else
		if(F4Menu:IsVisible()) then
			F4Menu:SetVisible(false)
			gui.EnableScreenClicker(false)
		else
			F4Menu:SetVisible(true)
			gui.EnableScreenClicker(true)
		end
	end
end
concommand.Add("war_npcupgrades", GameF4Menu)