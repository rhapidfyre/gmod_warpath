
--Votemap

votemap = {}

function votemap.Nominate()
end

function votemap.RockTheVote()
end

function votemap.Endgame()
end

hook.Add("WP_MapVote", "CallMapVote", votemap.Endgame)