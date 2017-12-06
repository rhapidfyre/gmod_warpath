
local F4Menu  = nil
local upName  = "None Selected"
local upDesc  = "No Details"
local upLong  = "This menu is for buying upgrades that will affect your NPCs. The points will come from the team balance. Be careful, this uses the point balance for the ENTIRE team! You must hover an upgrade to see extended information regarding the upgrade you wish to purchase."
local upCost  = {}
local upLevel = 0

local function GameF4Menu()
	
	if F4Menu == nil then
		F4Menu = vgui.Create("DFrame")
		F4Menu:SetSize(ScrW() * 0.4,ScrH() * 0.3)
		F4Menu:Center()
		F4Menu:ShowCloseButton(false)
		F4Menu:SetDeleteOnClose(false)
		F4Menu:SetDraggable(false)
		F4Menu:SetTitle("")
		F4Menu.Paint = function()
		end
		
		local menuLeft = vgui.Create("DPanel", F4Menu)
		menuLeft:SetSize((F4Menu:GetWide()*0.35)-4, F4Menu:GetTall())
		menuLeft:SetPos(0,0)
		menuLeft.Paint = function()
			draw.RoundedBoxEx(8, 0, 0, menuLeft:GetWide(), menuLeft:GetTall(), Color(80,80,80,100),true,false,true,false)
		end
		
		local menuRight = vgui.Create("DPanel", F4Menu)
		menuRight:SetSize((F4Menu:GetWide()*0.65), F4Menu:GetTall())
		menuRight:SetPos(menuLeft:GetWide() + 4,0)
		menuRight.Paint = function()
		
			draw.RoundedBoxEx(8, 0, 0, menuRight:GetWide(), menuRight:GetTall(), Color(80,80,80,100),false,true,false,true)
			draw.SimpleText("NPC Upgrade Selection", "Trebuchet24", menuRight:GetWide()/2, 16, team.GetColor(LocalPlayer():Team()), 1, 1)
			draw.SimpleText(upName, "Trebuchet18", menuRight:GetWide()/2, 48, Color(255,255,255), 1, 1)
			draw.SimpleText(upDesc, "Trebuchet18", menuRight:GetWide()/2, 68, Color(255,255,255), 1, 1)
			--[[
			local upLv = upLevel + 1
			if (upLv < #upCost) and (upCost[upLv] ~= nil) then
				draw.SimpleText(upCost[upLv], "Trebuchet18", menuRight:GetWide()/2, 96, Color(255,255,255), 1, 1)
			end
			]]
		end
		
		local y = 4
		for k,v in pairs(warpath_upgrades) do
			if v["player"] == false && v["stat"] == true then
				local button = vgui.Create("DButton", menuLeft)
				button:SetSize(menuLeft:GetWide()-28, 24)
				button:SetPos(8,y)
				button:SetText(v["title"])
				function button:OnCursorEntered()
					upName = v["title"]
					upDesc = v["desc"]
					upLong = v["longdesc"]
				end
				y = y + 28
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