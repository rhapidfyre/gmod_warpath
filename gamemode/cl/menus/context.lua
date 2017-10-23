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
net.Receive("SV_Points", function()                   --
    NPC_Points = net.ReadInt(32)                          --
end)                                                      --
------------------------------------------------------------

function GM:ContextMenuOpen() return true end

function GM:OnContextMenuOpen() 
	if !IsValid(CMenu) then 
	
            UpdatePoints()
    
			CMenu = vgui.Create("DFrame")
			CMenu:SetPos(24,ScrH()*0.25)
			CMenu:SetSize( 300, 300 )
			CMenu:SetTitle( "Upgrade Window" )
			CMenu:SetVisible( true )
			CMenu:SetDraggable( true )
			CMenu:ShowCloseButton( true )
	
			local CSheet = vgui.Create("DPropertySheet", CMenu)
			CSheet:Dock(FILL)
			
			local panel1 = vgui.Create( "DPanel", CSheet )
			panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 125, 125, 125, self:GetAlpha() ) ) end
			CSheet:AddSheet( "NPC", panel1 )

			local panel2 = vgui.Create( "DPanel", CSheet )
			panel2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 125, 125, 125, self:GetAlpha() ) ) end
			CSheet:AddSheet( "Player", panel2 )
			
			local TeamPoints = vgui.Create("DLabel", panel1)
			TeamPoints:SetPos(20,10)
			TeamPoints:SetText("Points:  ")
	
			local TeamPointsValue = vgui.Create("DLabel", panel1)
			TeamPointsValue:SetPos(67,10)
			TeamPointsValue:SetTextColor(Color(0, 255, 0))
			TeamPointsValue:SetText("TEAM: "..NPC_Points)
            
			local NPCPointsValue = vgui.Create("DLabel", panel1)
			NPCPointsValue:SetPos(67,20)
			NPCPointsValue:SetTextColor(Color(0, 255, 0))
			NPCPointsValue:SetText("SELF:  "..PLY_Points)
	
			local HPLabel = vgui.Create("DLabel", panel1)
			HPLabel:SetPos(20,30)
			HPLabel:SetText("HP :")
			
			local HPButton = vgui.Create("DButton", panel1)
			HPButton:SetText("Upgrade!")
			HPButton:SetTextColor(Color(0, 0, 0))
			HPButton:SetPos(185,30)
			HPButton:SetSize(75,20)
			HPButton.DoClick = function()
				net.Start("CL_NPCUpgrade")
				net.WriteString("health")
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
				net.Start("CL_NPCUpgrade")
				net.WriteString("damage")
				net.SendToServer()
			end
			
			local DmgLabel = vgui.Create("DLabel", panel1)
			DmgLabel:SetPos(20,80)
			DmgLabel:SetText("Speed :")
			
			local DmgButton = vgui.Create("DButton", panel1)
			DmgButton:SetText("Upgrade!")
			DmgButton:SetTextColor(Color(0, 0, 0))
			DmgButton:SetPos(185,80)
			DmgButton:SetSize(75,20)
			DmgButton.DoClick = function()
				net.Start("CL_NPCUpgrade")
				net.WriteString("speed")
				net.SendToServer()
			end
			
			local DmgLabel = vgui.Create("DLabel", panel1)
			DmgLabel:SetPos(20,105)
			DmgLabel:SetText("Accuracy :")
			
			local DmgButton = vgui.Create("DButton", panel1)
			DmgButton:SetText("Upgrade!")
			DmgButton:SetTextColor(Color(0, 0, 0))
			DmgButton:SetPos(185,105)
			DmgButton:SetSize(75,20)
			DmgButton.DoClick = function()
				net.Start("CL_NPCUpgrade")
				net.WriteString("accuracy")
				net.SendToServer()
			end
			
			local DmgLabel = vgui.Create("DLabel", panel1)
			DmgLabel:SetPos(20,130)
			DmgLabel:SetText("Weapon")
			
			local DmgButton = vgui.Create("DButton", panel1)
			DmgButton:SetText("Upgrade!")
			DmgButton:SetTextColor(Color(0, 0, 0))
			DmgButton:SetPos(185,130)
			DmgButton:SetSize(75,20)
			DmgButton.DoClick = function()
				net.Start("CL_NPCUpgrade")
				net.WriteString("weapon")
				net.WriteString("weapon_crossbow")
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