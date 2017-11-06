
--[[

	Delete this file if you do not want to use any of the base gamemode weapons.
	Note: Player will always spawn with "war_pistol" unless you remove it from 'sv/player.lua'

]]

	local function GiveWeapons(ply, weapon)
		print("(DEBUG) Giving " ..weapon)
			ply:Give(weapon)
	end
	
-- Adds the table info to the gamemode (REQUIRED)
net.Receive("player_weapon", function (len,ply)
	local plyweapon = net.ReadString()
	print(plyweapon)
	--print(ply:Nick())
	
	if SERVER then
		if !ply:GetPrimary()then
			GiveWeapons(ply, plyweapon)
			ply:SetPrimaryWep(plyweapon)
			ply:SetPrimary(true)
		else
			print("(DEBUG) Already got a primary weapon dork")
		end
	end
	
end)


-------------------------------------------------
-- Everything below should be server side only --
-------------------------------------------------

		
	--[[
		args[1] =
			upgrade name (myupgrade.name)
		
		args[2] =
			"upgrade"	= Player is purchasing upgrade
			"reset"		= Round is over and upgrades are being reset (don't do anything if you don't want it to reset)
			"downgrade" = Player is refunding the upgrade
			
		args[3] =
			BOOLEAN		= True if team upgrade, false if player upgrade
			
		args[4] =
			Entity; Player
	]]







