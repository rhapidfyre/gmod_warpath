
ENT.Type = "point"

local spawn_gap = 15

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
	if self.maxmobs == nil then self.maxmobs = 2 end
	if self.spawnmobs == nil then self.spawnmobs = 2 end
    
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
                --for i=1,self.spawnmobs do
                
					local npc = nil
					if self.WarTeam == 2 then
                        npc = ents.Create("npc_combine_s")
                    elseif self.WarTeam == 5 then
                        npc = ents.Create("npc_fastzombie")
					else
						npc = ents.Create("npc_citizen")
					end
					
					--self.WarTeam = self.nearest:GetKeyValues()["TeamNum"]
					--local npc = ents.Create("npc_citizen")
					
					-- Setting unique name for debugging purposes
					npc:SetName("SPW"..self:MapCreationID().."_"..npc:EntIndex())
					
					-- If the NPC is a gun fighter, give them a gun to use
					if npc:GetClass() == "npc_citizen" or npc:GetClass() == "npc_combine_s" then
                    
						--[[
                        local upg = upgrades[self.WarTeam]["weapon"]
                        npc:SetKeyValue("additionalequipment", upgrade_info["weapon"][upg])
                        -- Set Citizens to use Rebel models
						if npc:GetClass() == "npc_citizen" then npc:SetKeyValue("citizentype", "3") end
                        ]]
						
						local weapons_table = {}
						for k,v in pairs (upweapons[self.WarTeam]) do
						
							if v then
								table.insert(weapons_table, k)
							end
						
						end
						
						local use_weapon = table.Random(weapons_table)
						npc:SetKeyValue("additionalequipment", use_weapon)
						
						-- Don't drop gun, Fade Corpse, and don't let rebels follow players, don't allow player to push (8192, 512, 1048576, 16384)
						npc:SetKeyValue("spawnflags", "1073664")	
						
                    end
					
					-- Add input so that when the mob dies, the spawner it belongs to will spawn another
					npc:Input("AddOutput", npc, ply, "OnDeath "..self:GetName()..":DecreaseCount:1::-1")

					npc:Spawn()
					
					
                    if self.WarTeam == 5 then
						npc:SetColor(Color(math.Rand(50,255),math.Rand(50,255),math.Rand(50,255)))
						timer.Simple(0.1, function()
						npc:SetMaxHealth(100/*Insert Health Calculation*/)
						npc:SetHealth(npc:GetMaxHealth())
						end)
					else
						npc:SetColor(Color(math.Rand(50,255),math.Rand(50,255),math.Rand(50,255)))
						--npc:SetColor(team.GetColor(self.WarTeam))
						timer.Simple(0.1, function()
						
						local HPLevel   = upgrades[self.WarTeam]["health"]
						local HPUpgrade = upgrade_info["perc"][HPLevel]
						npc:SetMaxHealth(50 + (100* HPUpgrade))
						npc:SetHealth(npc:GetMaxHealth())
						print(npc:GetMaxHealth())
						end)
					end
					
					
					
					--(DEBUG)
					--if ShowTeamColor == 1 then

					--end
					npc:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
					
					-- Weapon Accuracy / Rate of Spread
					local curr = upgrades[self.WarTeam]["accuracy"]
					local new  = upgrade_info["accu"][curr]
					npc:SetCurrentWeaponProficiency(new)
					
					npc:SetWarTeam(self.WarTeam)
										
					-- Randomly spawn within given radius by map
					npc:SetPos(self:GetPos() + Vector(0,0,0))
					--npc:SetAngles(Angle(0,math.random(1,360),0))
					

					
					-- Change this spawners # of mobs alive (to prevent crowding/server overloading)
					self.livingmobs = self.livingmobs + 1
				
					Hostility(npc, self.WarTeam)
				--end
	
                
            else
                self.next_spawn = CurTime() + spawn_gap
            end
            
        end
    end
end