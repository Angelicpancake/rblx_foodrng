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

local BaseCost = 10

local function OnFuseSubmissionInit(player, fusionInfo)
	for i, v in pairs(fusionInfo.info.Food) do
		if v.quantity < BaseCost then
			return "failed"
		end
	end

	givePlayer(fusionInfo.fusionFood, foodSource.foodList[fusionInfo.fusionFood].rarity, player)
	return "success"
end

return OnFuseSubmissionInit
