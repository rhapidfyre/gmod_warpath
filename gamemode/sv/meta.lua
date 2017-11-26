local meta = FindMetaTable("Player")
local npcm = FindMetaTable("NPC")

-- Sets the given upgrade to the given level
function meta:SetUpgrade(upname, uplevel)

	if self.uptable == nil then
		print("(DEBUG) Upgrade table was nil, creating.")
		self.uptable = {}
	end

	if self.uptable ~= nil then
		print("(DEBUG) Upgrade ["..upname.."] inserted, set to ("..uplevel..")")
		self.uptable[upname] = uplevel
	end
end

-- Wipes the upgrades table
function meta:ResetUpgrades()
	if IsValid(self.uptable) then table.Empty(self.uptable) end
	self.uptable = {}
end

-- Returns upgrade level, or 0 if they don't have it
function meta:GetUpgrade(upname)

	if self.uptable ~= nil then
		print("(DEBUG) Meta table exists, attempting upgrade.")
		local keyz = table.GetKeys(self.uptable)
		local flag = false
		
		if table.HasValue(keyz, upname) and keyz ~= nil then
			print("(DEBUG) Key exists, attempting increase.")
			local ret = self.uptable[upname]
			return ret
		else
			print("(DEBBUG) Key did not exist, returning zero as upgrade level.")
			return 0
		end
	else
		print("(DEBUG) Table does not exist!")
		return 0
	end
end

-- Sets the given upgrade to the given level
function npcm:SetUpgrade(upname, uplevel)
	if self.uptable == nil then
		print("(DEBUG) Upgrade table was nil, creating.")
		self.uptable = {}
	end

	if self.uptable ~= nil then
		print("(DEBUG) Upgrade ["..upname.."] inserted, set to ("..uplevel..")")
		self.uptable[upname] = uplevel
	end
end

-- Wipes the upgrades table
function npcm:ResetUpgrades()
	if IsValid(self.uptable) then table.Empty(self.uptable) end
	self.uptable = {}
end

-- Returns upgrade level, or 0 if they don't have it
function npcm:GetUpgrade(upname)

	if self.uptable ~= nil then
		print("(DEBUG) Meta table exists, attempting upgrade.")
		local keyz = table.GetKeys(self.uptable)
		local flag = false
		
		if table.HasValue(keyz, upname) and keyz ~= nil then
			print("(DEBUG) Key exists, attempting increase.")
			local ret = self.uptable[upname]
			return ret
		else
			print("(DEBBUG) Key did not exist, returning zero as upgrade level.")
			return 0
		end
	else
		print("(DEBUG) Table does not exist!")
		return 0
	end
end

-- Team() function overload for NPC entities
function npcm:Team()
	if IsValid(self) then return self:GetKeyValues()["TeamNum"]
	else 				  return 0
	end
end

-- SetTeam() function overload for NPC entities
function npcm:SetTeam(teamNum)
	if IsValid(self) then
		self:SetKeyValue("TeamNum", teamNum)
		self:SetNWInt("TeamNum", teamNum)
	end
end

