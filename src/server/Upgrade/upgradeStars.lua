local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = {}

Remotes.upgradeStar = ReplicatedStorage.Events.Upgrade.UpgradeStar

local function upgradeStar()
	Remotes.upgradeStar.OnServerInvoke = function(player)
		return "upgradeStar from server"
	end
end

return upgradeStar
