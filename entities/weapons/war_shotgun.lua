
-- Variables that are used on both client and server

SWEP.PrintName		    = "Shotgun"		-- 'Nice' Weapon name (Shown on HUD)
SWEP.Author			    = ""
SWEP.Contact		    = ""
SWEP.Purpose		    = ""
SWEP.Instructions	    = ""
SWEP.Base 		        = "weapon_base"
SWEP.HoldType		    = "shotgun"
    
SWEP.ViewModelFOV	    = 62
SWEP.ViewModelFlip	    = false
SWEP.ViewModel		    = "models/weapons/v_shotgun.mdl"
SWEP.WorldModel		    = "models/weapons/w_shotgun.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.AdminOnly			= false

SWEP.Category = "Weapons"

SWEP.MaxAmmo = 30

SWEP.Primary.Damage = 8
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Clip1 = 8
SWEP.Primary.ClipSize = 8
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Spread = .75
SWEP.Primary.NumberofShots = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 0.5
SWEP.Primary.Delay =0.9
SWEP.Primary.Force = 0

SWEP.HeadshotMultiplier    = 1.25

SWEP.UseHands = false
SWEP.Primary.Sound = "weapons/shotgun/single.wav"
SWEP.ReloadSound = "weapons/shotgun/shotgun_reload.wav"


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

	

function SWEP:SetupDataTables()
   self:NetworkVar("Bool", 0, "Reloading")
   self:NetworkVar("Float", 0, "ReloadTimer")

   return --weapon_base.SetupDataTables(self)
end

function SWEP:Reload()
	if self:Clip1() < self.Primary.ClipSize then
		local clips = self:Clip1()
		print(clips)
		clipslize = self.Primary.Clipsize
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START)

		for i= clips,8,1 do
			
				--[[
				if !timer.Exists("SGReload_T") then
					timer.Create("SGReload_T", 1, x, function()
						-- Do reload stuff
					if self:Clip1() >= self.Prmary.Clipsize then
						self:SetClip1(self.Primary.Clipsize)
						if timer.Exists("SGReload_T") then timer.Remove("SGReload_T") end
					end
					end)
			]]
				timer.Simple(1, function()
				local cliptemp = i
				self:EmitSound(Sound(self.ReloadSound))
				self.Weapon:SendWeaponAnim( ACT_RELOAD_SHOTGUN)
				print(cliptemp.." is how much is in the clip")
				self:SetClip1(cliptemp)
				print(self:Clip1())
				end)

			
		end
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH)
		
	end
end

function SWEP:Think()
end

function SWEP:GetMaxAmmo()
	return self.MaxAmmo
end
