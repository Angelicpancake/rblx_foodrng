local ServerScriptService = game:GetService("ServerScriptService")
--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]

local getPlayerMap = require(script.Parent.Parent.Data.playerDataMap)
local CreateFoodObj = require(script.Parent.Parent.Foods.FoodUtil.foodObject)
local UpdateFoodCollectionBonuses = require(ServerScriptService:WaitForChild("Server"):
	WaitForChild("Collection"):WaitForChild("General").collectionTotalFood)

local replicatedStorage = game:GetService("ReplicatedStorage")
local updateInventoryRemote = replicatedStorage.Events.Rng.updateInventory

function givePlayer(foodName: string, chance: string, player: Player)
	local PlayerMap = getPlayerMap.RuntimeGetPlayerData(player.UserId)
	local existingItem = PlayerMap.Inventory.Food[foodName] ~= nil
	local result = ``

	--print(PlayerMap)

	if existingItem then
		local FoodOnPlayer = player:FindFirstChild("Inventory"):FindFirstChild("Food"):FindFirstChild(foodName)
		--player map
		PlayerMap.Inventory.Food[foodName].Quantity += 1

		local ClientQuantity = FoodOnPlayer:FindFirstChild("Quantity")

		ClientQuantity.Value = PlayerMap.Inventory.Food[foodName].Quantity

		result = `Updated {player.Name} {foodName} +=1`
	else
		--player map
		PlayerMap.Inventory.Food[foodName] = {
			Quantity = 1,
			Rarity = chance,
			Stars = 0
		}
		PlayerMap.Profile.FoodDex += 1
		local TotalFood = PlayerMap.Profile.FoodDex
		UpdateFoodCollectionBonuses(TotalFood, player.UserId)

		local Stars = 0
		local Quantity = 1

		CreateFoodObj(player, foodName, chance, Stars, Quantity)
	end

	getPlayerMap.RuntimeSetPlayerData(player.UserId, PlayerMap)

	updateInventoryRemote:InvokeClient(player) --tell

	return result
end

return givePlayer
