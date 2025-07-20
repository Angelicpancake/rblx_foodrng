--[[
    handle fusion scripts on server
    - event that triggers returnning table of recipes
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Events = {}
Events.GetRecipeList = ReplicatedStorage.Events.Fusion.GetRecipeList

local CreateRecipeEntries = require(script.Parent.createRecipeEntries)

local Fusion = {}

function Fusion.init()
	Events.GetRecipeList.OnServerInvoke = function(player)
		local userID = player.UserId
		return CreateRecipeEntries(userID)
	end
end

return Fusion
