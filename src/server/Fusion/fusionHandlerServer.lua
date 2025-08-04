--[[
    handle fusion scripts on server
    - event that triggers returnning table of recipes
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = {}
Events.GetRecipeList = ReplicatedStorage.Events.Fusion.GetRecipeList
Events.FusionRequest = ReplicatedStorage.Events.Fusion.FusionRequest

local CreateRecipeEntries = require(script.Parent.createRecipeEntries)
local FusionRequest = require(script.Parent.FusionRequest)

local Fusion = {}

function Fusion.init()
	Events.GetRecipeList.OnServerInvoke = function(player)
		local userID = player.UserId
		return CreateRecipeEntries(userID)
	end

	Events.FusionRequest.OnServerInvoke = function(player, FusionInfo)
		return FusionRequest(player, FusionInfo)
	end
end

return Fusion
