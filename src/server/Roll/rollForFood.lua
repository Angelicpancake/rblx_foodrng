--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local Modules = ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):WaitForChild("FoodUtil")

--local foodList = require(modules:WaitForChild("foodList"))
local FoodList = require(Modules.foodSource)

local RarityList = require(Modules.rarityList)
table.sort(RarityList, function(a, b)
    return a.Weight >= b.Weight
end)

local GivePlayer = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Util").givePlayer)

local function GetRarity(LuckBoost: number)
    for i, RarityObj in ipairs(RarityList) do
        if i == #RarityList then break end--[[#RarityList]]-- then break end--skip common (default rarity)
        local Roll = math.random()
        local BaseChance = 1 / RarityObj.Weight
        if Roll < BaseChance * (1 + LuckBoost) then
            return RarityObj.Rarity
        end
    end

    return RarityList[#RarityList].Rarity --return common if all else fails
end


local function Roll(player: Player, LuckBoost: number)
    print("Rolling With A Luckboost of", LuckBoost, "%")
    local Rarity = GetRarity(LuckBoost)
    local TableByIndex = {}
    for FoodName, Food in FoodList.foodByRarity[Rarity] do
        table.insert(TableByIndex, {FoodName = FoodName, Food = Food})
    end
    local FoodEntry = TableByIndex[math.random(1, #TableByIndex)]
    print(FoodEntry)
    -- random food from foodList

    GivePlayer(FoodEntry.FoodName, Rarity, player)
    return FoodEntry
end

-- local function RollTest()
--     task.spawn(function()
--         local resTable = {}
--         for i = 1, 1000000, 1 do
--             local res = GetRarity(2)
--             resTable[res] = (resTable[res] or 0) + 1
--         end
--         print(resTable)
--     end)
-- end

return Roll