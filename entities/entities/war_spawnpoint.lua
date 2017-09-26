
-- This defines where players can spawn

ENT.Type = "point"

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
            print("[DEBUG] Player Spawnpoint ("..tostring(zone:GetName()).." @ "..tostring(zone:GetPos())..") owned by team "..tostring(zone:GetKeyValues()["TeamNum"]).." is closer ("..tostring(new_distance)..") than previous ("..tostring(distance)..") zone.")
            self.nearest   = zone
            distance       = new_distance
            self.WarTeam   = zone:GetKeyValues()["TeamNum"]
        else
            print("[DEBUG] Player Spawnpoint ("..tostring(zone:GetName()).." @ "..tostring(zone:GetPos())..") was NOT closer ("..tostring(new_distance)..") than previous ("..tostring(distance)..") zone.")
        end
    end
    
    print("[WARPATH] Player Spawnpoint ("..tostring(self:GetName()).." @ "..tostring(self:GetPos())..") now belongs to "..team.GetName(self.WarTeam).." ("..tostring(self.WarTeam)..")")
    print("[WARPATH] Nearest Capture Point: "..tostring(self.nearest:GetName()).." @ "..tostring(self.nearest:GetPos()))
    
    self:SetKeyValue("TeamNum", self.WarTeam)
    self:SetName("SPAWN_"..tostring(self.nearest:GetName()))
    print("\n")
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