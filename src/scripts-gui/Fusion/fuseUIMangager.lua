local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)

local Players = game:GetService("Players")
local FusionGui = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FusionGui")
local RecipeList = FusionGui:WaitForChild("MainFrame"):WaitForChild("RecipeList")

local Events = ReplicatedStorage:WaitForChild("Events")
local fuseEvents = Events:WaitForChild("Fusion")

local FuseSelectionInit = require(script.Parent.fuseSelect)
local GenerateRecipeListInit = require(script.Parent.generateRecipeList)

local function fusionInit()
	local FuseSelectTrove = FuseSelectionInit()

	GenerateRecipeListInit(fuseEvents:WaitForChild("GetRecipeList"), RecipeList,
		ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates"):WaitForChild("RecipeTemplate"))

	local function CleanupFusion()
		FuseSelectTrove:Clean()
	end

	return CleanupFusion
end

return fusionInit