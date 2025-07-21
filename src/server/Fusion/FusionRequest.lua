local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = {}
Remotes.fusionRequest = ReplicatedStorage.Events.Fusion.FusionRequest

local foodSource = require(script.Parent.Parent.Foods.FoodUtil.foodSource)
local givePlayer = require(script.Parent.Parent.Util.givePlayer)

--[[
	Fusion Info:

	Fusion Food
	Info
	- Food
	- Image
]]
local function OnFuseSubmissionInit(player, fusionInfo)
	--	print(fusionInfo.fusionFood)
	--	print(foodSource.foodList[fusionInfo.fusionFood].rarity)
	--print(player)
	givePlayer(fusionInfo.fusionFood, foodSource.foodList[fusionInfo.fusionFood].rarity, player)
	return "success"
end

return OnFuseSubmissionInit
