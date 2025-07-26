local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerDataMap = require(script.Parent.Parent.Data.playerDataMap)

local Remotes = {}

local RarityDiv = {
	Common = 1,
	Uncommon = 2,
	Rare = 3,
	Epic = 4,
	Legendary = 5,
	Mythical = 6,
}

Remotes.upgradeCost = ReplicatedStorage.Events.Upgrade.GetUpgradeCost

--Cost = (CurrStar + 1)(2^(CurrStar + 5)) / RarityDivFactor
local function upgradeCost()
	Remotes.upgradeCost.OnServerInvoke = function(player, food)
		local PlayerData = PlayerDataMap.RuntimeGetPlayerData(player.UserId)
		local CurrStar = PlayerData.Inventory.Food[food].Stars
		local Rarity = PlayerData.Inventory.Food[food].Rarity

		local result = math.floor(((CurrStar + 1) * (math.pow(2, (CurrStar + 5)))) / RarityDiv[Rarity])
		print(result)
		return result
	end
end

return upgradeCost
