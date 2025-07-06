--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]
function givePlayer(foodName: StringValue, chance: StringValue, player: Player)
	local existingItem = player:WaitForChild("Inventory"):WaitForChild("Food"):FindFirstChild(foodName)
	local result = ``

	if existingItem then
		local quan = existingItem:FindFirstChild("Quantity")

		quan.Value += 1

		result = `Updated {player.Name} {foodName} +=1`
	else
		local food = Instance.new("Folder", player:WaitForChild("Inventory"):WaitForChild("Food"))
		food.Name = foodName

		local rarity = Instance.new("StringValue", food)
		rarity.Name = "Rarity"
		rarity.Value = chance

		local quantity = Instance.new("NumberValue", food)
		quantity.Name = "Quantity"
		quantity.Value = 1

		result = `Gave {player.Name} {foodName} of rarity {chance}`
	end
	return result
end

return givePlayer
