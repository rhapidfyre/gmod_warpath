
hook.Add("HUDPaint", "CmdPoints", function()
	--draw.RoundedBoxEx(8,(ScrW()/2)-128,ScrH()-72,256,48,Color(80,80,80,255),true,true,false,false)
    local trig = math.abs(math.sin(CurTime()*0.325)*255)
    local pCol1 = team.GetColor(GetGlobalInt("CmdPoint1"))
    local pCol2 = team.GetColor(GetGlobalInt("CmdPoint2"))
    local pCol3 = team.GetColor(GetGlobalInt("CmdPoint3"))
    local pCol4 = team.GetColor(GetGlobalInt("CmdPoint4"))
    local pCol5 = team.GetColor(GetGlobalInt("CmdPoint5"))
    
    draw.SimpleText("1", "ScoreBack", ScrW()/2 - 64, 8, pCol1,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.SimpleText("1", "ScoreMain", ScrW()/2 - 64, 8, color_white,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    
    draw.SimpleText("2", "ScoreBack", ScrW()/2 - 32, 8, pCol2,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.SimpleText("2", "ScoreMain", ScrW()/2 - 32, 8, color_white,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    
    draw.SimpleText("3", "ScoreBack", ScrW()/2 -  0, 8, pCol3,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.SimpleText("3", "ScoreMain", ScrW()/2 -  0, 8, color_white,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    
    draw.SimpleText("4", "ScoreBack", ScrW()/2 + 32, 8, pCol4,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.SimpleText("4", "ScoreMain", ScrW()/2 + 32, 8, color_white,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    
    draw.SimpleText("5", "ScoreBack", ScrW()/2 + 64, 8, pCol5,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.SimpleText("5", "ScoreMain", ScrW()/2 + 64, 8, color_white,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    
    --[[
    draw.RoundedBox(4, ScrW()/2 - 77, 49, 26, 26, pCol1)
    draw.RoundedBox(4, ScrW()/2 - 76, 50, 24, 24, Color(40,40,40))
    draw.SimpleTextOutlined("1", "HUDScore3", ScrW()/2 - 64, 50, pCol1,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.RoundedBox(4, ScrW()/2 - 45, 49, 26, 26, pCol2)
    draw.RoundedBox(4, ScrW()/2 - 44, 50, 24, 24, Color(40,40,40))
    draw.SimpleTextOutlined("2", "HUDScore3", ScrW()/2 - 32, 50, pCol2,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.RoundedBox(4, ScrW()/2 - 13, 49, 26, 26, pCol3)
    draw.RoundedBox(4, ScrW()/2 - 12, 50, 24, 24, Color(40,40,40))
    draw.SimpleTextOutlined("3", "HUDScore3", ScrW()/2 - 0, 50,  pCol3,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.RoundedBox(4, ScrW()/2 + 19, 49, 26, 26, pCol4)
    draw.RoundedBox(4, ScrW()/2 + 20, 50, 24, 24, Color(40,40,40))
    draw.SimpleTextOutlined("4", "HUDScore3", ScrW()/2 + 32, 50, pCol4,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    draw.RoundedBox(4, ScrW()/2 + 51, 49, 26, 26, pCol5)
    draw.RoundedBox(4, ScrW()/2 + 52, 50, 24, 24, Color(40,40,40))
    draw.SimpleTextOutlined("5", "HUDScore3", ScrW()/2 + 64, 50, pCol5,TEXT_ALIGN_CENTER,0,1,Color(0,0,0))
    ]]
end)