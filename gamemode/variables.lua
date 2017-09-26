
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