local InventoryGui = script.Parent.Parent.Parent.InventoryGui
local SearchBox = InventoryGui.Inventory.Search.SearchBox
local renderInven = require(script.Parent.inventoryRender)

function updateSearch()
	renderInven("Rarity", true, 1, SearchBox.Text:lower())
end

return updateSearch

--SearchBox:GetPropertyChangedSignal("Text"):Connect(updateSearch)
