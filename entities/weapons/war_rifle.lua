
-- Variables that are used on both client and server

SWEP.PrintName		    = "Rifle"		-- 'Nice' Weapon name (Shown on HUD)
SWEP.Author			    = ""
SWEP.Contact		    = ""
SWEP.Purpose		    = ""
SWEP.Instructions	    = ""
SWEP.Base 		        = "weapon_base"
SWEP.HoldType		    = "ar2"
    
SWEP.ViewModelFOV	    = 62
SWEP.ViewModelFlip	    = false
SWEP.ViewModel		    = "models/weapons/v_IRifle.mdl"
SWEP.WorldModel		    = "models/weapons/w_IRifle.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly			= false

SWEP.Category = "Weapons"

SWEP.Primary.Damage = 10
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Clip1 = 25
SWEP.Primary.ClipSize = 25
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Spread = .1
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay =0.1
SWEP.Primary.Force = 0

SWEP.HeadshotMultiplier    = 1.25

SWEP.UseHands = true
SWEP.Primary.Sound = "weapons/ar2/fire1.wav"
SWEP.ReloadSound = "weapons/ar2/ar2_reload.wav"


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
bullet.Tracer = 1
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