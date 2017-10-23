
ENT.Type = "brush"

function ENT:EstablishTeam()

    self.nearest        = nil
    self.WarTeam        = 5
    local cap_distance  = nil
    local distance      = 16300
	
    for _,zone in pairs(ents.FindByClass("war_capture_zone")) do
        local new_distance = self:GetPos():Distance(zone:GetPos())
        if (distance > new_distance) then
            self.nearest   = zone
            distance       = new_distance
            self.WarTeam   = zone:GetKeyValues()["TeamNum"]
        end
    end
    
    self:SetKeyValue("TeamNum", self.WarTeam)
    self:SetName("CRATE_"..tostring(self.nearest:GetName()))
	
end

function ENT:Initialize()

	local crate = ents.Create("prop_physics_multiplayer")
	crate:SetModel("models/items/ammocrate_smg1.mdl")
	crate:SetPos(self:GetPos())
	crate:SetKeyValue("spawnflags","9999")
	crate:SetKeyValue("damagefilter","nodamage")
	crate:SetAngles(self:GetAngles())
	crate:SetCollisionGroup(COLLISION_GROUP_NONE)
	crate:SetSolid(SOLID_VPHYSICS)
	
	
	crate:Spawn()
	crate:SetSequence("idle")
	
	local cratephys = crate:GetPhysicsObject()
	cratephys:EnableMotion(false)
	
	--self:SetCollisionBounds(Vector(0,0,0),Vector(128,128,64))
	self:SetTrigger(true)
	self:UseTriggerBounds(true,1)
	self:SetNWEntity("PropEntity",crate)
	self:SetSolid(SOLID_BSP)
	
	self.Used = false
	
	timer.Simple(1, function() self:EstablishTeam() end)
	
end

function ENT:AcceptInput(inputName, activator, called, data)
    if inputName == "change" then
        timer.Simple(0.1, function() self:EstablishTeam() end)
	end
end

function ENT:Think()

end

function ENT:Use(activator, caller)
	print("Player USED ad_supply_bag")
	if caller:Team() == self.WarTeam then
		
	end
end


function ENT:KeyValue(k, v)
	if k == "angles" then
		self:SetAngles( util.StringToType(v, "angle") )
		print("Received angle: "..tostring(util.StringToType(v, "angle")))
	end
	
end

local function MaxAmmunition(gun)
	local AmmoType = {}
		AmmoType[1] 	= 240
		AmmoType[2] 	= 0
		AmmoType[3] 	= 70
		AmmoType[4] 	= 120
		AmmoType[5] 	= 70
		AmmoType[6] 	= 5
		AmmoType[7] 	= 48
		AmmoType[8] 	= 10
		AmmoType[9] 	= 0
		AmmoType[10] 	= 2
		AmmoType[11] 	= 5
		AmmoType[12] 	= 0
		AmmoType[13] 	= 40
		AmmoType[14] 	= 40
		AmmoType[15] 	= 0
		AmmoType[16] 	= 0
		AmmoType[17] 	= 0
		AmmoType[18] 	= 0
		AmmoType[19] 	= 0
		AmmoType[20] 	= 0
		AmmoType[21] 	= 400
		AmmoType[22] 	= 400
		AmmoType[23] 	= 70
		AmmoType[24] 	= 0
		AmmoType[25] 	= 400
		AmmoType[26] 	= 1000
		AmmoType[27] 	= 0
	
	local AMMO = gun:GetPrimaryAmmoType()
	
	if AMMO > 0 then
	
		local AMMOCOUNT = gun:Ammo1()
		
		if AMMOCOUNT < AmmoType[AMMO] then
		
			local COUNT = AmmoType[AMMO] - AMMOCOUNT
			if COUNT <= 30 then return COUNT
			
			else return 30 end
			
		else return 0 end
		
	else return 0 end
	
end

function ENT:Touch(activator)
	print(activator)
	print(self.Used)
	print(self.WarTeam)
	if activator:IsPlayer() and !self.Used and self.WarTeam == activator:Team() then  
		self.Used = true
		
		sound.Play("items/ammocrate_open.wav", self:GetPos())
		timer.Simple(0.125, function() sound.Play("items/ammo_pickup.wav", self:GetPos()) end)
		
		local crate = self:GetNWEntity("PropEntity")
		--crate:SetColor(Color(255,0,0,0))
		crate:SetSequence("Close")
		timer.Simple(2.75,function()
			--crate:SetColor(Color(255,255,255,255))
			crate:SetSequence("Open")
		end)
		timer.Simple(3, function()
			self.Used = false
			sound.Play("items/ammocrate_close.wav", crate:GetPos())
		end)
		
		for _,weapon in pairs(activator:GetWeapons()) do
		
			local VoidWeapons = {"m9k_knife", "m9k_suicide_bomb", "m9k_nitro", "weapon_frag", "weapon_rpg"}
			if !(table.HasValue(VoidWeapons, weapon:GetClass())) then
				local ammo = weapon:GetPrimaryAmmoType()
				activator:GiveAmmo(MaxAmmunition(weapon), ammo, true)
			end
			
		end
		
	end
	
end

function ENT:Draw()
end

function ENT:OnRemove()	
end











