
--[[---------------------------------------------------------
	Name: gamemode:HUDShouldDraw( name )
	Desc: return true if we should draw the named element
-----------------------------------------------------------]]
function GM:HUDShouldDraw( name )

	-- Allow the weapon to override this
	local ply = LocalPlayer()
	if ( IsValid( ply ) ) then

		local wep = ply:GetActiveWeapon()

		if ( IsValid( wep ) && wep.HUDShouldDraw != nil ) then

			return wep.HUDShouldDraw( wep, name )

		end

	end

	return true

end

--[[---------------------------------------------------------
	Name: gamemode:HUDPaint()
	Desc: Use this section to paint your HUD
-----------------------------------------------------------]]
function GM:HUDPaint()

	hook.Run( "HUDDrawTargetID" )
	hook.Run( "HUDDrawPickupHistory" )
	hook.Run( "DrawDeathNotice", 0.85, 0.04 )

end

--[[---------------------------------------------------------
	Name: gamemode:HUDPaintBackground()
	Desc: Same as HUDPaint except drawn before
-----------------------------------------------------------]]
function GM:HUDPaintBackground()
end