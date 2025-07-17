--[[
    render inventory:

    clear existing inventory on start.
        For each child if the child is a frame and not template destory
        then loop data to add cloning
]]
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

local itemData = require(script.Parent.inventoryData)
local inventoryFrame = script.Parent.Parent.Parent.InventoryGui.Inventory
local template = inventoryFrame.Scroll.Template

local getFoodList = ReplicatedStorage.Events.Rng.GetFoodList
local foodData = getFoodList:InvokeServer() -- get foodlist from server

local foodPerPage = 12

local rarityRank = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Mythical = 6,
}

local rarityColor = {
	Common = Color3.fromRGB(113, 111, 109), --gray
	Uncommon = Color3.fromRGB(78, 132, 95), --green
	Rare = Color3.fromRGB(40, 70, 105), --blue
	Epic = Color3.fromRGB(71, 57, 87), --purple
	Legendary = Color3.fromRGB(198, 139, 44), --gold
	Mythical = Color3.fromRGB(137, 54, 71), --red
}

local function sortList(list: any, sorting: string)
	if sorting == "rarity" then
		table.sort(list, function(a, b)
			return rarityRank[foodData.foodList[a].rarity] > rarityRank[foodData.foodList[b].rarity]
		end)
	end
end

local function renderInventory(sorting: string, owned: boolean, currentPage: number)
	print(`curr page {currentPage}`)
	local inventoryData = player:WaitForChild("Inventory", 5)
	print(`testing {inventoryData}`)

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

	local startIndex = (currentPage - 1) * foodPerPage + 1
	local endIndex = startIndex + foodPerPage

	if endIndex > #fullList then
		endIndex = #fullList
	end

	for i = startIndex, endIndex do
		local foodItem = fullList[i]

		local itemClone = template:Clone()
		itemClone.Name = foodItem
		itemClone.Visible = true

		local quan

		if ownedSet[foodItem] then
			quan = inventoryData.Food:FindFirstChild(foodItem).Quantity.Value
		else
			quan = 0
		end

		itemClone.ItemImage.ItemName.Text = foodItem
		itemClone.ItemImage.ItemQuan.Text = `X{quan}`
		itemClone.Parent = inventoryFrame.Scroll
		itemClone.BackgroundColor3 = rarityColor[foodData.foodList[foodItem].rarity]
		itemClone.ItemImage.Image = foodData.foodList[foodItem].image or "rbxassetid://0" -- Fallback to a default image if not found
	end
end

return renderInventory
