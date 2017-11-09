
util.AddNetworkString("SV_Capture")
util.AddNetworkString("SV_Victory")
util.AddNetworkString("SV_Clock")
util.AddNetworkString("SV_Points")
util.AddNetworkString("SV_UpgradeSuccess")
util.AddNetworkString("SV_UpgradeFail")

util.AddNetworkString("CL_Upgrade")
util.AddNetworkString("CL_Points")
util.AddNetworkString("player_weapon")
util.AddNetworkString("player_perk")


-- Sends client current team point count
net.Receive("CL_Points", function(len, ply)
    net.Start("SV_Points")
        net.WriteInt(GetGlobalInt("WP_T"..ply:Team().."Points"), 32)
        net.Send(ply)
end)