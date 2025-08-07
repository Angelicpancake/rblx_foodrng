local ServerScriptService = game:GetService("ServerScriptService")
--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]

local getPlayerMap = require(script.Parent.Parent.Data.playerDataMap)
local CreateItemObj = require(script.Parent.Parent.Foods.FoodUtil.itemObject)

local replicatedStorage = game:GetService("ReplicatedStorage")
local updateInventoryRemote = replicatedStorage.Events.Rng.UpdateInventory

function givePlayer(ItemName: string, player: Player)
	local PlayerMap = getPlayerMap.RuntimeGetPlayerData(player.UserId)
	local existingItem = PlayerMap.Inventory.Items[ItemName] ~= nil

	if existingItem then
		local ClientInventory = assert(player:FindFirstChild("Inventory"))
		local ItemOnPlayer = assert(ClientInventory:FindFirstChild("Items"):FindFirstChild(ItemName))
		--player map
		PlayerMap.Inventory.Food[ItemName].Quantity += 1

		local ClientQuantity = ItemOnPlayer:FindFirstChild("Quantity")

		ClientQuantity.Value = PlayerMap.Inventory.Food[ItemName].Quantity
	else
		--player map
		PlayerMap.Inventory.Items[ItemName] = {
			Quantity = 1,
		}

		local Quantity = 1

		CreateItemObj(player, ItemName, Quantity)
	end

	getPlayerMap.RuntimeSetPlayerData(player.UserId, PlayerMap)

	updateInventoryRemote:InvokeClient(player) --tell
end

return givePlayer
