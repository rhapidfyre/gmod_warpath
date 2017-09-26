
--[[

	If you want to make a custom clock, replace this file with your new HUD Clock.
	The following steps must be noted for your custom HUD Clock to work correctly.
	
	Step 1)		Hook into "HUDPaint"
	Step 2)		Important Values:
	
		GetGlobalInt("RoundTimeLeft") 	/or/ 	net.Receive("SV_Clock")
										-> 	Round Timeleft, unformatted integer value
											Using net.Receive version includes both timeleft and round status
										
		GetGlobalInt("RoundStatus") 	-> 	Round Status, unformatted integer value
										
		status							-> 	Numeric Value of round status
		
											0 = Stale
											1 = Preparing
											2 = Active
											3 = Intermission/Break
	
		sounds (bool variable)			-> Boolean for whether to play sounds or not
		
]]

-- I want the clock/status to always stay accurate/updated so I'm putting it first
clock 			= 0
status 			= 0


local function VOXRemaining()
	if sounds then
		if status == ROUND_ACTIVE then
			if clock == 62 then
			surface.PlaySound("hl1/fvox/time_remaining.wav")
			timer.Simple(2, function() surface.PlaySound("hl1/fvox/60.wav") end)
			timer.Simple(3, function() surface.PlaySound("hl1/fvox/seconds.wav") end)
			elseif clock == 30 then
			surface.PlaySound("hl1/fvox/30.wav")
			timer.Simple(1, function() surface.PlaySound("hl1/fvox/seconds.wav") end)
			timer.Simple(2, function() surface.PlaySound("hl1/fvox/remaining.wav") end)
			elseif clock < 6 then
				if clock > 0 then
					surface.PlaySound("hl1/fvox/"..(clock)..".wav")
				end
			-- Clock can't equal zero because the round updates before it gets here so we'll set it to 1 and make a 1 second timer
			elseif clock == 1 then
				timer.Simple(1, function() surface.PlaySound("ambient/alarms/warningbell1.wav") end)
			end
		end
	end
end

local function IntToString(value)
	if value == 0 then 		return "Waiting"
	elseif value == 1 then 	return "Prepare to Fight"
	elseif value == 2 then 	return "In Progress"
	elseif value == 3 then 	return "Intermission"
	else 					return "-ERROR-"
	end
end

local function DefineStatus()
	
	if 	status == 1 then	return "PREPARING"
	elseif status == 2 then	return "TIME LEFT"
	elseif status == 3 then	return "INTERMISSION"
	end
	
end

local function TimeFlash()

	if clock < 11 then
		return math.abs(math.sin(CurTime()*3)*200)
	else
		return 200
	end

end

local function HUDClock()

	draw.RoundedBoxEx(8,(ScrW()/2)-96,0,192,48,Color(80,80,80,255),false,false,true,true)
	
	draw.RoundedBoxEx(16,(ScrW()/2)-92,4,184,40,Color(20,20,20),true,true,false,false)	-- Black background
	surface.SetDrawColor(40,40,40,255)
	
	local time_remain 	= "WAITING FOR PLAYERS"
	local clocktime 	= 1
	local flash			= 200
	
	if status != 0 then
		clocktime		= clock
		time_remain 	= DefineStatus()
		if status == 2 then
			flash 		= TimeFlash()
		end
	end
	
	if status != 0 then
		draw.SimpleText(string.FormattedTime(clocktime, "%02i:%02i"), "HUDClock2", ScrW()/2, 2, Color(200,flash,flash), 1, 0)
		draw.SimpleText(string.FormattedTime(clocktime, "%02i:%02i"), "HUDClock1", ScrW()/2, 2, Color(200,flash,flash), 1, 0)
	end
	
end
hook.Add("HUDPaint", "timeleft", HUDClock)

net.Receive("SV_Clock", function()

	clock 	= net.ReadInt(12)
	status 	= net.ReadInt(8)
	VOXRemaining()

end)