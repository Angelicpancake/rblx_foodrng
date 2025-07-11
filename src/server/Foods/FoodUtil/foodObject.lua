--[[export type FoodObject = {
    Name: string,
    Rarity: string,
    Quantity: number,
    Instance: Folder?, --? means optional
}]]

local function createFoodObject(player: Player, name: string, rarity: string, quantity: number)
	local food = Instance.new("Folder", player:WaitForChild("Inventory"):WaitForChild("Food"))
	food.Name = name

	local rarityInstance = Instance.new("StringValue", food)
	rarityInstance.Name = "Rarity"
	rarityInstance.Value = rarity

	local quantityInstance = Instance.new("NumberValue", food)
	quantityInstance.Name = "Quantity"
	quantityInstance.Value = quantity

	print(`Gave {player.Name} {name} of rarity {rarity}`)
end

return createFoodObject
