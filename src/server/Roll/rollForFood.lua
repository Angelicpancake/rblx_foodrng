--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Modules = ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):WaitForChild("FoodUtil")
local Workspace = game:GetService("Workspace")
--local foodList = require(modules:WaitForChild("foodList"))
local FoodList = require(Modules.foodSource)

--local WithinArea = require(ReplicatedStorage.Shared.Util.withinArea)

--[[ocal zones = {
	["Japan"] = Workspace:WaitForChild("Zones"):WaitForChild("Japan"),
}]]

local RarityList = require(Modules.rarityList)
table.sort(RarityList, function(a, b)
	return a.Weight >= b.Weight
end)

local GivePlayer = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Util").givePlayer)

local function GetRarity(LuckBoost: number)
	for i, RarityObj in ipairs(RarityList) do
		if i == #RarityList then
			break
		end--[[#RarityList]] -- then break end--skip common (default rarity)
		local Roll = math.random()
		local BaseChance = 1 / RarityObj.Weight
		if Roll < BaseChance * (1 + LuckBoost) then
			return RarityObj.Rarity
		end
	end

	return RarityList[#RarityList].Rarity --return common if all else fails
end

local function Roll(player: Player, LuckBoost: number, zone)
	print("Rolling With A Luckboost of", LuckBoost, "%")
	local Rarity = GetRarity(LuckBoost)
	--local TableByIndex = {}
	--[[for FoodName, Food in FoodList.foodByRarity[Rarity] do
        table.insert(TableByIndex, {FoodName = FoodName, Food = Food})
    end]]
	--print(FoodList.foodByRarity[Rarity])

	--[[if WithinArea(player, zones["Japan"], zones["Japan"].Size.X / 2) then
		print("hiadshfiaslfdsa")
	end]]
	local FoodEntry

	if zone == "none" then
		FoodEntry = FoodList.foodByRarity[Rarity][math.random(1, #FoodList.foodByRarity[Rarity])]
		print(FoodEntry)
		-- random food from foodList
	elseif zone == "Japan" then
		local len = #FoodList.foodByCountry["Japan"][Rarity] or 1
		print(len)
		print(FoodList.foodByCountry["Japan"][Rarity][math.random(1, len)])
		FoodEntry = FoodList.foodByCountry["Japan"][Rarity][math.random(1, len)]
	end

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
