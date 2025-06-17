local replicatedStorage = game:GetService("ReplicatedStorage")
local modules = replicatedStorage:WaitForChild("Shared"):WaitForChild("Modules")

local foodList = require(modules:WaitForChild("FoodList"))
local rarityList = require(modules:WaitForChild("RarityList"))

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

print(getChance())
