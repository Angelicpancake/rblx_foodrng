--[[export type FoodObject = {
    Name: string,
    Rarity: string,
    Quantity: number,
    Instance: Folder?, --? means optional
}]]

local function createFoodObject(player: Player, name: string, rarity: string, Stars: number, quantity: number)
	local food = Instance.new("Folder", player:WaitForChild("Inventory"):WaitForChild("Food"))
	food.Name = name

	local rarityInstance = Instance.new("StringValue", food)
	rarityInstance.Name = "Rarity"
	rarityInstance.Value = rarity

	local quantityInstance = Instance.new("NumberValue", food)
	quantityInstance.Name = "Quantity"
	quantityInstance.Value = quantity

	local StarsInstance = Instance.new("NumberValue", food)
	StarsInstance.Name = "Stars"
	StarsInstance.Value = Stars

	print(`Gave {player.Name} {name} of rarity {rarity} with {Stars} Stars`)
end

return createFoodObject
