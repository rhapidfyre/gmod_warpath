
--[[
	Do not change anything in this file!
	
	This is used to setup upgrade counts
	for the formulas to use in other Lua files.
]]

upgrades = {}
	upgrades[1] = {}
	upgrades[1]["NPC"] = {}
	upgrades[1]["PLY"] = {}
	upgrades[2] = {}
	upgrades[2]["NPC"] = {}
	upgrades[2]["PLY"] = {}
	upgrades[3] = {}
	upgrades[3]["NPC"] = {}
	upgrades[3]["PLY"] = {}
	upgrades[4] = {}
	upgrades[4]["NPC"] = {}
	upgrades[4]["PLY"] = {}
	
for i = 1, 4, 1 do

	--	   Team, Type, Attribute,	Percentage
	upgrades[i]["NPC"]["Health"]	= 0.01
	upgrades[i]["NPC"]["Damage"]	= 0.01
	upgrades[i]["NPC"]["Accuracy"]	= 0.01
	upgrades[i]["NPC"]["Speed"]		= 0.01

	upgrades[i]["PLY"]["Health"]	= 0.01
	upgrades[i]["PLY"]["Damage"]	= 0.01
	upgrades[i]["PLY"]["Accuracy"]	= 0.01
	upgrades[i]["PLY"]["Speed"]		= 0.01

end