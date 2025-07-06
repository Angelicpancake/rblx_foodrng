local inventory = script.Parent.Parent.Parent.InventoryGui.Inventory
local nextButton = inventory.Next
local backButton = inventory.Back

local renderInven = require(script.Parent.inventoryRender)

local function pageInit(page: number, sort: string)
	nextButton.MouseButton1Click:Connect(function()
		if page < 15 then
			page += 1
			renderInven(sort, true, page)
		end
	end)

	backButton.MouseButton1Click:Connect(function()
		if page > 1 then
			page -= 1
			renderInven(sort, true, page)
		end
	end)

	return page
end

return pageInit
