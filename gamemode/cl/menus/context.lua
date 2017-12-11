local CMenu = nil
local NPC_Points = 0
local PLY_Points = 0

local upName  = "None Selected"
local upDesc  = "No Details"
local upLong  = "This menu is for buying upgrades that will affect your NPCs. The points will come from the team balance. Be careful, this uses the point balance for the ENTIRE team! You must hover an upgrade to see extended information regarding the upgrade you wish to purchase."
local upCost  = {}
local upLevel = 0

-- local NPCUpgrades (upgrade) return end
	
------------------------------------------------------------
-- Updates the client of the team's upgrade point balance --
local function UpdatePoints()                             --
    PLY_Points = LocalPlayer():GetPoints()                --
    net.Start("CL_Points")                                --
        net.SendToServer()                                --
end                                                       --
                                                          --
net.Receive("SV_Points", function()                   	  --
    NPC_Points = net.ReadInt(32)                          --
end)                                                      --
------------------------------------------------------------

function GM:ContextMenuOpen() return true end

function GM:OnContextMenuOpen() 
	if !IsValid(CMenu) then 
	
            UpdatePoints()
    


			--panel1:SetVerticalScrollbarEnabled(true)
			
			if !LocalPlayer():GetPrimary() then
			
			CMenu = vgui.Create("DFrame")
			CMenu:SetPos(24,ScrH()*0.25)
			CMenu:SetSize(ScrW() * 0.20,ScrH() * 0.25)
			CMenu:SetTitle( "Primary Weapon" )
			CMenu:SetVisible( true )
			CMenu:SetDraggable( true )
			CMenu:ShowCloseButton( true )
			
	
			local CSheet = vgui.Create("DPropertySheet", CMenu)
			CSheet:Dock(FILL)
			
			local panel1 = vgui.Create( "DScrollPanel", CSheet )
			panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color(150,150,150,0) ) end
			CSheet:AddSheet( "Player", panel1 )
			
				local ShtButton = vgui.Create("DButton", panel1)
				ShtButton:SetText("Shotgun")
				ShtButton:SetTextColor(Color(0, 0, 0))
				ShtButton:SetPos(40,ScrH()*0.05)
				ShtButton:SetSize(60,60)
				ShtButton.DoClick = function()
					net.Start("player_weapon")
					net.WriteString("weapon_shotgun")
					net.SendToServer()
				end
				
				local RflButton = vgui.Create("DButton", panel1)
				RflButton:SetText("Rifle")
				RflButton:SetTextColor(Color(0, 0, 0))
				RflButton:SetPos(120,ScrH()*0.05)
				RflButton:SetSize(60,60)
				RflButton.DoClick = function()
					net.Start("player_weapon")
					net.WriteString("war_rifle")
					net.SendToServer()
				end
				
				local CrsButton = vgui.Create("DButton", panel1)
				CrsButton:SetText("Crossbow")
				CrsButton:SetTextColor(Color(0, 0, 0))
				CrsButton:SetPos(200,ScrH()*0.05)
				CrsButton:SetSize(60,60)
				CrsButton.DoClick = function()
					net.Start("player_weapon")
					net.WriteString("weapon_crossbow")
					net.SendToServer()
				end
			else
			
			CMenu = vgui.Create("DFrame")
			CMenu:SetPos(24,ScrH()*0.25)
			CMenu:SetSize(ScrW() * 0.20,ScrH() * 0.55)
			CMenu:SetTitle( "Upgrade Window" )
			CMenu:SetVisible( true )
			CMenu:SetDraggable( true )
			CMenu:ShowCloseButton( true )
	
			local CSheet = vgui.Create("DPropertySheet", CMenu)
			CSheet:Dock(FILL)
			
			local panel1 = vgui.Create( "DScrollPanel", CSheet )
			panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color(0,0,0,0) ) end
			CSheet:AddSheet( "Player", panel1 )
			
			
				local TeamPoints = vgui.Create("DLabel", panel1)
				TeamPoints:SetPos(20,10)
				TeamPoints:SetText("Points:  "..PLY_Points)            
		
		
				local y = 4
				for _,v in pairs(warpath_upgrades) do
					if v["player"] == true && v["stat"] == true then
						local button = vgui.Create("DButton", panel1)
						button:SetSize(250, 24)
						button:SetPos(30,10+y)
						button:SetText(v["title"])
						button:SetTooltip(v["desc"])
						function button.DoClick()
							net.Start("CL_Upgrade")
							net.WriteString(v["name"])
							net.WriteString("upgrade")
							net.WriteBool(true)
							net.SendToServer()
							print("DEBUG Player upgrade test: "..v["title"])
						end
						y = y + 28
					end
				end
				
	
				for _,v in pairs(warpath_upgrades) do
					if v["player"] == true && v["stat"] == false then
						local button = vgui.Create("DButton", panel1)
						button:SetSize(250, 24)
						button:SetPos(30,40+y)
						button:SetText(v["title"])
						button:SetTooltip(v["desc"])
						function button.DoClick()
							net.Start("CL_Upgrade")
							net.WriteString(v["name"])
							net.WriteString("upgrade")
							net.WriteBool(true)
							net.SendToServer()
							print("DEBUG Player upgrade test: "..v["title"])
						end
						y = y + 28

					end
			
				end

				--[[
				if !LocalPlayer():GetHasHealGun() then
					local MedButton = vgui.Create("DButton", panel1)
					MedButton:SetText("Medic")
					MedButton:SetTextColor(Color(0, 0, 0))
					MedButton:SetPos(40,170)
					MedButton:SetSize(60,60)
					MedButton.DoClick = function()
						net.Start("player_perk")
						net.WriteString("medic")
						net.SendToServer()
					end
				end
				
					local SvgButton = vgui.Create("DButton", panel1)
					SvgButton:SetText("Scavenge")
					SvgButton:SetTextColor(Color(0, 0, 0))
					SvgButton:SetPos(120,170)
					SvgButton:SetSize(60,60)
					SvgButton.DoClick = function()
						net.Start("CL_Upgrade")
						net.WriteString("scavenge")
						net.SendToServer()
					end
				
				
				local RvgButton = vgui.Create("DButton", panel1)
					RvgButton:SetText("Revenge")
					RvgButton:SetTextColor(Color(0, 0, 0))
					RvgButton:SetPos(200, 170)
					RvgButton:SetSize(60,60)
					RvgButton.DoClick = function()
						net.Start("CL_Upgrade")
						net.WriteString("revenge")
						net.SendToServer()
					end]]

		end
	
	end
	if IsValid(CMenu) then 
	
        CMenu:Show()
        CMenu:MakePopup()
		surface.PlaySound("garrysmod/content_downloaded.wav")
	
	end

end
	
	
	
function GM:OnContextMenuClose()

	if IsValid(CMenu) then 
		CMenu:Remove()
		CMenu = nil
		surface.PlaySound("garrysmod/ui_return.wav")
		
	end
    
end