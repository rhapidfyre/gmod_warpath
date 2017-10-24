hook.Add( "OnPlayerChat", "HelloCommand", function( ply, strText, bTeam, bDead )

	strText = string.lower( strText )

	if (strText == "timeleft" or strText == "!timeleft" or strText == "/timeleft") then
	
		local time_remain = MAX_TIME - CurTime()
		if time_remain < 0 then time_remain = 0 end
		
		PrintMessage(HUD_PRINTTALK, "Time Remaining -> "..string.FormattedTime(time_remain, "%02imin %02isec"))
		return false
		
	elseif (strText == "nextmap" or strText == "!nextmap" or strText == "/nextmap") then
	
		PrintMessage(HUD_PRINTTALK, "The next map will be: ("..NEXT_MAP..")")
		PrintMessage(HUD_PRINTTALK, "Nominate a map by typing (vote mapname).")
	
	elseif (string.Left(strText, 4) == "vote") then
		local newStr = string.split(strText, " ")
		local maps = file.Find("maps/war_"..newStr..".bsp", "MAPS")
	
	end

end )