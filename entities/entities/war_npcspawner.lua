
ENT.Type = "point"

local spawn_gap = 10

function ENT:EstablishTeam()

    -- Finds the closest capture point and assigns the capture point to "nearest"
    self.nearest        = nil
    self.WarTeam        = 5
    local cap_distance  = nil
    local distance      = 16300
    print("\n")
    for _,zone in pairs(ents.FindByClass("war_capture_zone")) do
        local new_distance = self:GetPos():Distance(zone:GetPos())
        if (distance > new_distance) then
            print("[DEBUG] NPC Spawner ("..tostring(zone:GetName()).." @ "..tostring(zone:GetPos())..") owned by team "..tostring(zone:GetKeyValues()["TeamNum"]).." is closer ("..tostring(new_distance)..") than previous ("..tostring(distance)..") zone.")
            self.nearest   = zone
            distance       = new_distance
            self.WarTeam   = zone:GetKeyValues()["TeamNum"]
        else
            print("[DEBUG] NPC Spawner ("..tostring(zone:GetName()).." @ "..tostring(zone:GetPos())..") was NOT closer ("..tostring(new_distance)..") than previous ("..tostring(distance)..") zone.")
        end
    end
    
    print("[WARPATH] NPC Spawner ("..tostring(self:GetName()).." @ "..tostring(self:GetPos())..") now belongs to "..team.GetName(self.WarTeam).." ("..tostring(self.WarTeam)..")")
    print("[WARPATH] Nearest Capture Point: "..tostring(self.nearest:GetName()).." @ "..tostring(self.nearest:GetPos()))
    
    self.complete = true
    print("\n")
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
		print("[DEBUG] [war_npcspawner] Decreasing count "..tostring(self.livingmobs).." by 1.")
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
    if self.complete then
        if CurTime() >= self.next_spawn then
            print("")
            print("[DEBUG] ["..self:GetName().."] Checking for spawn possibility..."..tostring(self.livingmobs).."/"..tostring(self.maxmobs))
            if self.livingmobs < self.maxmobs and self.WarTeam ~= 5 then
                
                self.next_spawn = CurTime() + spawn_gap
                self.last_spawn = CurTime()
                
                --self.WarTeam = self.nearest:GetKeyValues()["TeamNum"]
                local npc = ents.Create("npc_combine_s")
                
                -- Setting unique name for debugging purposes
                npc:SetName("SPW"..self:MapCreationID().."_"..npc:EntIndex())
                
                -- If the NPC is a gun fighter, give them a gun to use
                --if self.npcclass == "npc_combine_s" or self.npcclass == "npc_citizen" then
                    npc:SetKeyValue("additionalequipment", "weapon_ar2")
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
                print("[DEBUG] ["..self:GetName().."] I spawn NPCs that are on "..team.GetName(self.WarTeam).." ("..tostring(self.WarTeam)..")")
                
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
                
                print("[DEBUG] ["..self:GetName().."] "..tostring(npc:GetName())..", team #"..npc:GetWarTeam().." spawned.")
                
                Hostility()
                
            else
                print("[DEBUG] ["..self:GetName().."] Spawner failure; self.maxmobs reached!")
                self.next_spawn = CurTime() + spawn_gap
            end
            print("")
            
        end
    end
end