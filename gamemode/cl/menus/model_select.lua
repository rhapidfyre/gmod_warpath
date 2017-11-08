-- File controls the F3 Menu
local F3Menu = nil
local modelview		= "kleiner.mdl"	
	
local ModelTable = {
--[[ Table#,    model path,         Allowed Team#,  donor/vip only
                                    0 = All Teams
]]
	{1,"group03/female_04.mdl"	    ,1, 	        true},
	{2,"group03/female_02.mdl"	    ,1, 	        true},
	{3,"group03/male_07.mdl"		,1, 	        false},
	{4,"group03/male_05.mdl"		,1, 	        false},
	{5,"group03/male_03.mdl"		,1, 	        false},
	{6,"group03/male_02.mdl"		,1, 	        false},
	{7,"group03/female_01.mdl"	    ,1, 	        true},
	{8,"group03/female_03.mdl"	    ,1, 	        true},
	{9,"group03/female_05.mdl"	    ,1, 	        true},
	{10,"group03/female_06.mdl"	    ,1, 	        true},
	{11,"group03/male_01.mdl"		,1, 	        false},
	{12,"group03/male_02.mdl"		,1, 	        false},
	{13,"group03/male_04.mdl"		,1, 	        false},
	{14,"group03/male_08.mdl"		,1, 	        false},
	{15,"group03/male_06.mdl"		,1, 	        false},
	{16,"group01/female_03.mdl"	    ,1, 	        true},
	{17,"group01/female_02.mdl"	    ,1, 	        true},
	{18,"group01/female_04.mdl"	    ,1, 	        true},
	{19,"group02/male_02.mdl"		,1, 	        false},
	{20,"group01/male_03.mdl"		,1, 	        false},
	{21,"group01/male_07.mdl"		,1, 	        false},
	{22,"group03m/female_03.mdl"	,1, 	        true},
	{23,"group03m/male_01.mdl"	    ,1, 	        false},
	{24,"group03m/female_02.mdl"	,1, 	        true},
	{25,"group03m/male_07.mdl"	    ,1, 	        false},
	{26,"combine_soldier.mdl"	    ,2, 	        false},
	{27,"combine_soldier_prisonguard.mdl"	    ,2, 	        false},
	{28,"combine_super_soldier.mdl"	,2, 	        false},
	{29,"police.mdl"	            ,2, 	        false},
	{30,"breen.mdl"	                ,2, 	        false},
	{31,"kleiner.mdl"	            ,0, 	        false},
	{32,"alyx.mdl"	                ,0, 	        false},
	{33,"eli.mdl"	                ,0, 	        false},
	{33,"monk.mdl"	                ,0, 	        false},
}

-- The menu itself
local function GMF3Menu()

	modelview = string.Right(LocalPlayer():GetModel(), 14)

    if !IsValid(F3Menu) then
    
        local x = ScrW()*0.35
        local y = ScrH()*0.5
        local w = ScrW()/2
        local h = ScrH()/2
        local teamCol = team.GetColor(LocalPlayer():Team())
        
        F3Menu = vgui.Create("DFrame")
        F3Menu:SetSize(x, y)
        F3Menu:SetPos(w - x/2, h - y/2)
        F3Menu:ShowCloseButton(true)
        F3Menu:SetDraggable(false)
        F3Menu:SetTitle("MODEL SELECT")
        F3Menu.Paint = function()
            draw.RoundedBox(6, 0, 0, F3Menu:GetWide(), F3Menu:GetTall(), Color(40,40,40))
            draw.RoundedBoxEx(6, 0, 0, F3Menu:GetWide(), 24, Color(teamCol.r, teamCol.g, teamCol.b,255), true, true, false, false)
        end
        
        local F3Panel = vgui.Create("DPanel", F3Menu)
        F3Panel:SetSize(F3Menu:GetWide()-4, F3Menu:GetTall()-4)
        F3Panel:SetPos(2,24)
        -- Overrides default appearance
        F3Panel.Paint = function()
        end 

        local F3Scroll = vgui.Create("DScrollPanel", F3Panel)
        F3Scroll:SetPos(2,0)
        F3Scroll:SetSize(F3Panel:GetWide()/2 - 4, F3Panel:GetTall())
        F3Scroll.Paint = function()
        end
        
        local i = 4
        local j = 4
        for k,v in pairs(ModelTable) do
            if v[3] == 0 or v[3] == LocalPlayer():Team() then
                -- Button's background
                local F3Button = vgui.Create("DPanel", F3Scroll)
                F3Button:SetSize(96,96)
                F3Button:SetPos(i, j)
                F3Button.Paint = function()
                    draw.RoundedBox(6, 0, 0, F3Button:GetWide(), F3Button:GetTall(), Color(120,120,120))
                    draw.RoundedBox(0, 4, 4, F3Button:GetWide()-8, F3Button:GetTall()-8, Color(25,25,25))
                end
                
                local F3Btn = vgui.Create("DModelPanel", F3Button)
                F3Btn:SetSize(96-8,96-8)
                F3Btn:SetPos(4,4)
                F3Btn:SetModel("models/player/"..v[2])
                F3Btn:SetCamPos(Vector(50,10,72))
                F3Btn:SetLookAt(Vector(0,0,64))
                function F3Btn:LayoutEntity(Entity) return end
                F3Btn:SetFOV(20)
                
                local F3Click = vgui.Create("DButton", F3Btn)
                F3Click:SetSize(96,96)
                F3Click:SetPos(0,0)
                F3Click:SetText("")
                F3Click.Paint = function()
                end
                F3Click.DoClick = function()
                    LocalPlayer():ConCommand("setmodel "..v[2])
                    surface.PlaySound("garrysmod/ui_click.wav")
                end
				function F3Click.OnCursorEntered()
					modelview = "models/player/"..v[2]
					print(modelview)
				end
                
                i = i + 100
                if i >= F3Scroll:GetWide() - 96 then
                    i = 4
                    j = j + 100
                end
            end
        end
		
		local F3Right = vgui.Create("DPanel", F3Menu)
		F3Right:SetSize(F3Menu:GetWide()/2 - 6, F3Menu:GetTall() - 32)
		F3Right:SetPos(F3Menu:GetWide()/2 + 2, 28)
		
		local viewer = vgui.Create("DModelPanel", F3Right)
		viewer:SetSize(F3Right:GetWide(),F3Right:GetTall())
		viewer:Center()
		viewer:SetCamPos(Vector(20,20,48))
		viewer:SetLookAt(Vector(0,0,48))
		viewer:SetAnimated(true)
		F3Right.Paint = function()
			local tCol = team.GetColor(LocalPlayer():Team())
			viewer:SetModel(modelview)
			function viewer.Entity:GetPlayerColor() return (Vector(tCol.r/255, tCol.g/255, tCol.b/255)) end
		end
        
        gui.EnableScreenClicker(true)
        
    else
    
        if F3Menu:IsVisible() then
            F3Menu:SetVisible(false)
            gui.EnableScreenClicker(false)
            F3Menu = nil
            
        else -- Shouldn't work but writing it just in case
            F3Menu:SetVisible(true)
            gui.EnableScreenClicker(true)
        end
        
    end

end
concommand.Add("war_modelselect", GMF3Menu)