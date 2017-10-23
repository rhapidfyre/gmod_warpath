
local F4Menu = nil

local categories = {"health", "accuracy", "damage", "speed"}
local catweapons = {"weapon_crossbow", "weapon_ar2", "weapon_frag", "weapon_shotgun", "weapon_rpg"}
local upgrades = {}
local upgrade_info = {}
local upgrade_cost = {}
local weapon_cost = {}

local function GameF4Menu()

	upgrades 	 = GetGlobalString("upgrades")
	upgrade_info = GetGlobalString("upgrade_info")
	upgrade_cost = GetGlobalString("upgrade_cost")
	weapon_cost  = GetGlobalString("weapon_cost")
	
	if F4Menu == nil then
		F4Menu = vgui.Create("DFrame")
		F4Menu:SetSize(ScrW() * 0.35,ScrH() * 0.6)
		F4Menu:SetPos(12,(ScrH()/2)-F4Menu:GetTall()/2)
		F4Menu:SetVisible(true)
		F4Menu:ShowCloseButton(false)
		F4Menu:SetDeleteOnClose(false)
		F4Menu:SetDraggable(false)
		F4Menu:SetTitle("NPC Upgrades - Press F4 again to Close")
		F4Menu.Paint = function()
			draw.RoundedBox(0,0,0,F4Menu:GetWide(),F4Menu:GetTall(),Color(80,80,80))
			
			
		end			
		
		local LeftMenu  = vgui.Create("DPanel", F4Menu)
		local RightMenu = vgui.Create("DPanel", F4Menu)
		local Display   = vgui.Create("DPanel", RightMenu)
		local BuyBtn    = vgui.Create("DButton", RightMenu)
		local Closer    = vgui.Create("DButton", RightMenu)
		
		LeftMenu:SetSize((F4Menu:GetWide()/2)-8, (F4Menu:GetTall()-8))
		LeftMenu:SetPos(4, 4)
		LeftMenu.Paint = function()
			draw.RoundedBox(4,0,0,LeftMenu:GetWide(),LeftMenu:GetTall(),Color(40,40,40))
		end
		
		RightMenu:SetSize((F4Menu:GetWide()/2)-8, (F4Menu:GetTall()-8))
		RightMenu:SetPos((F4Menu:GetWide()/2)+4, 4)
		RightMenu.Paint = function()
			draw.RoundedBox(4,0,0,LeftMenu:GetWide(),LeftMenu:GetTall(),Color(20,20,20))
		end
		
		for k,v in pairs (categories) do
		
			local selector  = vgui.Create("DButton", LeftMenu)
			selector:SetSize(LeftMenu:GetWide() - 12, 24)
			selector:SetPos(6,8)
			selector:SetText(k)
		
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