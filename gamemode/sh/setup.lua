    
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
    
    if Ent:IsPlayer() then
        Ent:InstallDataTable()
        Ent:NetworkVar("Int",0,"Points")
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

    
	local teamcolor = {}
	
        teamcolor[1]= Color(40,40,255,225)    --blue
        teamcolor[2]= Color(255,40,40,255)   --red
        teamcolor[3]=Color(255,255,40,255)	  --yellow
        teamcolor[4]=Color(40,255,40,255)	  --green
        teamcolor[5]=Color(66, 244, 220,255) --cyan
		teamcolor[6]=Color(255, 140, 0,255)  --orange
		teamcolor[7]=Color(216, 0, 255, 255)  --magenta
		
		local teamcolor1 = math.random(1,7)
			print(teamcolor1)

		local teamcolor2 = math.random(1,7)
			print(teamcolor2)

			
		if (teamcolor2 == teamcolor1) then 
			teamcolor2 = math.random(1,7) 
			print(teamcolor2)
		
		end 
		print (teamcolor[teamcolor1])
		
		
    local teams = {
        {1,		"Team Alpha",	teamcolor[teamcolor1],	true,	"info_player_blue"},	
        {2,		"Team Bravo",	teamcolor[teamcolor2],	true,	"info_player_red"},		
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