
-- This defines where players can spawn

ENT.Type = "point"

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
    
    self:SetKeyValue("TeamNum", self.WarTeam)
    self:SetName("SPAWN_"..tostring(self.nearest:GetName()))
end

function ENT:Initialize()

    self.radius = 0
    
    timer.Simple(1, function()
        self:EstablishTeam()
    end)
end
    
function ENT:AcceptInput(inputName, activator, called, data)
    if inputName == "change" then
        self:EstablishTeam()
	end
end