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
local Template = ScrollFrame.Template

print(Template)

local Fusion = {}
local Remotes = {}

type RecipeEntry = {
	--recipe hashmap: name, quantity, stars, rarity, image
	Food: { [string]: { quantity: number, stars: number, rarity: string, image: ImageLabel } },
	Image: ImageLabel,
}

Remotes.GetRecipeList = ReplicatedStorage.Events.Fusion.GetRecipeList

Fusion.renderRecipes = function(player)
	PreviewFrame.Visible = false

	local recipeList: { [string]: RecipeEntry } = Remotes.GetRecipeList:InvokeServer(player)

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
	end

	return recipeList
end

return Fusion
