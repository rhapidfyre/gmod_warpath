
local DevList = {}

hook.Add("HUDPaint", "DevList", function()
	local trigR = math.Clamp(math.abs(math.sin(CurTime() * 1.25)*255), 80, 255)
	local trigG = math.Clamp(math.abs(math.sin(CurTime() * 5)*255), 80, 255)
	local trigB = math.Clamp(math.abs(math.sin(CurTime() * 2.75)*255), 80, 255)
	local multiplier = 0
	draw.SimpleTextOutlined("DEVELOPER VERSION","DermaLarge",ScrW()-6,0,Color(255,80,80,200),2,0,1,Color(0,0,0))
	draw.SimpleTextOutlined(GameVersion,"DermaLarge",ScrW()-6,24,Color(trigR,trigG,trigB,200),2,0,1,Color(0,0,0))
	for _,needs in pairs(DevList) do
		draw.SimpleTextOutlined(needs,"Trebuchet18",ScrW()-6,64 + (16*multiplier),Color(255,255,255,120),2,0,1,Color(0,0,0))
		multiplier = multiplier + 1
	end
end)