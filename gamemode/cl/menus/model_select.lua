local CMenu = nil
local NPC_Points = 0
local PLY_Points = 0

-- local NPCUpgrades (upgrade) return end
	
	
function GM:ContextMenuOpen() return true end

function GM:OnContextMenuOpen() 
	if !IsValid(CMenu) then 
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
			panel1.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 128, 255, self:GetAlpha() ) ) end
			CSheet:AddSheet( "NPC", panel1 )

			local panel2 = vgui.Create( "DPanel", CSheet )
			panel2.Paint = function( self, w, h ) draw.RoundedBox( 4, 0, 0, w, h, Color( 255, 128, 0, self:GetAlpha() ) ) end
			CSheet:AddSheet( "Player", panel2 )
			
			local TeamPoints = vgui.Create("DLabel", panel1)
			TeamPoints:SetPos(20,10)
			TeamPoints:SetText("Points:  $")
	
			local TeamPointsValue = vgui.Create("DLabel", panel1)
			TeamPointsValue:SetPos(67,10)
			TeamPointsValue:SetTextColor(Color(0, 255, 0))
			TeamPointsValue:SetText(NPC_Points)
	
			local HPLabel = vgui.Create("DLabel", panel1)
			HPLabel:SetPos(20,30)
			HPLabel:SetText("HP")
			
			local HPButton = vgui.Create("DButton", panel1)
			HPButton:SetText("Upgrade!")
			HPButton:SetTextColor(Color(0, 0, 0))
			HPButton:SetPos(185,30)
			HPButton:SetSize(75,20)
			HPButton.DoClick = function()
				print("Health Upgraded!")
			end
			
			local DmgLabel = vgui.Create("DLabel", panel1)
			DmgLabel:SetPos(20,55)
			DmgLabel:SetText("Damage")
			
			local DmgButton = vgui.Create("DButton", panel1)
			DmgButton:SetText("Upgrade!")
			DmgButton:SetTextColor(Color(0, 0, 0))
			DmgButton:SetPos(185,55)
			DmgButton:SetSize(75,20)
			DmgButton.DoClick = function()
				print("Damage Upgraded!")
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

net.Receive("SV_Point_Update", function()
	NPC_Points = net.ReadInt(12)
	PLY_Points = net.ReadInt(12)
	end)