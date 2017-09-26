    
--[[---------------------------------------------------------
   Name: OnEntityCreated
   Desc: Called right after the Entity has been made visible to Lua
-----------------------------------------------------------]]
function GM:OnEntityCreated( Ent )

    -- Removes client-side Ragdolls
	if CLIENT then
	if Ent:GetClass() == "class C_ClientRagdoll" then
		Ent:Remove()
	end
	end
    
    -- If Ent is an NPC, set up WarTeam variable (checks NPC's team)
    if Ent:IsNPC() then
		Ent:InstallDataTable()
		Ent:NetworkVar("Int",0,"WarTeam")
        
    end
end

--[[---------------------------------------------------------
   Name: gamemode:CreateTeams()
-----------------------------------------------------------]]
function GM:CreateTeams()

	-- Don't do this if not teambased. But if it is teambased we
	-- create a few teams here as an example. If you're making a teambased
	-- gamemode you should override this function in your gamemode

	if ( !GAMEMODE.TeamBased ) then return end

    local teams = {
        {1,		"Blue Team",	Color(40,40,255,225),	true,	"info_player_blue"},	
        {2,		"Red Team",	    Color(255,40,40,255),	true,	"info_player_red"},		
        {3,		"Yellow Team",	Color(255,255,40,255),	false,	"info_player_yellow" },	
        {4,		"Green Team",	Color(40,255,40,255),	false,	"info_player_green" },	
        {5,		"Neutral Team",	Color(255,255,255,255),	false,	"info_player_deathmatch" }
    }
    
    for n,r in pairs(teams) do
        --          #,name,color,joinable
        team.SetUp( n, r[2], r[3], r[4] )
        team.SetSpawnPoint(n,r[5])
    end

end