-- SquirrelPlus Punish Module, the name of this is not final, just off the top of my head. Mainly a table full of useful functions for datastores and handling players strikes/warnings.
-- Written by Boogagle(Boogle#4509)
-- 11/25/2020 

-- My current idea for strikes is basically you hit a certain number of strikes, and a punishment according to a user table is applied to a user's Datastore account thing ok. :)


local Main = {}
local MT = {}; MT.__index = Main

local self = {}

-- Services
local DSS = game:GetService("DataStoreService")

Main.PunishmentFunctions = {
	['Ban'] = function(Player)
		
		local UserData = Main:LookUp(Player)

		UserData['Banned'] = true

		self.DS:SetAsync(Main:KeyFormat(Player), UserData)

	end,

	['Kick'] = function(Player)
		
		local UserData = Main:LookUp(Player)


		if type(UserData['KickCount']) == 'number' then
			UserData['KickCount'] += 1
		else
			UserData['KickCount'] = 1
		end
		

		self.DS:SetAsync(Main:KeyFormat(Player), UserData)

	end

}

Main.PlayerTable = {
	['Banned'] = false,
	['KickCount'] = 0,
	['Strikes'] = 0,

}

function Main:KeyFormat(Player)
	
	return (self.KeyFormat):format(Player.UserId)
end


function Main.new(DatastoreName, KeyFormat, Punishments)

	if not DatastoreName then warn("Please pass a DatastoreName when calling Module.new()") return end

	if not KeyFormat then warn("Please pass a KeyFormat when calling Module.new()") return end

	if not Punishments then warn("Please pass a Punishments table when calling Module.new()") return end

	self.DS = DSS:GetDataStore(DatastoreName)
	self.DatastoreName = DatastoreName
	self.KeyFormat = KeyFormat -- Used for key formatting, example: "UID_%s", which would be UID_123456789 the number being the UserId
	self.PunishTable = Punishments

	return setmetatable(self, MT)
end


function Main:LookUp(Player)
	local SyncedData = self.DS:GetAsync(Main:KeyFormat(Player))

	if not SyncedData then self.DS:SetAsync(Main:KeyFormat(Player), Main.PlayerTable) end

	if SyncedData['Banned'] then Player:Kick("You are banned from this game.") return end
 
	
	return SyncedData, Main:KeyFormat(Player)
end

function Main:Punish(Player)
	local Data = Main:LookUp(Player)

	if Data then
		local Strikes = Data['Strikes']
	end
	
end


return Main