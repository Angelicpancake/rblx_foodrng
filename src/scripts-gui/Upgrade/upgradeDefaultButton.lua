local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = {}

Remotes.upgradeStar = ReplicatedStorage.Events.Upgrade.UpgradeStar
Remotes.upgradeCost = ReplicatedStorage.Events.Upgrade.GetUpgradeCost

local Upgrade = {}

Upgrade.ButtonInit = function()
	print("clicked")
	local success = Remotes.upgradeStar:InvokeServer()
	print(success)
end

Upgrade.GetCost = function(food: string)
	print("get cost")
	local cost = Remotes.upgradeCost:InvokeServer(food)
	return cost
end

return Upgrade
