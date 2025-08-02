--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local PlayerDataTypes = require(Types.playerDataTypes)

local PlayerDataClass = {}

local PlayerDataTemplate: PlayerDataTypes.PlayerDataTemplateType = {
	_DATAVERSION = 3,
	Inventory = {
		Food = {},
		Items = {},
	},
	Profile = {
		Level = 0,
		XP = 0,
		FoodDex = 0,
		LastLogin = function()
			local now = DateTime.now()
			return now.UnixTimestampMillis
		end
	},
	Upgrades = {
		LuckBoost = 0.00,
		Bonuses = {}
	},
	Timers = {}
}

return PlayerDataTemplate