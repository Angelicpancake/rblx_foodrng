local ServerScriptService = game:GetService("ServerScriptService")

local Util = ServerScriptService:WaitForChild("Server"):WaitForChild("Util")
local GivePlayerBonus = require(Util.givePlayerBonus)

local TotalFoodBonuses = require(script.Parent.collectionTotalFood)
local JapanFoodBonuses = require(script.Parent.collectionJapan)

local Bonuses = {
    ["Japan"] = JapanFoodBonuses
}

local function UpdateFoodCollectionBonuses(TotalFoods: number, UserId: number, Category: string)
    --food bonus for general collection
    for _, FoodBonus in TotalFoodBonuses do
        if TotalFoods == FoodBonus.Threshold then
            GivePlayerBonus(FoodBonus.Bonus, UserId)
            break
        end
    end

    --food bonus for category
    if Bonuses[Category] then
        for _, FoodBonus in Bonuses[Category] do
            if TotalFoods == FoodBonus.Threshold then
                GivePlayerBonus(FoodBonus.Bonus, UserId)
                break
            end
        end
    end
end

return UpdateFoodCollectionBonuses