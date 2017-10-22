
util.AddNetworkString("SV_Capture")
util.AddNetworkString("SV_Victory")
util.AddNetworkString("SV_Clock")
util.AddNetworkString("SV_YourPoints")

util.AddNetworkString("CL_NPCUpgrade")
util.AddNetworkString("CL_PLYUpgrade")
util.AddNetworkString("CL_MyPoints")

-- Sends client current team point count
net.Receive("CL_MyPoints", function(len, ply)
    net.Start("SV_YourPoints")
        net.WriteInt(upgrades[ply:Team()]["points"], 32)
        net.Send(ply)
end)