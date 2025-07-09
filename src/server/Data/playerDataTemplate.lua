--!strict
local PlayerDataTypes = require(script.Parent.playerDataTypes)

local playerDataTemplate: PlayerDataTypes.PlayerDataType = {
	_DATAVERSION = 1,
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
		LuckBoost = 0.00
	}
}

return playerDataTemplate