
balance = {}
balance.use = true
balance.last = CurTime()
balance.rounds = 3
balance.mintime = 600

-- Runs the autobalancer if check returns true
function balance.Run()

end

-- Builds a table of the players to move
function balance.Check()
	
end

-- If true, disables the autobalancer.
function balance.Disable(value)
	balance.use = !value
end

-- Returns whether or not the plugin is being used
function balance.Using()
	return balance.use
end

-- Changes the number of rounds between the balancer running
function balance.NumRounds(value)
	balance.rounds = value
end

-- Sets a player to "I got balanced" so they can't switch back for a while
local meta = FindMetaTable("Player")
function meta:GotBalanced(value)
	if value then self.balanced = value end
	return self.balanced
end

-- When a player joins a new team, make sure they didn't just get autobalanced.
hook.Add("OnPlayerChangedTeam", "DenyChange", function(ply, old, new)
	if ply:GetBalanced() then
		ply:SetTeam(old)
		ply:PrintMessage(HUD_PRINTTALK, "Team Change Denied - You cannot avoid the autobalancer for "..balance.mintime.." seconds!")
	end
end)