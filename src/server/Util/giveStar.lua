local ServerScriptService = game:GetService("ServerScriptService")
--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]

local getPlayerMap = require(script.Parent.Parent.Data.playerDataMap)
local CreateFoodObj = require(script.Parent.Parent.Foods.FoodUtil.foodObject)
local UpdateFoodCollectionBonuses = require(
	ServerScriptService:WaitForChild("Server"):WaitForChild("Collection"):WaitForChild("General").collectionTotalFood
)

local replicatedStorage = game:GetService("ReplicatedStorage")
local updateInventoryRemote = replicatedStorage.Events.Rng.UpdateInventory

function giveStar(foodName: string, quan: string, player: Player)
	local PlayerMap = getPlayerMap.RuntimeGetPlayerData(player.UserId)

	local ClientInventory = assert(player:FindFirstChild("Inventory"))
	local FoodOnPlayer = assert(ClientInventory:FindFirstChild("Food"):FindFirstChild(foodName))
	--player map
	PlayerMap.Inventory.Food[foodName].Quantity = quan
	PlayerMap.Inventory.Food[foodName].Stars += 1

	local ClientQuantity = FoodOnPlayer:FindFirstChild("Quantity")
	ClientQuantity.Value = PlayerMap.Inventory.Food[foodName].Quantity

	local ClientStars = FoodOnPlayer:FindFirstChild("Stars")
	ClientStars.Value = PlayerMap.Inventory.Food[foodName].Stars

	local result = `Updated {player.Name} {foodName} +=1star`

	getPlayerMap.RuntimeSetPlayerData(player.UserId, PlayerMap)

	updateInventoryRemote:InvokeClient(player) --tell

	return result
end

return giveStar
