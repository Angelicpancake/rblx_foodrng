--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]

local getPlayerMap = require(script.Parent.Parent.Data.playerDataMap)
local foodObj = require(script.Parent.Parent.Foods.FoodUtil.foodObject)

local replicatedStorage = game:GetService("ReplicatedStorage")
local updateInventoryRemote = replicatedStorage.Events.Rng.updateInventory

function givePlayer(foodName: string, chance: string, player: Player)
	local PlayerMap = getPlayerMap.RuntimeGetPlayerData(player.UserId)
	local existingItem = player:WaitForChild("Inventory"):WaitForChild("Food"):FindFirstChild(foodName)
	local result = ``

	--print(PlayerMap)

	if existingItem then
		--player map
		PlayerMap.Inventory.Food[foodName].Quantity += 1

		local quan = existingItem:FindFirstChild("Quantity")

		quan.Value += 1

		result = `Updated {player.Name} {foodName} +=1`
	else
		--player map
		PlayerMap.Inventory.Food[foodName] = {}
		local food = PlayerMap.Inventory.Food[foodName]
		food.Quantity = 1
		food.Rarity = chance

		foodObj(player, foodName, chance, 1)
	end

	getPlayerMap.RuntimeSetPlayerData(player.UserId, PlayerMap)

	updateInventoryRemote:InvokeClient(player) --tell

	return result
end

return givePlayer
