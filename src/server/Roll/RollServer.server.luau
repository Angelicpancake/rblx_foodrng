local replicatedStorage = game:GetService("ReplicatedStorage")
local modules = replicatedStorage:WaitForChild("Shared"):WaitForChild("Modules")
local remotes = replicatedStorage:WaitForChild("Events")

local foodList = require(modules:WaitForChild("FoodList"))
local rarityList = require(modules:WaitForChild("RarityList"))
local rollEvent = remotes:WaitForChild("Rng"):WaitForChild("RollEvent")

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

--roll button is clicked server side
rollEvent.OnServerEvent:Connect(function(player)
	local chance = getChance()
	local food = foodList[chance][math.random(1, #foodList[chance])]
	--random food from foodList

	givePlayer(food, chance, player)
end)
