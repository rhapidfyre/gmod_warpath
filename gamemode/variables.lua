
	-- Custom ENUMS
	ROUND_STALE 		= 0
	ROUND_ACTIVE 		= 1
	ROUND_PREP	 		= 2
	ROUND_END			= 3
		
	TIME_PREP			= 8			-- Time to prepare, in seconds
	TIME_ROUND			= 600		-- Time per round, in seconds
	TIME_END			= 3			-- Time after round concludes until next prep round
		
	MAX_ROUNDS			= 10		-- Max rounds until map change
	MAX_TIME			= 1800		-- Max time until map change
	FOREVER_GAME		= true		-- If true, max round/time will be ignored
    
	-- POINT VALUES
	-- Points are used for individual & team upgrades
	
    POINT_START         = 10       -- Points that teams start with each round
    POINT_TIME          = 1        -- Points awarded every X seconds PER CONTROL POINT OWNED
	POINT_DIST			= 10	   -- Time between POINT_TIME awards (recommended to be more than 10)
    
    POINT_CAPTURE       = 1        -- Player captures a control point
    POINT_CAPTURE_NPC   = 1        -- NPC Captures Control Point
    
    POINT_DEAD_NPC      = 1        -- NPC Dies (Any method)
    POINT_DEAD_PLY      = 1        -- Player Dies (Any method)
    POINT_KILL_PLY      = 1        -- Extra point for player killing player

    POINT_SUICIDE       = -1       -- Points given for killing self
    POINT_DEATH         = 0        -- Points given for dying
    
	
    -- SCORE GIVEN TO TEAM'S OVERHEAD SCORE
    -- This is just for team based gameplay score keeping
	-- Does not affect points/upgrades
	
    SCORE_CAPTURE       = 10       -- Points given when team member captures a point
    SCORE_WIN           = 50       -- Points given to TEAM_SCORE when team wins
    SCORE_LOSE          = -10      -- Points given to TEAM SCORE when team loses
    SCORE_KILL          = 1        -- Points given to TEAM SCORE when enemy PC is killed
    SCORE_KILLNPC       = 1        -- Points given to TEAM SCORE when enemy NPC is killed
