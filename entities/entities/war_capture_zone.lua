
-- This controls capture points

ENT.Type = "brush"

function ENT:Initialize()

	--self:SetName("CAP_POINT_"..self:MapCreationID())
    self:SetTrigger(true)
	self.occupied = false
    self.count = 0
    self.last_command = CurTime()
    
end

function ENT:AcceptInput(inputName, activator, called, data)

	if inputName == "capture" then
    
        PrintMessage(HUD_PRINTTALK, tostring(activator).." (TEAM "..tostring(activator:GetWarTeam())..") captured Control Point "..tostring(self.pointnumber))
        self.ownerteam = data
        self:SetKeyValue("TeamNum", data)
        
        -- Make clients get information
        net.Start("SV_Capture")
            net.WriteInt( self.pointnumber, 8)
            net.WriteInt( self.ownerteam, 8)
            net.Broadcast()
        
    
    elseif inputName == "report" then
        print("[WARPATH]")
        print("Command Point #"..tostring(self.ownerteam))
        print("Currently controlled by "..team.GetName(self.ownerteam))
        print("[END]")
    
    end
    
end


function ENT:KeyValue(key, value)

	if key == "pointnumber" then
        self.pointnumber = tonumber(value )
        self:SetName("CAP_POINT_"..tostring(self.pointnumber))
        print("[DEBUG] [war_capture_zone] Capture Point #"..tostring(self.pointnumber).."\n")
    
	elseif key == "startteam" then
        self.ownerteam = tonumber(value)
        self:SetKeyValue("TeamNum", value)
        print("[DEBUG] [war_capture_zone] Setting start team to Team #"..tostring(self.ownerteam))
        
	elseif key == "angles" then
        self:SetAngles(util.StringToType(value, "Angle"))
    
	end
    
end

function ENT:StartTouch(ent)
    if ent:IsNPC() or ent:IsPlayer() then
        if ent:GetWarTeam() == self.ownerteam then
            self.occupied = true
            self.count = self.count + 1
            print("[DEBUG] ("..tostring(self:GetName())..") is now occupied.")
        end
    end
end

function ENT:EndTouch(ent)
    if ent:IsNPC() or ent:IsPlayer() then
        self.count = self.count - 1
        if self.count <= 0 then
            if ent:GetWarTeam() == self.ownerteam then
            self.occupied = false
            print("[DEBUG] ("..tostring(self:GetName())..") is now vacant.")
            end
        end
    end
end

function ENT:Touch(activator)
	
	if activator:IsNPC() then
    /*
        if activator:GetWarTeam() == self.ownerteam and self.last_command < CurTime() then
            AssaultPoint(activator)
            self.last_command = CurTime() + 5
            
        else*/
        if activator:GetWarTeam() ~= 5 then
            if !self.occupied then
            
                self:Input("capture", activator, activator, activator:GetWarTeam())
                SpawnpointChange() -- setup_npc.lua
                self.count = 1
                self.occupied = true
                
                for _,spwn in pairs (ents.FindByClass("war_npcspawner")) do
                    spwn:Input("change")
                end
                
                /*for _,spwn in pairs (ents.FindByClass("war_spawnpoint")) do
                    spwn:Input("change")
                end*/
                
                -- Sends the NPC to the next assault point
                timer.Simple(0.25, function() AssaultPoint(activator) end)
                
            end
            
        end
        
        
	end
    
end

function ENT:Think()

end

-- When captured, find all NPCs within it's radius and set them to AssaultPoint(npc)