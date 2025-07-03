--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]
function givePlayer(foodName: StringValue, chance: StringValue, player: Player)
	local food = Instance.new("Folder", player:WaitForChild("Inventory"):WaitForChild("Food"))
	food.Name = foodName

	local rarity = Instance.new("StringValue", food)
	rarity.Name = "Rarity"
	rarity.Value = chance

	local result = `Gave {player.Name} {foodName} of rarity {chance}`
	return result
end

return givePlayer
