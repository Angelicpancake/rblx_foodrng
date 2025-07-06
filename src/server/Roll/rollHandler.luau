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

--get a random rarity
function getChance()
	for i, rarity in ipairs(rarityList) do
		if i == 1 then
			continue --skip common (default rarity)
		elseif math.random(1, rarity[2]) == 1 then
			return rarity[1]
		end
	end

	return rarityList[1][1] --return common if all else fails
end

function roll.Start(player: Player)
	local chance = getChance()
	local food = foodList.foodByRarity[chance][math.random(1, #foodList.foodByRarity[chance])]
	--random food from foodList

	print(givePlayer(food, chance, player))
end

return roll
