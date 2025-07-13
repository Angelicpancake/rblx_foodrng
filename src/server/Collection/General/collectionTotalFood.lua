--!strict
local ServerScriptService = game:GetService("ServerScriptService")

local Util = ServerScriptService:WaitForChild("Server"):WaitForChild("Util")
local GivePlayerBonus = require(Util.givePlayerBonus)

local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local PlayerDataTypes = require(Types.playerDataTypes)
local BonusDataTypes = require(Types.bonusDataTypes)

type FoodBonusType = {
    { Threshold: number, Bonus: BonusDataTypes.BonusDataType, Rewards: {}?}
}

local FoodBonuses: FoodBonusType = {
    { Threshold = 175, Bonus = { Name = "TotalFood175", Luck = 0.4, Stackable = false } },
    { Threshold = 150, Bonus = { Name = "TotalFood150", Luck = 0.3, Stackable = false } },
    { Threshold = 125, Bonus = { Name = "TotalFood125", Luck = 0.3, Stackable = false } },
    { Threshold = 100, Bonus = { Name = "TotalFood100", Luck = 0.2, Stackable = false } },
    { Threshold = 75, Bonus = { Name = "TotalFood75", Luck = 0.2, Stackable = false } },
    { Threshold = 50, Bonus = { Name = "TotalFood50", Luck = 0.1, Stackable = false } },
    { Threshold = 25, Bonus = { Name = "TotalFood25", Luck = 0.1, Stackable = false } }
}

local function UpdateFoodCollectionBonuses(TotalFoods: number, UserId: string)
    print(TotalFoods)
    for _, FoodBonus in FoodBonuses do
        if TotalFoods == FoodBonus.Threshold then
            GivePlayerBonus(FoodBonus.Bonus, UserId)
            break
        end
    end
end

return UpdateFoodCollectionBonuses