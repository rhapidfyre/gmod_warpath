local CMenu = nil
local NPC_Points = 0
local PLY_Points = 0
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
    
			CMenu = vgui.Create("DFrame")
			CMenu:SetPos(24,ScrH()*0.25)
			CMenu:SetSize( 500, 300 )
			CMenu:SetTitle( "Upgrade Window" )
			CMenu:SetVisible( true )
			CMenu:SetDraggable( true )
			CMenu:ShowCloseButton( true )
	
			local CSheet = vgui.Create("DPropertySheet", CMenu)
			CSheet:Dock(FILL)
			
			local panel1 = vgui.Create( "DScrollPanel", CSheet )
			panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, team.GetColor(LocalPlayer():Team()) ) end
			CSheet:AddSheet( "Player", panel1 )

			panel1:SetVerticalScrollbarEnabled(true)
			
			local TeamPoints = vgui.Create("DLabel", panel1)
			TeamPoints:SetPos(20,10)
			TeamPoints:SetText("Points:  "..PLY_Points)            
	
			local HPLabel = vgui.Create("DLabel", panel1)
			HPLabel:SetPos(20,30)
			HPLabel:SetText("HP :")
			
			local HPButton = vgui.Create("DButton", panel1)
			HPButton:SetText("Upgrade!")
			HPButton:SetTextColor(Color(0, 0, 0))
			HPButton:SetPos(185,30)
			HPButton:SetSize(75,20)
			HPButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("health_base")
				net.WriteString("upgrade")
				net.SendToServer()
			end
			
			local DmgLabel = vgui.Create("DLabel", panel1)
			DmgLabel:SetPos(20,55)
			DmgLabel:SetText("Damage :")
			
			local DmgButton = vgui.Create("DButton", panel1)
			DmgButton:SetText("Upgrade!")
			DmgButton:SetTextColor(Color(0, 0, 0))
			DmgButton:SetPos(185,55)
			DmgButton:SetSize(75,20)
			DmgButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("damage_base")
				net.WriteString("upgrade")
				net.SendToServer()
			end
			
			local SpeedLabel = vgui.Create("DLabel", panel1)
			SpeedLabel:SetPos(20,80)
			SpeedLabel:SetText("Speed :")
			
			local SpeedButton = vgui.Create("DButton", panel1)
			SpeedButton:SetText("Upgrade!")
			SpeedButton:SetTextColor(Color(0, 0, 0))
			SpeedButton:SetPos(185,80)
			SpeedButton:SetSize(75,20)
			SpeedButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("speed_base")
				net.WriteString("upgrade")
				net.SendToServer()
			end
			
			local AmmoLabel = vgui.Create("DLabel", panel1)
			AmmoLabel:SetPos(20,105)
			AmmoLabel:SetText("Ammo  :")
			
			local AmmoButton = vgui.Create("DButton", panel1)
			AmmoButton:SetText("Upgrade!")
			AmmoButton:SetTextColor(Color(0, 0, 0))
			AmmoButton:SetPos(185,105)
			AmmoButton:SetSize(75,20)
			AmmoButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("ammo_base")
				net.WriteString("upgrade")
				net.SendToServer()
			end
			
		
			
			local ShtButton = vgui.Create("DButton", panel1)
			ShtButton:SetText("Shotgun")
			ShtButton:SetTextColor(Color(0, 0, 0))
			ShtButton:SetPos(40,170)
			ShtButton:SetSize(60,60)
			ShtButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("shotgun")
				net.SendToServer()
			end
			
			local RflButton = vgui.Create("DButton", panel1)
			RflButton:SetText("AR2")
			RflButton:SetTextColor(Color(0, 0, 0))
			RflButton:SetPos(120,170)
			RflButton:SetSize(60,60)
			RflButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("ar2")
				net.SendToServer()
			end
			
			local CrsButton = vgui.Create("DButton", panel1)
			CrsButton:SetText("Crossbow")
			CrsButton:SetTextColor(Color(0, 0, 0))
			CrsButton:SetPos(200,170)
			CrsButton:SetSize(60,60)
			CrsButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("crossbow")
				net.SendToServer()
			end
			
			local MedButton = vgui.Create("DButton", panel1)
			MedButton:SetText("Medic")
			MedButton:SetTextColor(Color(0, 0, 0))
			MedButton:SetPos(40,250)
			MedButton:SetSize(60,60)
			MedButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("medic")
				net.SendToServer()
			end
			
			local SvgButton = vgui.Create("DButton", panel1)
			SvgButton:SetText("Scavenge")
			SvgButton:SetTextColor(Color(0, 0, 0))
			SvgButton:SetPos(120,250)
			SvgButton:SetSize(60,60)
			SvgButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("scavenge")
				net.SendToServer()
			end
			
			local RvgButton = vgui.Create("DButton", panel1)
			RvgButton:SetText("Revenge")
			RvgButton:SetTextColor(Color(0, 0, 0))
			RvgButton:SetPos(200, 250)
			RvgButton:SetSize(60,60)
			RvgButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("Revenge")
				net.SendToServer()
			end
			

			local CapButton = vgui.Create("DButton", panel1)
			CapButton:SetText("Capture")
			CapButton:SetTextColor(Color(0, 0, 0))
			CapButton:SetPos(120,330)
			CapButton:SetSize(60,60)
			CapButton.DoClick = function()
				net.Start("CL_Upgrade")
				net.WriteString("capture")
				net.SendToServer()
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