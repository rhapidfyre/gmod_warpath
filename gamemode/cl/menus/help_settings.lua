
local F1Menu  = nil
local title		= "WARPATH"
local subtitle	= "Help the NPCs Capture the Points!"
local info1		= "This is a gamemode of command and conquer."
local info2		= "Purchase upgrades to make yourself and the team better!"
local info3		= "When one team captures all five points, it resets."
local info4		= "Watch out for neutral enemies at unclaimed points!"


function ShowHelpMenu()

	if !IsValid(F1Menu) then
	
		F1Menu = vgui.Create("DFrame")
		F1Menu:SetSize(ScrW()*0.3,ScrH()*0.5)
		local half_w = F1Menu:GetWide()/2
		local half_h = F1Menu:GetTall()/2
		F1Menu:SetPos(ScrW()/2 - (half_w),ScrH()/2 - (half_h))
		F1Menu:SetVisible(true)
		F1Menu:ShowCloseButton(true)
		gui.EnableScreenClicker(true)
		function F1Menu:OnClose()
			gui.EnableScreenClicker(false)
			F1Menu:Remove()
			F1Menu = nil
		end
		
		
		local submenu1 = vgui.Create("DPanel", F1Menu)
		submenu1:SetSize(F1Menu:GetWide() - 8,F1Menu:GetTall() - 32)
		submenu1:SetPos(4,28)
		submenu1.Paint = function()
			draw.RoundedBox(4,0,0,submenu1:GetWide(),submenu1:GetTall(),color_black)
			draw.SimpleText(title, "ChatFont", submenu1:GetWide()/2, (submenu1:GetTall()/2) - 74, color_white, 1, 1)
			draw.SimpleText(subtitle, "ChatFont", submenu1:GetWide()/2, (submenu1:GetTall()/2) - 42, color_white, 1, 1)
			draw.SimpleText(info1, "ChatFont", submenu1:GetWide()/2, (submenu1:GetTall()/2) - 16, color_white, 1, 1)
			draw.SimpleText(info2, "ChatFont", submenu1:GetWide()/2, submenu1:GetTall()/2, color_white, 1, 1)
			draw.SimpleText(info3, "ChatFont", submenu1:GetWide()/2, (submenu1:GetTall()/2) + 16, color_white, 1, 1)
			draw.SimpleText(info4, "ChatFont", submenu1:GetWide()/2, (submenu1:GetTall()/2) + 42, color_white, 1, 1)
		end
		
		local button = vgui.Create("DButton", submenu1)
		button:SetSize(96,24)
		button:SetText("HELP")
		button:SetPos(24,24)
		function button.DoClick()
			title		= "WARPATH"
			subtitle	= "Help the NPCs Capture the Points!"
			info1		= "This is a gamemode of command and conquer."
			info2		= "Purchase upgrades to make yourself and the team better!"
			info3		= "When one team captures all five points, it resets."
			info4		= "Watch out for neutral enemies at unclaimed points!"
		end
		
		local button = vgui.Create("DButton", submenu1)
		button:SetSize(96,24)
		button:SetText("COMMANDS")
		button:SetPos(128,24)
		function button.DoClick()
			title		= "COMMANDS INFORMATION"
			subtitle	= "Primary Gamemode Keys"
			info1		= "F2 - Team Selection"
			info2		= "F3 - Model Selection (Saves)"
			info3		= "F4 - NPC Upgrades"
			info4		= "C - Player Upgrades"
		end		
		
	else
		F1Menu:Close()
		F1Menu = nil
		gui.EnableScreenClicker(false)
	
	end
	
	
end
concommand.Add("war_helpsettings", ShowHelpMenu)