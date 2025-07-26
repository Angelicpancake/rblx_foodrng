local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataMap = require(script.Parent.Parent.Data.playerDataMap)
local Remotes = {}

Remotes.upgradeStar = ReplicatedStorage.Events.Upgrade.UpgradeStar

local upgradeCost = require(script.Parent.upgradeCost)
local giveStar = require(script.Parent.Parent.Util.giveStar)

local function upgradeStar(player, food)
	local cost = upgradeCost(player, food)
	local PlayerMap = PlayerDataMap.RuntimeGetPlayerData(player.UserId)
	local quan = PlayerMap.Inventory.Food[food].Quantity

	if cost > quan then
		return "failure"
	end

	--success scenario
	quan -= cost
	local result = giveStar(food, quan, player)
	print(result)

	return "success"
end

Remotes.upgradeStar.OnServerInvoke = function(player, food)
	return upgradeStar(player, food)
end

return upgradeStar
