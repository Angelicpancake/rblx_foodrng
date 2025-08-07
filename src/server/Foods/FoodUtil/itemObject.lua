local function createItemObject(player: Player, name: string, quantity: number)
	local Item = Instance.new("Folder", player:WaitForChild("Inventory"):WaitForChild("Items"))
	Item.Name = name

	local quantityInstance = Instance.new("NumberValue", Item)
	quantityInstance.Name = "Quantity"
	quantityInstance.Value = quantity
end

return createItemObject