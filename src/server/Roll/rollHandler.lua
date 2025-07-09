--Joshua

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local modules = ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):WaitForChild("FoodUtil")
local remotes = ReplicatedStorage:WaitForChild("Events")

--local foodList = require(modules:WaitForChild("foodList"))
local foodList = require(modules.foodSource)
local rarityList = require(modules:WaitForChild("rarityList"))
local rollEvent = remotes:WaitForChild("Rng"):WaitForChild("RollEvent")
local givePlayer = require(script.Parent.Parent.Util.givePlayer)

local roll = {}

local Players = game:GetService("Players")
local PlayerDataFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").playerDataMap)

--get a random rarity
function getChance(LuckBoost: number)
	for i, RarityObj in ipairs(rarityList) do
		if i == 1 then
			continue --skip common (default rarity)
		elseif math.random(1, RarityObj.Weight - math.ceil(RarityObj.Weight * LuckBoost)) == 1 then
			return RarityObj.Rarity
		end
	end

	return rarityList[1].Rarity --return common if all else fails
end

function roll.Start(player: Player)
	local Upgrades = assert(PlayerDataFuncs.RuntimeGetPlayerData(player.UserId).Upgrades)
	local LuckBoost = Upgrades.LuckBoost
	print("Rolling With A Luckboost of", LuckBoost, "%")
	local chance = getChance(LuckBoost)
	print(chance)
	local food = foodList.foodByRarity[chance][math.random(1, #foodList.foodByRarity[chance])]
	--random food from foodList

	print(givePlayer(food, chance, player))
end

return roll