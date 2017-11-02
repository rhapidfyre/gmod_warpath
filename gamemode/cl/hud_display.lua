
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
	
	if LocalPlayer():Alive() then
		-- Draw Health/Team Box
		--draw.RoundedBoxEx(6,x,y,width/2,(ScrH() * 0.052),TeamWindow(),true,false,false,false)
		draw.RoundedBoxEx(16,x,y,width,(ScrH() * 0.0525),TeamWindow(),false,true,false,false)
		draw.RoundedBox(6,x,y - 2,8,height+4,Color(40,40,40))
		draw.RoundedBox(4,x,y + 56,width+2,6,Color(40,40,40))
		draw.RoundedBox(1,x + 2,y,4,height,Color(200,200,200))
		draw.RoundedBox(1,x + 2,y + 59,width-2,2,Color(200,200,200))
	
		-- Write Team
		draw.SimpleText(TeamName(),"HUDSmallBack",x + 108,y + 64,TeamColor(),TEXT_ALIGN_CENTER,0,2)
		draw.SimpleText(TeamName(),"HUDSmall",x + 108,y + 64,color_white,TEXT_ALIGN_CENTER,0,2)
		
		-- Player Name
		draw.SimpleTextOutlined(LocalPlayer():Name(),"ChatFont",x + 12,y,Color(255,255,255),0,0,1,Color(0,0,0))
		
		-- Health Indicator
		HealthFlash(x, y, width, height)
	end
	
end

function DrawWeapon()
	--[[
	local width		= ScrW()
	local height	= 42
	local color		= Color(32,32,32,255)
	
	local width		= 384
	local height	= 96
	local x			= ScrW() - (384+12)
	local y			= ScrH() - 128
	local color		= Color(120,120,120,255)
	
	if LocalPlayer():Alive() then
		-- Draw Health/Team Box
		--draw.RoundedBoxEx(6,x,y,width/2,(ScrH() * 0.052),TeamWindow(),true,false,false,false)
		draw.RoundedBoxEx(16,x,y,width,(ScrH() * 0.0525),TeamWindow(),false,true,false,false)
		draw.RoundedBox(6,x,y - 2,8,height+4,Color(40,40,40))
		draw.RoundedBox(4,x,y + 56,width+2,6,Color(40,40,40))
		draw.RoundedBox(1,x + 2,y,4,height,Color(200,200,200))
		draw.RoundedBox(1,x + 2,y + 59,width-2,2,Color(200,200,200))
	
		-- Write Team
		draw.SimpleTextOutlined(TeamName(),"HUDSmall",x + 12,y + 64,Color(255,255,255,255),0,0,2,TeamColor())
		
		-- Player Name
		draw.SimpleTextOutlined(LocalPlayer():Name(),"ChatFont",x + 12,y,Color(255,255,255),0,0,1,Color(0,0,0))
		
		-- Health Indicator
		HealthFlash(x, y, width, height)
	end
	]]

	-- Current weapon information and algorithms
	if (LocalPlayer():GetActiveWeapon():IsValid()) then

		local x	= ScrW() * 0.975
		local y	= ScrH() * 0.945
		
		local info_clip1 	= LocalPlayer():GetActiveWeapon():Clip1()
		local info_reserve 	= LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
		local curWeapon = LocalPlayer():GetActiveWeapon():GetClass()
		
	
		if( LocalPlayer():GetActiveWeapon():GetPrintName() ~= nil) then
			draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrintName(),"HUDSmallBack",x,y,TeamColor(),TEXT_ALIGN_RIGHT,0)
			draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrintName(),"HUDSmall",x,y,Color(255,255,255),TEXT_ALIGN_RIGHT,0)
		end
		
		if (curWeapon != "weapon_crowbar" && curWeapon != "weapon_physcannon") then
		
			x = ScrW() * 0.93
			y = ScrH() * 0.885
		
			if (LocalPlayer():GetActiveWeapon():Clip1() != -1) then
				draw.SimpleText(info_clip1, "HUDBack", x-2, y, TeamColor(), TEXT_ALIGN_RIGHT, 0)
				draw.SimpleText(info_clip1, "HUDFront", x-2, y, TeamColor(), TEXT_ALIGN_RIGHT, 0)
				draw.SimpleText(info_clip1, "HUDMain", x-2, y, Color(255,255,255), TEXT_ALIGN_RIGHT, 0)
				draw.SimpleText(info_reserve, "HUDSmallBack", x+6, y+2, TeamColor(), TEXT_ALIGN_LEFT, 0)
				draw.SimpleText(info_reserve, "HUDSmall", x+6, y+2, Color(255,255,255), TEXT_ALIGN_LEFT, 0)
			else
			
			end
			
			if (LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType()) > 0) then
			
			end
		end
		
	end
	
end

local hidetable = {
	CHudHealth 			= true,
	CHudBattery 		= true,
	CHudAmmo		 	= true,
	CHudSecondaryAmmo 	= true
}
hook.Add("HUDShouldDraw", "HideDefault", function(hudtype)
	if(hidetable[hudtype]) then return false end
end)

hook.Add("HUDPaint", "NewHUD", function()
	if LocalPlayer():Alive() then
		DrawHealth()
		DrawWeapon()
	end
end)