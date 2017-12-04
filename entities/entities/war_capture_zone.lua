
-- This controls capture points
local TIME_COOLDOWN = 30

ENT.Type = "brush"

function ENT:Initialize()

	--self:SetName("CAP_POINT_"..self:MapCreationID())
    self:SetTrigger(true)
	self.occupied = false
    self.count = 0
    self.last_command = CurTime()
    self.cooldown = CurTime()
    
end

function ENT:AcceptInput(inputName, activator, called, data)

	if inputName == "capture" then
    
        self.ownerteam = data
        self:SetKeyValue("TeamNum", data)
        SetGlobalInt("CmdPoint"..self.pointnumber, self.ownerteam)
        self.cooldown = CurTime() + TIME_COOLDOWN
        
        -- Changes the cooresponding spawn points
        for _,spawn in pairs (ents.FindByClass("war_spawnpoint")) do
            if spawn:GetName() == "SPAWN_"..tostring(self:GetName()) then
                spawn:Input("change")
            end
        end
        for _,spawn in pairs (ents.FindByClass("war_ammosupply")) do
            if spawn:GetName() == "Crate_"..tostring(self:GetName()) then
                spawn:Input("change")
            end
        end
        
        --------------------------------------------------------------
        -- Checks upon capture if all command points are controlled --
        --------------------------------------------------------------
        local capzones = ents.FindByClass("war_capture_zone")
        local counter = 0
        for _,zone in pairs (capzones) do
            if zone:GetKeyValues()["TeamNum"] == self.ownerteam then
                counter = counter + 1            
            end
        end
        
        if counter >= #capzones then
        
            round.Victory(self.ownerteam)
            net.Start("SV_Victory")
                net.WriteInt(self.ownerteam, 8)
                net.Broadcast()
        else
        
            -- Issues points to NPC or Player based on who captured it
            if activator:IsNPC() then SetGlobalInt("WP_T"..(self.ownerteam).."Points", GetGlobalInt("WP_T"..(self.ownerteam).."Points") + POINT_CAPTURE_NPC)
            else                      SetGlobalInt("WP_T"..(self.ownerteam).."Points", GetGlobalInt("WP_T"..(self.ownerteam).."Points") + POINT_CAPTURE)
            end
        
            net.Start("SV_Capture")
                net.WriteInt( self.pointnumber, 8)
                net.WriteInt( self.ownerteam, 8)
                net.Broadcast()
        end -----------------------------------------------------------
        
    
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
    
	elseif key == "startteam" then
        self.ownerteam = tonumber(value)
        self:SetKeyValue("TeamNum", value)
        
	elseif key == "angles" then
        self:SetAngles(util.StringToType(value, "Angle"))
    
	end
    
end

function ENT:StartTouch(ent)
    if ent:IsNPC() or ent:IsPlayer() then
    
        local entTeam = nil
        if ent:IsPlayer() then entTeam = ent:Team()
        elseif ent:IsNPC() then entTeam = ent:Team() end
        
        if entTeam == self.ownerteam then
            self.occupied = true
            self.count = self.count + 1
        end
        
    end
end

function ENT:EndTouch(ent)
    if ent:IsNPC() or ent:IsPlayer() then
        self.count = self.count - 1
        if self.count <= 0 and IsValid(ent) then
        
            local entTeam = nil
            if ent:IsPlayer() then entTeam = ent:Team()
            elseif ent:IsNPC() then entTeam = ent:Team() end
            
            if entTeam == self.ownerteam then
            self.count = 0
            self.occupied = false
            end
            
        end
    end
end

local function Capture(activator, self)
	if activator:IsNPC() then
		/*
			if activator:Team() == self.ownerteam and self.last_command < CurTime() then
				AssaultPoint(activator)
				self.last_command = CurTime() + 5
				
			else*/
			if ((activator:Team() > 0 and activator:Team() < 3) and (activator:Team() ~= self.ownerteam)) then
				if !self.occupied then
					if self.cooldown < CurTime() then
						self:Input("capture", activator, activator, activator:Team())
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
						activator:SetNWBool("HasGoal", false)
						timer.Simple(0.25, function()
							AssaultPoint(activator)
						end)
						
					else
						activator:SetSchedule(SCHED_ALERT_STAND)
					
					end
				end
				
			end
		--[[
		elseif activator:IsPlayer() then
			local args1 = {}
				args1[1] = me.occupied
				args1[2] = me.ownerteam
				args1[3] = ply
				args1[4] = me
				
			hook.Call("war_plycap", args1)
			]]
		end 
		
end

function ENT:Touch(activator)
	
	Capture(activator, self)
    
end

function ENT:Think()

end

-- When captured, find all NPCs within it's radius and set them to AssaultPoint(npc)