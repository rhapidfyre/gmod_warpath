
ENT.Type = "point"

local spawn_gap = 10

function ENT:EstablishTeam()

    -- Finds the closest capture point and assigns the capture point to "nearest"
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
    
    print("[WARPATH] NPC Spawner ("..tostring(self:GetName()).." @ "..tostring(self:GetPos())..") now belongs to "..team.GetName(self.WarTeam).." ("..tostring(self.WarTeam)..")")
    print("[WARPATH] Nearest Capture Point: "..tostring(self.nearest:GetName()).." @ "..tostring(self.nearest:GetPos()))
    
    self.complete = true
end

function ENT:Initialize()

	if self.livingmobs == nil then self.livingmobs = 0 end
	if self.maxmobs == nil then self.maxmobs = 5 end
    
	self:SetName("SPWNR_"..self:MapCreationID())
    self.radius = 0
    
    self.last_spawn = CurTime()
    self.next_spawn = CurTime() + spawn_gap
    
    timer.Simple(1, function()
        self:EstablishTeam()
    end)
    
end

function ENT:AcceptInput(inputName, activator, called, data)
	if inputName == "DecreaseCount" then
		self.livingmobs = self.livingmobs - tonumber(data)
    elseif inputName == "change" then
        self.complete = false
        self:EstablishTeam()
	end
end

function ENT:KeyValue(key, value)
	if key == "radius" then self.radius = tonumber(value)
	elseif key == "citizenmodel" then self.model = value 
	elseif key == "combinemodel" then self.model = value 
	elseif key == "angles" then self:SetAngles(util.StringToType(value, "Angle"))
	end
end

function ENT:Think()
    if self.complete and RoundActive() then
        if CurTime() >= self.next_spawn then
            print("")
            if self.livingmobs < self.maxmobs and self.WarTeam ~= 0 then
                
                self.next_spawn = CurTime() + spawn_gap
                self.last_spawn = CurTime()
                
                --self.WarTeam = self.nearest:GetKeyValues()["TeamNum"]
                local npc = ents.Create("npc_citizen")
                
                -- Setting unique name for debugging purposes
                npc:SetName("SPW"..self:MapCreationID().."_"..npc:EntIndex())
                
                -- If the NPC is a gun fighter, give them a gun to use
                --if self.npcclass == "npc_combine_s" or self.npcclass == "npc_citizen" then
                    npc:SetKeyValue("additionalequipment", "weapon_shotgun")
                    if self.model == "rebel" and self.npcclass == "npc_citizen" then npc:SetKeyValue("type", "Rebel") end
                    npc:SetKeyValue("spawnflags", "1073664")	-- Don't drop gun, Fade Corpse, and don't let rebels follow players, don't allow player to push (8192, 512, 1048576, 16384)
                --end
                
                -- Add input so that when the mob dies, the spawner it belongs to will spawn another
                npc:Input("AddOutput", npc, ply, "OnDeath "..self:GetName()..":DecreaseCount:1::-1")
        
                npc:Spawn()
                
                
                --[DEBUG]
                npc:SetColor(team.GetColor(self.WarTeam))
                
                
                -- Weapon Accuracy / Rate of Spread
                npc:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
                
                npc:SetWarTeam(self.WarTeam)
                
                -- Randomly spawn within given radius by map
                npc:SetPos(self:GetPos() + Vector(0, 0, 0))
                --npc:SetAngles(Angle(0,math.random(1,360),0))
                
                timer.Simple(0.1, function()
                    npc:SetMaxHealth(npc:GetMaxHealth()/*Insert Health Calculation*/)
                    npc:SetHealth(npc:GetMaxHealth())
                    --AssaultPoint(npc)
                end)
                
                -- Change this spawners # of mobs alive (to prevent crowding/server overloading)
                self.livingmobs = self.livingmobs + 1
                
                Hostility()
                
            else
                self.next_spawn = CurTime() + spawn_gap
            end
            
        end
    end
end