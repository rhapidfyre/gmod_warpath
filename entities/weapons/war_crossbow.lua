
-- Variables that are used on both client and server

SWEP.PrintName		    = "Crossbow"		-- 'Nice' Weapon name (Shown on HUD)
SWEP.Author			    = ""
SWEP.Contact		    = ""
SWEP.Purpose		    = ""
SWEP.Instructions	    = ""
SWEP.Base 		        = "weapon_base"
SWEP.HoldType		    = "crossbow"
    
SWEP.ViewModelFOV	    = 62
SWEP.ViewModelFlip	    = false
SWEP.ViewModel		    = "models/weapons/v_crossbow.mdl"
SWEP.WorldModel		    = "models/weapons/w_crossbow.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly			= false

SWEP.Category = "Weapons"

SWEP.MaxAmmo = 20

SWEP.Primary.Damage = 50
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Clip1 = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Spread = .001
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 0.1
SWEP.Primary.Delay = 1
SWEP.Primary.Force = 1

SWEP.HeadshotMultiplier    = 2

SWEP.UseHands = true
SWEP.Primary.Sound = Sound("weapon_crossbow.single")
SWEP.ReloadSound = Sound("weapon_crossbow.reload")


function SWEP:Initialize() --A initialize code, mess with that only if you want to make a swep with swep creator.
util.PrecacheSound(self.Primary.Sound)
util.PrecacheSound(self.ReloadSound)
self:SetWeaponHoldType( self.HoldType )
end

 

function SWEP:PrimaryAttack() --Mess with this if you want a different attack function. Google is your best friend to have the knowledge for that.
	self:ShootBullet(self.Primary.Damage, 1, 1)
end
function SWEP:SecondaryAttack()
end

function SWEP:ShootBullet( damage, num_bullets, aimcone )

	// Only the player fires this way so we can cast
	local pPlayer = self.Owner;

	if ( !pPlayer ) then
		return;
	end

	local vecSrc		= pPlayer:GetShootPos();
	local vecAiming		= pPlayer:GetAimVector();

	local info = { Num = num_bullets, Src = vecSrc, Dir = vecAiming, Spread = aimcone, Damage = damage };
	info.Attacker = pPlayer;

	if ( CLIENT ) then return end

	for i = 1, info.Num do

		local Src		= info.Spread || vec3_origin
		local Dir		= info.Dir + Vector( math.Rand( -Src.x, Src.x ), math.Rand( -Src.y, Src.y ), math.Rand( -Src.y, Src.y ) )
		local pBolt		= ents.Create( "crossbow_bolt" );

		pBolt:SetPos( info.Src + ( Dir * 32 ) )
		pBolt:SetAngles( Dir:Angle() );
		pBolt.m_iDamage = self.Primary.Damage;
		pBolt:SetOwner( pPlayer );
		pBolt:Spawn()

		pBolt:SetPos( info.Src + ( Dir * pBolt:BoundingRadius() ) );

		if ( pPlayer:WaterLevel() == 3 ) then
			pBolt:SetVelocity( Dir * BOLT_WATER_VELOCITY );
		else
			pBolt:SetVelocity( Dir * BOLT_AIR_VELOCITY );
		end
	end
end
function SWEP:Reload()
	if self:Clip1() < self.Primary.ClipSize then
	self:EmitSound(Sound(self.ReloadSound))
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
	end
end

function SWEP:Think()
end

function SWEP:GetMaxAmmo()
	return self.MaxAmmo
end
