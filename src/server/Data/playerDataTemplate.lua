--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local PlayerDataTypes = require(Types.playerDataTypes)

local PlayerDataClass = {}

local PlayerDataTemplate: PlayerDataTypes.PlayerDataType = {
	_DATAVERSION = 3,
	Inventory = {
		Food = {},
		Items = {},
	},
	Profile = {
		Level = 0,
		XP = 0,
		FoodDex = 0,
	},
	Upgrades = {
		LuckBoost = 0.00,
		Bonuses = {}
	},
}

return PlayerDataTemplate