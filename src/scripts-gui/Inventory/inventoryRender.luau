--[[
    render inventory:

    clear existing inventory on start.
        For each child if the child is a frame and not template destory
        then loop data to add cloning
]]
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

local itemData = require(script.Parent.inventoryData)
local inventoryFrame = script.Parent.Parent.Parent.InventoryGui.Inventory
local template = inventoryFrame.Scroll.Template

local foodPerPage = 12

local function renderInventory()
	local inventoryData = player:WaitForChild("Inventory", 5)
	if not inventoryData then
		warn("No Inventory Folder within timeout")
		return
	end

	--clear exisitng inventory
	for _, child in ipairs(inventoryFrame.Scroll:GetChildren()) do
		if child:IsA("Frame") and child.Name ~= "Template" then
			child:Destroy()
		end
	end

	for i, foodItem in ipairs(inventoryData.Food:GetChildren()) do
		if i > foodPerPage then
			break
		end
		--print(foodItem.Name)

		local itemClone = template:Clone()
		itemClone.Name = foodItem.Name
		itemClone.Visible = true

		itemClone.ItemImage.ItemRarity.Text = foodItem.Name
		itemClone.Parent = inventoryFrame.Scroll
	end

	return ""
end

return renderInventory()
