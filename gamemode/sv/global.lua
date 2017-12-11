
--[[
    IsPlaying()
    Returns true if the supplied player is on a valid team (1-4)
    @param ply Player Entity
]]
function IsPlaying(ply)
    if ply:Team() > 0 and ply:Team() < 5 then
        return true
    end
    return false
end

--[[
	CheckReady()
	Returns true if any players are on a playable team and ready to play
]]
function CheckReady()
	for _,ply in pairs (player.GetAll()) do
		if ply:Team() > 0 and ply:Team() < 5 then
			return true
		end
	end
	return false
end

function GetMaxAmmo(ply, weapon)

	if weapon == "weapon_shotgun" then
		return 32
	elseif weapon == "weapon_crossbow" then
		return 10
	else
		print(weapon.MaxAmmo)
		return weapon.MaxAmmo
	end
end