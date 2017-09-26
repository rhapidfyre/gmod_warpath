
local DevList = {
	"Example of a step to be completed",
    "Second example of another step"
}

hook.Add("HUDPaint", "DevList", function()
	local multiplier = 0
	draw.SimpleTextOutlined("DEVELOPER VERSION","DermaLarge",ScrW()-6,0,Color(255,80,80,200),2,0,1,Color(0,0,0))
	draw.SimpleTextOutlined("NOT FOR RELEASE","DermaLarge",ScrW()-6,24,Color(255,80,80,200),2,0,1,Color(0,0,0))
	for _,needs in pairs(DevList) do
		draw.SimpleTextOutlined(needs,"Trebuchet18",ScrW()-6,64 + (16*multiplier),Color(255,255,255,120),2,0,1,Color(0,0,0))
		multiplier = multiplier + 1
	end
end)