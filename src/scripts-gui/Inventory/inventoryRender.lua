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

local inventoryFrame = script.Parent.Parent.Parent.InventoryGui.Inventory
local template = inventoryFrame.Scroll.Template

local Upgrade = require(script.Parent.Parent.Upgrade.upgradeDefaultButton)

local getFoodList = ReplicatedStorage.Events.Rng.GetFoodList
local foodData = getFoodList:InvokeServer() -- get foodlist from server
local inventoryData = player:WaitForChild("Inventory", 5)

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

local Preview = inventoryFrame.Parent.Preview
local BackButton = Preview.BackFrame.BackButton
local UpgradeButton = Preview.UpgradeFrame.UpgradeButton

local function openPreview(food: string)
	Preview.Visible = true
	UpgradeButton.Text = `UPGRADE`
	Preview.Frame.ImageLabel.Image = foodData.foodList[food].image
	for _, v in ipairs(Preview.Frame.Rarity:GetChildren()) do
		v.BackgroundColor3 = rarityColor[foodData.foodList[food].rarity]
	end

	Preview.BackgroundColor3 = rarityColor[foodData.foodList[food].rarity]

	BackButton.MouseButton1Click:Connect(function()
		Preview.Visible = false
	end)

	UpgradeButton.MouseButton1Click:Connect(function()
		local success = Upgrade.ButtonInit(food)
		if success == "success" then
			openPreview(food)
		end
	end)

	local currStars = inventoryData.Food:FindFirstChild(food).Stars.Value

	for i, info in ipairs(Preview.Stars:GetChildren()) do
		if info:IsA("ImageLabel") then
			if i > currStars + 1 then --first child is not an imagelabel
				info.ImageTransparency = 0.7
			else
				info.ImageTransparency = 0
			end
		end
	end

	Preview.Info:WaitForChild("Name").Text = food
	Preview.Info:WaitForChild("Origin").Text = `Origin: {foodData.foodList[food].country}`
	Preview.Info:WaitForChild("Quan").Owned.Text = `Owned: x{inventoryData.Food:FindFirstChild(food).Quantity.Value}`
	Preview.Info:WaitForChild("Quan").Upgrade.Text = `Upgrade: x{Upgrade.GetCost(food)}`

	if currStars == 5 then
		Preview.Info:WaitForChild("Quan").Upgrade.Text = `MAX 🔒`
		UpgradeButton.Text = `MAX 🔒`
	end
end

local function sortList(list: any, sorting: string)
	if sorting == "rarity" then
		table.sort(list, function(a, b)
			return rarityRank[foodData.foodList[a].rarity] > rarityRank[foodData.foodList[b].rarity]
		end)
	end
end

local function createClone(foodItem: string, ownedSet: { [any]: any }, inventoryData: any)
	local itemClone = template:Clone()
	itemClone.Name = foodItem
	itemClone.Visible = true

	itemClone.StarQuan.Text = " "
	itemClone.ImageLabel.Visible = false

	itemClone.Click.MouseButton1Click:Connect(function()
		if ownedSet[foodItem] then
			openPreview(foodItem)
		end
	end)

	local quan

	itemClone.ItemImage.ItemName.Text = foodItem

	if foodItem == "Tralalero Tralala Cappuccino Assassino" then
		itemClone.ItemImage.ItemName.Text = "Tralalero"
	end

	if ownedSet[foodItem] then
		quan = inventoryData.Food:FindFirstChild(foodItem).Quantity.Value

		itemClone.ItemImage.ImageTransparency = 0
		itemClone.ItemImage.ImageColor3 = Color3.new(255, 255, 255)
	else
		quan = 0
	end

	itemClone.Name = foodItem
	itemClone.ItemImage.ItemQuan.Text = `x{quan}`
	itemClone.Parent = inventoryFrame.Scroll
	itemClone.BackgroundColor3 = rarityColor[foodData.foodList[foodItem].rarity]
	itemClone.UIStroke.Color = rarityColor[foodData.foodList[foodItem].rarity]
	itemClone.ItemImage.Image = foodData.foodList[foodItem].image or "rbxassetid://0" -- Fallback to a default image if not found

	--star info
	if ownedSet[foodItem] then
		local stars = inventoryData.Food:FindFirstChild(foodItem).Stars.Value

		if stars > 0 then
			itemClone.StarQuan.Text = stars
			itemClone.ImageLabel.Visible = true
		end
	end
end

local function renderInventory(sorting: string, owned: boolean, currentPage: number, query: string)
	Preview.Visible = false
	local dexLabel = inventoryFrame.DexLabel
	print(`curr page {currentPage}`)
	-- print(`testing {inventoryData}`)

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

	dexLabel.Text = `Dex: {#ownedList}/72` --total food is 72 currently
	print(#ownedList)

	sortList(ownedList, sorting)
	sortList(unOwnedList, sorting)

	local fullList = {}
	for _, item in ipairs(ownedList) do
		table.insert(fullList, item)
	end
	for _, item in ipairs(unOwnedList) do
		table.insert(fullList, item)
	end

	if query == "" then
		--local startIndex = (currentPage - 1) * foodPerPage + 1
		--local endIndex = startIndex + foodPerPage - 1

		--	if endIndex > #fullList then
		--endIndex = #fullList
		--	end

		--	for i = startIndex, endIndex do
		--	local foodItem = fullList[i]
		--		createClone(foodItem, ownedSet, inventoryData)
		--	end
		for _, foodItem in ipairs(fullList) do
			createClone(foodItem, ownedSet, inventoryData)
		end
	else
		for _, foodItem in ipairs(fullList) do
			if string.find(string.lower(foodItem), query) then
				createClone(foodItem, ownedSet, inventoryData)
			end
		end
	end
end

return renderInventory
