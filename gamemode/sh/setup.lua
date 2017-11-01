    
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
        print("INSTALLING PLAYER DATA TABLES............")
        Ent:InstallDataTable()
        Ent:NetworkVar("Int",0,"Points")
        Ent:NetworkVar("Bool",0,"HasAR2")
        Ent:NetworkVar("Bool",1,"HasBow")
        Ent:NetworkVar("Bool",2,"HasShotty")
        Ent:NetworkVar("Bool",3,"HasFrag")
        
        Ent:SetPoints(0)
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
	teamcol1 = color_white
	teamcol2 = color_white
	if SERVER then
		local tcol1 = {}
			tcol1[1]= Color(40,40,255,225)    --blue
			tcol1[2]= Color(40,255,40,255)    --green
			tcol1[3]= Color(66, 244, 220,255) --cyan
			tcol1[4]= Color(216, 0, 255, 255)  --magenta
		
		local tcol2 = {}
			tcol2[1]= Color(255,40,40,255)   --red
			tcol2[2]= Color(255,255,40,255)   --yellow
			tcol2[3]= Color(255, 140, 0,255)  --orange
			tcol2[4] = Color(76, 47, 12, 255) --brown

		local tc1 = math.random(1,4)
		local tc2 = math.random(1,4)

			local veccy1 = Vector(tcol1[tc1].r/255,tcol1[tc1].g/255,tcol1[tc1].b/255)
			local veccy2 = Vector(tcol2[tc2].r/255,tcol2[tc2].g/255,tcol2[tc2].b/255)
			SetGlobalVector("TCol1", veccy1)
			SetGlobalVector("TCol2", veccy2)
			teamcol1 = tcol1[tc1]
			teamcol2 = tcol2[tc2]
			
			AssignTeams(teamcol1, teamcol2)
	end
	if CLIENT then
		timer.Simple(.01, function()
			teamcol1 = GetGlobalVector("TCol1"):ToColor()
			teamcol2 = GetGlobalVector("TCol2"):ToColor()
			print(teamcol1)
			print(teamcol2)
			
			AssignTeams(teamcol1, teamcol2)
		end)
	else
	end
end
function AssignTeams(teamcol1, teamcol2)
	
		local teamname1 = {"Impact", "Aurora",
		"Fatal", "Royal", "Aftermath", "Alpha"}
		
		local teamname2 = {"Havoc", "Reign",
		"Shadow", "Omega", "Cyclone", "Indigo"}
	
		local teams = {
			{1,		"Team "..table.Random(teamname1),	teamcol1,	true,	"info_player_blue"},	
			{2,		"Team "..table.Random(teamname2),	teamcol2,	true,	"info_player_red"},		
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