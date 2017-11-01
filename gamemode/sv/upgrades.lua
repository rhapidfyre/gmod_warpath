
--[[
	Do not change anything in this file!
	
	This is used to setup upgrade counts
	for the formulas to use in other Lua files.
]]

net.Receive("CL_Upgrade", function(len, ply)

	print("(DEBUG) Receiving Client Upgrades")
	
	local up_name   = net.ReadString()
	local up_action = net.ReadString()
	
	local up_team = false
	if net.ReadBool() then up_team = true end
	
	local args = {}
	args[1] = up_name
	args[2] = up_action
	args[3] = up_team
	args[4] = ply
	
	hook.Call("DoUpgrade", GAMEMODE, args)
	
end)