--[[
    Fusion Render Module
    - request recipeList from server
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FusionGui = game:GetService("StarterGui").FusionGui

local Fusion = {}
local Remotes = {}

Remotes.GetRecipeList = ReplicatedStorage.Events.Fusion.GetRecipeList

Fusion.renderRecipes = function(player)
	local recipeList = Remotes.GetRecipeList:InvokeServer(player)

	return recipeList
end

return Fusion
