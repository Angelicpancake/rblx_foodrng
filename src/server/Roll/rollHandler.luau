--Joshua

local replicatedStorage = game:GetService("ReplicatedStorage")
local modules = replicatedStorage:WaitForChild("Shared"):WaitForChild("Foods"):WaitForChild("FoodUtil")
local remotes = replicatedStorage:WaitForChild("Events")

local foodList = require(modules:WaitForChild("foodList"))
local rarityList = require(modules:WaitForChild("rarityList"))
local rollEvent = remotes:WaitForChild("Rng"):WaitForChild("RollEvent")

local roll = {}

--[[ 
    Give to player's inventory
	Food Item
		Food Rarity
]]
function givePlayer(foodName: StringValue, chance: StringValue, player: Player)
	local food = Instance.new("Folder", player:WaitForChild("Inventory"))
	food.Name = foodName

	local rarity = Instance.new("StringValue", food)
	rarity.Name = "Rarity"
	rarity.Value = chance

	print("Gave", player.Name, foodName, "of rarity", chance)
end

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
	local food = foodList[chance][math.random(1, #foodList[chance])]
	--random food from foodList

	givePlayer(food, chance, player)
end

return roll
