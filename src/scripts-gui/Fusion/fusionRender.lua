--[[
    Fusion Render Module
    - request recipeList from server
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local FusionGui = Player.PlayerGui.FusionGui

local PreviewFrame = FusionGui.Fusion.PreviewFrame
local ScrollFrame = FusionGui.Fusion.Scroll
local RecipeFrame = PreviewFrame.RecipeFrame

local Template = ScrollFrame.Template
local Template2 = RecipeFrame.Template

local Fusion = {}
local Remotes = {}

type RecipeEntry = {
	--recipe hashmap: name, quantity, stars, rarity, image
	Food: { [string]: { quantity: number, stars: number, rarity: string, image: string, color: {} } },
	Image: string,
}

local RarityColor = {
	Common = Color3.fromRGB(113, 111, 109), --gray
	Uncommon = Color3.fromRGB(78, 132, 95), --green
	Rare = Color3.fromRGB(40, 70, 105), --blue
	Epic = Color3.fromRGB(71, 57, 87), --purple
	Legendary = Color3.fromRGB(198, 139, 44), --gold
	Mythical = Color3.fromRGB(137, 54, 71), --red
}

Fusion.clicked = function(fusionFood: string, info: RecipeEntry)
	for _, child in ipairs(RecipeFrame:GetChildren()) do
		if child:IsA("Frame") and child.Name ~= "Template" then
			child:Destroy()
		end
	end

	PreviewFrame.Visible = true
	PreviewFrame.Panel.ItemImage.Image = info.Image

	for name, v in pairs(info.Food) do
		local item = Template2:clone()
		item.Name = name
		item.Visible = true
		item.Parent = RecipeFrame

		item.ImageLabel.Image = v.image
		item.BackgroundColor3 = RarityColor[v.rarity]
		item.ImageLabel.ItemQuan.Text = v.quantity
	end
end

Remotes.GetRecipeList = ReplicatedStorage.Events.Fusion.GetRecipeList

Fusion.renderRecipes = function(player)
	PreviewFrame.Visible = false

	local recipeList: { [string]: RecipeEntry } = Remotes.GetRecipeList:InvokeServer(player)
	print(recipeList)

	--refresh the recipe templates
	for _, child in ipairs(ScrollFrame:GetChildren()) do
		if child:IsA("Frame") and child.Name ~= "Template" then
			child:Destroy()
		end
	end

	for fusionFood, info in pairs(recipeList) do
		local itemClone = Template:Clone()

		itemClone.Parent = ScrollFrame
		itemClone.Name = fusionFood
		itemClone.Visible = true

		itemClone.ItemImage.Image = info.Image
		itemClone.ItemImage.ItemName.Text = fusionFood

		itemClone.ItemImage.Click.MouseButton1Click:Connect(function()
			Fusion.clicked(fusionFood, info)
		end)
	end

	return recipeList
end

return Fusion
