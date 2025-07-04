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

local foodData = require(replicatedStorage.Shared.Foods.FoodUtil.foodSource)

local foodPerPage = 12

local rarityRank = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Mythical = 6,
}

local function sortList(list: any, sorting: string)
	if sorting == "rarity" then
		table.sort(list, function(a, b)
			return rarityRank[foodData.foodList[a].rarity] > rarityRank[foodData.foodList[b].rarity]
		end)
	end
end

local function renderInventory(sorting: string, owned: boolean)
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

	local ownedSet = {}
	local foodList = foodData.foodList
	local ownedList = {}
	local unOwnedList = {}

	--folder name is the name so its not a dict table
	for _, ownedFood in pairs(inventoryData.Food:GetChildren()) do
		if not ownedSet[ownedFood.Name] then
			ownedSet[ownedFood.Name] = {}
		end

		ownedSet[ownedFood] = true
	end

	for foodName, info in pairs(foodList) do
		if ownedSet[foodName] then
			table.insert(ownedList, foodName)
		else
			table.insert(unOwnedList, foodName)
		end
	end

	sortList(ownedList, sorting)
	sortList(unOwnedList, sorting)

	local fullList = {}
	for _, item in ipairs(ownedList) do
		table.insert(fullList, item)
	end
	for _, item in ipairs(unOwnedList) do
		table.insert(fullList, item)
	end

	for i, foodItem in ipairs(fullList) do
		if i > foodPerPage then
			break
		end
		--print(foodItem.Name)

		local itemClone = template:Clone()
		itemClone.Name = foodItem
		itemClone.Visible = true

		itemClone.ItemImage.ItemRarity.Text = foodItem
		itemClone.Parent = inventoryFrame.Scroll
	end

	return ""
end

return renderInventory
