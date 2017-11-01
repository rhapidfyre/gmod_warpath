local meta = FindMetaTable("Player")

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