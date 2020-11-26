-- Written by Boogagle(Boogle#4509)
-- 11/25/2020

local Main = {}
local MT = {}; MT.__index = Main

local self = {}

-- Services
local DSS = game:GetService("DataStoreService")



function Main.new(DatastoreName, KeyFormat)

	if not DatastoreName then warn("Please pass a DatastoreName when calling Module.new()") return end

	if not KeyFormat then warn("Please pass a KeyFormat when calling Module.new()") return end

	self.DS = DSS:GetDataStore(DatastoreName)
	self.KeyFormat = KeyFormat -- Used for key formatting, example: "UID_%s", which would be UID_123456789 the number being the UserId



	return setmetatable(self, MT)
end


function Main:LookUp(Player)
	local SyncedData = self.DS:GetAsync((self.KeyFormat):format(Player.UserId))

	return SyncedData
end

return Main