
local F1Menu  = nil

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
			draw.SimpleText("This is a placeholder for future information!", "ChatFont", submenu1:GetWide()/2, submenu1:GetTall()/2, color_white, 1, 1)
		end
		
	else
		F1Menu:Close()
		F1Menu = nil
		gui.EnableScreenClicker(false)
	
	end
	
	
end
concommand.Add("war_helpsettings", ShowHelpMenu)