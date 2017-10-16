
--[[
	Do not change anything in this file!
	
	This is used to setup upgrade counts
	for the formulas to use in other Lua files.
]]

upgrades = {}
	upgrades[1] = {}
	upgrades[2] = {}
	upgrades[3] = {}
	upgrades[4] = {}
	
for i = 1, i <= 4, 1 do

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