
-- Variables that are used on both client and server

SWEP.PrintName		    = "Pistol"		-- 'Nice' Weapon name (Shown on HUD)
SWEP.Author			    = ""
SWEP.Contact		    = ""
SWEP.Purpose		    = ""
SWEP.Instructions	    = ""
SWEP.Base 		        = "weapon_base"
SWEP.HoldType		    = "Pistol"
    
SWEP.ViewModelFOV	    = 62
SWEP.ViewModelFlip	    = false
SWEP.ViewModel		    = "models/weapons/v_Pistol.mdl"
SWEP.WorldModel		    = "models/weapons/w_Pistol.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly			= false

SWEP.Category = "Weapons"

SWEP.Primary.Sound = Sound("")
SWEP.Primary.Damage = 20
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 8
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Spread = .01
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.1
SWEP.Primary.Delay =0.1
SWEP.Primary.Force = 0

SWEP.Secondary.ClipSize		= 0					-- Size of a clip
SWEP.Secondary.DefaultClip	= 0				-- Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "Pistol"



function SWEP:Initialize() --A initialize code, mess with that only if you want to make a swep with swep creator.
util.PrecacheSound(self.Primary.Sound)
util.PrecacheSound(self.ReloadSound)
self:SetWeaponHoldType( self.HoldType )
end

function SWEP:PrimaryAttack() --Mess with this if you want a different attack function. Google is your best friend to have the knowledge for that.

if ( !self:CanPrimaryAttack() ) then return end

local bullet = {}
bullet.Num = self.Primary.NumberofShots
bullet.Src = self.Owner:GetShootPos()
bullet.Dir = self.Owner:GetAimVector()
bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
bullet.Tracer = 0
bullet.Force = self.Primary.Force
bullet.Damage = self.Primary.Damage
bullet.AmmoType = self.Primary.Ammo

local rnda = self.Primary.Recoil * -1
local rndb = self.Primary.Recoil * math.random(-1, 1)

self:ShootEffects()

self.Owner:FireBullets( bullet )
self:EmitSound(Sound(self.Primary.Sound))
self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
self:TakePrimaryAmmo(self.Primary.TakeAmmo)

self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
self:EmitSound(Sound(self.ReloadSound))
self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

function SWEP:Think()
end