--[[
	Fusion UI Handler Module
	--Render Fusion
]]
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local FusionRender = require(script.Parent.fusionRender)
local FusionDefaultButton = require(script.Parent.fusionDefaultButton)

local Fusion = {}
Fusion.RecipeList = {}

local function FusionInit(player)
	FusionDefaultButton()
	--Fusion.RecipeList = FusionRender.renderRecipes(player)
	--	print(Fusion.RecipeList)
end

return FusionInit
