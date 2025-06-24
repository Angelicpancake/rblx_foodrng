--[[
    Player Data Structure:
        Inventory
            Food: Array Table
            Items: Dict Table: Int
        Profile
            Level: Int
            XP: Int
            FoodDex: Int
]]

local playerDataTemplate = {
	Inventory = {
		Food = {},
		Items = {},
	},
	Profile = {
		Level = 0,
		XP = 0,
		FoodDex = 0,
	},
}

return playerDataTemplate
