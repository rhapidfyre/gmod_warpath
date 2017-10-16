
	-- Custom ENUMS
	ROUND_STALE 	= 0
	ROUND_ACTIVE 	= 1
	ROUND_PREP	 	= 2
	ROUND_END		= 3
	
	TIME_PREP		= 8			-- Time to prepare, in seconds
	TIME_ROUND		= 300		-- Time per round, in seconds
	TIME_END		= 12		-- Time after round concludes until next prep round
	
	MAX_ROUNDS		= 10		-- Max rounds until map change
	MAX_TIME		= 1800		-- Max time until map change
	FOREVER_GAME	= true		-- If true, max round/time will be ignored
    
	--[[
	
		For the next section, all points are to be in EXACT VALUES
		
		Meaning, if you want something such as a suicide to TAKE points
		then you MUST give it a NEGATIVE value.
		
		Setting POINT_SUICIDE to 5 will AWARD the player with 5 points if they suicide
	
	]]
	
    -- POINTS GIVEN FOR UPGRADES (INDIVIDUAL UPGRADES)
	-- These points are given to the PLAYER'S pool when they occur
    POINT_CAPTURE       = 1		-- Player captures a control point
    POINT_KILL          = 1		-- Player kills enemy Player
    POINT_KILL_NPC      = 1		-- Player kills enemy NPC
    POINT_DIE			= 1		-- Player dies (any method)
    POINT_SUICIDE		= 1		-- Player killed themselves
    POINT_WIN			= 1		-- Player captures the final control point & wins
	
	-- POINTS GIVEN FOR UPGRADES (TEAM UPGRADES)
	-- These points are given to the TEAM UPGRADE pool when they occur
	POINT_CAPTURE_NPC	= 1		-- NPC Captures Control Point
    POINT_WIN_NPC		= 1		-- NPC Captures the final control point & wins
	POINT_NPC_KILL_NPC	= 1		-- 
	
	-- POINTS GIVEN TO TEAM UPGRADES AND PLAYER UPGRADES
	-- These points are given to both the individual player AND the team pools
    POINT_TEAM_LOSE		= 1		-- Team Loses
	POINT_TEAM_WIN		= 1		-- Team Wins
	POINT_TEAM_DEATH	= 1		-- Player Dies (any method)
	POINT_TEAM_NPCDEAD	= 1		-- NPC Dies (any method)
	POINT_TEAM_KILL		= 1		-- Enemy player dies (any method)
	POINT_TEAM_KILLNPC	= 1		-- Enemy NPC Dies (any method)
	
	-- SCORE GIVEN TO TEAM'S OVERHEAD SCORE
	-- This is just for team based gameplay score keeping
	SCORE_CAPTURE		= 1		-- Points given when team member captures a point
	SCORE_WIN			= 10	-- Points given to TEAM_SCORE when team wins
	SCORE_LOSE			= 0		-- Points given to TEAM SCORE when team loses
	SCORE_KILL			= 1		-- Points given to TEAM SCORE when enemy PC is killed
	SCORE_KILLNPC 		= 1		-- Points given to TEAM SCORE when enemy NPC is killed
	
	
	
	
	
	
	
	
	