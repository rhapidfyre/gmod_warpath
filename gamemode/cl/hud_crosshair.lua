
-- Turns red for enemy
-- Turns "X" for teammate
-- Disappears for non-ammo weaponry

local function DrawCrosshairs()
	local teamNum = LocalPlayer():Team()
	local eyetrace = LocalPlayer():GetEyeTrace()
	local ent = nil
	local color = team.GetColor(teamNum)
	local teammate = false
	
	if IsValid(eyetrace.Entity) then
		ent = eyetrace.Entity
	end
	
	if ent ~= nil then
		if ent:IsPlayer() then
			if ent:Team() ~= teamNum then
				color = Color(255,0,0)
				teammate = false
			else
				color = Color(0,255,0)
				teammate = true
			end
		elseif ent:IsNPC() then
			if ent:GetNWInt("TeamNum") ~= teamNum then
				color = Color(255,0,0)
				teammate = false
			else
				teammate = true
				color = Color(0,255,0)
			end
		end
	end
	
	if teammate then
	draw.SimpleText("X", "ChatFont", ScrW()/2, ScrH()/2, color, TEXT_ALIGN_CENTER, 1, 1, color)
	
	else
		draw.SimpleText("O", "HUDCrosshair1", ScrW()/2, ScrH()/2 - 6, color, TEXT_ALIGN_CENTER, 1, 1, color)
	--draw.SimpleText("Q", "HUDCrosshair2", ScrW()/2, ScrH()/2, team.GetColor(teamNum), TEXT_ALIGN_CENTER, 1, 1, color)
	end
end

hook.Add("HUDPaint", "NewCrosshair", function()
	if LocalPlayer():Alive() then
		DrawCrosshairs()
	end
end)
