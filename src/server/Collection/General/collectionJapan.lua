--!strict
local ServerScriptService = game:GetService("ServerScriptService")

local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local BonusDataTypes = require(Types.bonusDataTypes)

type FoodBonusType = {
    { Threshold: number, Bonus: BonusDataTypes.BonusDataType, Rewards: {}?}
}

local FoodBonuses: FoodBonusType = {
    { Threshold = 5, Bonus = { Name = "JapanFood25", Luck = 0.1, Stackable = false } }
}

return FoodBonuses