
function TeamWindow()
	return team.GetColor(LocalPlayer():Team())
end

function TeamColor()
	return team.GetColor(LocalPlayer():Team())
end
	
function TeamName(nu)
	return team.GetName(LocalPlayer():Team())
end


function HealthFlash(x, y, w, h)

	if LocalPlayer():Team() > 0 and LocalPlayer():Team() < 5 then
		local clhealth 	= LocalPlayer():Health()
		
		local trig 		= math.abs(math.sin(CurTime() * 5) * 255)
		local color		= Color(255,255,255,alpha)
		
		local o_color	= Color(0,0,0,o_alpha)
		
		if clhealth > 20 then
			color	= Color(255,255,255,255)
			o_color = Color(0,0,0,255, 255)
		else
			color 	= Color(255,0,0,trig)
			o_color = Color(255,255,255,trig)
		end
		
		draw.RoundedBox(0,x + 14,y + 24,364,28,Color(220,220,220,255))
		draw.RoundedBox(0,x + 16,y + 28,357,21,Color(40,40,40,255))
		
		local hcolor
		if clhealth > 25 then
			hcolor = Color(220,0,0,255)
		else
			hcolor = Color(255,255,255,trig)
		end
		draw.RoundedBox(0,x + 16,y + 28,(100*(LocalPlayer():Health()/LocalPlayer():GetMaxHealth())) * 3.57,21,hcolor)
		--draw.RoundedBox(0,x + 3,y + 16,LocalPlayer():Armor() * 3.57,8,Color(255,180,0,255))
		
		draw.SimpleText(LocalPlayer():Health(),"CloseCaption_Normal",x+370,y+24,color,2,0)
	else
		local trig 		= math.abs(math.sin(CurTime()) * 0.25) * 255
		draw.SimpleTextOutlined("PRESS F2 TO JOIN!","CloseCaption_Normal",ScrW()*0.016,ScrH()*0.9125,Color(255,255,255,trig),0,0,1,Color(0,0,0))
	end
end

function DrawHealth()

	local clbattery	= LocalPlayer():Armor()
		
	local width		= ScrW()
	local height	= 42
	local color		= Color(32,32,32,255)
	
	local width		= 384
	local height	= 96
	local x			= 12
	local y			= ScrH() - 128
	local color		= Color(120,120,120,255)
    
    local window    = TeamWindow()
	
	-- Draw Health/Team Box
	--draw.RoundedBoxEx(6,x,y,width/2,(ScrH() * 0.052),TeamWindow(),true,false,false,false)
	draw.RoundedBoxEx(16,x+2,y,width,64,Color(window.r, window.g, window.b,120),false,true,false,false)
	draw.RoundedBox(0,x,ScrH()-68,width+2,38,window)
	draw.RoundedBox(8,x+12,ScrH()-64,width-12,32,Color(20,20,20))
	draw.RoundedBox(0,x,y - 2,8,height+4,Color(40,40,40))
	draw.RoundedBox(0,x,y + 56,width+2,6,Color(40,40,40))
	draw.RoundedBox(0,x + 2,y,4,height,Color(200,200,200))
	draw.RoundedBox(0,x + 2,y + 58,width-2,2,Color(200,200,200))
	
	-- Write Team
	draw.SimpleTextOutlined(TeamName(),"HUDSmall",x + (384/2),y + 64,color_white,TEXT_ALIGN_CENTER,0,2,TeamColor())
	
	-- Player Name
	draw.SimpleTextOutlined(LocalPlayer():Name(),"ChatFont",x + 14,y+4,Color(255,255,255),0,0,1,Color(0,0,0))
	
	-- Health Indicator
	HealthFlash(x, y, width, height)
	
end

function DrawWeapon()
    
    if (LocalPlayer():GetActiveWeapon():IsValid()) then
        
        local curWeapon     = LocalPlayer():GetActiveWeapon():GetClass()
        
        if (curWeapon != "weapon_crowbar" && curWeapon != "weapon_physcannon") then
        
            local width		= ScrW()
            local height	= 42
            local color		= Color(32,32,32,255)
            
            local width		= 384
            local height	= 96
            local x			= (ScrW() - 396) - 12
            local y			= ScrH() - 128
            local color		= Color(120,120,120,255)
            
            local window    = TeamWindow()
            
            -- Draw Box Frame
            --draw.RoundedBoxEx(6,x,y,width/2,(ScrH() * 0.052),TeamWindow(),true,false,false,false)
            draw.RoundedBoxEx(16,x+2,y,width-2,64,Color(window.r, window.g, window.b,120),true,false,false,false)
            draw.RoundedBox(0,x+2,ScrH()-68,width-2,38,window)
            draw.RoundedBoxEx(8,(x + (384/2)) + 2,y+4,84,48,Color(20,20,20),true,true,false,false)
            draw.RoundedBoxEx(8,(x + (384/2)) - 86,y+4,84,48,Color(20,20,20),true,true,false,false)
            draw.RoundedBox(8,x+6,ScrH()-64,width-12,32,Color(20,20,20))
            draw.RoundedBox(0,x+384,y - 2,8,height+4,Color(40,40,40))
            draw.RoundedBox(0,x,y + 56,width+2,6,Color(40,40,40))
            draw.RoundedBox(0,x + 384 + 2,y,4,height,Color(200,200,200))
            draw.RoundedBox(0,x+2,y + 58,width-2,2,Color(200,200,200))
        
            local info_clip1 	= LocalPlayer():GetActiveWeapon():Clip1()
            local info_reserve 	= LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
            
        
            if( LocalPlayer():GetActiveWeapon():GetPrintName() ~= nil) then
                draw.SimpleTextOutlined(LocalPlayer():GetActiveWeapon():GetPrintName(),"HUDSmall",x+(384/2), y + 64 ,color_white,TEXT_ALIGN_CENTER,0,2,TeamColor())
            end
        
        
            if (LocalPlayer():GetActiveWeapon():Clip1() != -1) then
                local alignX = (x+(384/2)) - 43
                --draw.SimpleText(info_clip1, "HUDBack",  ScrW()-88-60, y-8, TeamColor(), TEXT_ALIGN_CENTER, 0)
                draw.SimpleText("LOADED", "HUDFont2",  alignX, y+8, Color(255,255,255), TEXT_ALIGN_CENTER, 0)
                draw.SimpleText(info_clip1, "HUDSmallBack", alignX, y+18, TeamColor(), TEXT_ALIGN_CENTER, 0)
                draw.SimpleText(info_clip1, "HUDSmall",  alignX, y+18, Color(255,255,255), TEXT_ALIGN_CENTER, 0)
                
                local alignX = (x+(384/2)) + 43
                draw.SimpleText("RESERVE", "HUDFont2",  alignX, y+8, Color(255,255,255), TEXT_ALIGN_CENTER, 0)
                draw.SimpleText(info_reserve, "HUDSmallBack", alignX, y+18, TeamColor(), TEXT_ALIGN_CENTER, 0)
                draw.SimpleText(info_reserve, "HUDSmall", alignX, y+18, Color(255,255,255), TEXT_ALIGN_CENTER, 0)
            
            end
            
        end
        
    end
end

hook.Add("HUDPaint", "NewHUD", function()
	if LocalPlayer():Alive() then
		DrawHealth()
		DrawWeapon()
	end
end)