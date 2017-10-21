iFlag = true

function DrawFlagIndc(flag,r,g,b)
	if LocalPlayer():Alive() and iFlag then
		local flagPos = flag:GetPos() + Vector(0,0,64)
		local flagScreenPos = flagPos:ToScreen()
		
		if LocalPlayer():IsLineOfSightClear(flagPos - Vector(0,0,8)) then
			draw.SimpleText("?", "HUDFloatOne", tonumber(flagScreenPos.x)+3, tonumber(flagScreenPos.y), Color(r,g,b,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		else
			draw.SimpleText("?", "HUDFloatOne", tonumber(flagScreenPos.x)+3, tonumber(flagScreenPos.y), Color(r,g,b,50), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
	end
end

function FlagIndicator()
	if player_manager.GetPlayerClass(LocalPlayer()) == "SCOUT" then
	
		for _, cp in pairs(ents.FindByClass("war_capture_point")) do
            local teamCol = team.GetColor(cp:GetKeyValues()["TeamNum"])
			DrawFlagIndc(cp,teamCol.r,teamCol.g,teamCol.b)
		end
        
	end
end

function HoveringNames()
	
	local flash = 255 - math.abs( math.sin(CurTime()) * 0.5 ) * 255
	for _, target in pairs(player.GetAll()) do
		if target:Alive() and target != LocalPlayer() and target:Team() > 0 and target:Team() < 3 then
		
			local targetPos = target:GetPos() + Vector(0,0,72)
			local targetDistance = math.floor((LocalPlayer():GetPos():Distance(targetPos)))
			local targetScreenpos = targetPos:ToScreen()
			
			if LocalPlayer():IsLineOfSightClear(targetPos - Vector(0,0,8)) then
                local seeCol = Color(0,0,255)
                if target:Team() ~= LocalPlayer():Team() then seeCol = Color(255,0,0) end
                draw.SimpleText("A", "HUDFloatOne", tonumber(targetScreenpos.x), tonumber(targetScreenpos.y), seeCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			end
		end
	end
	
end

hook.Add("HUDPaint", "HoveringNames", HoveringNames)

hook.Add("HUDPaint", "FlagIndicator", FlagIndicator)