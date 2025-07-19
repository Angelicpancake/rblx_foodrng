--[[
    This module will create a table of recipe entries with all necessary data for Fusion Gui
    - Curretly players will all see the same recipes. Later on if need be, we can make it specific to each player
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FoodData = require(script.Parent.Parent.Foods.FoodUtil.foodSource)
local PlayerMap = require(script.Parent.Parent.Data.playerDataMap)

local FusionList = FoodData.fusionList

type RecipeEntry = {
	--recipe hashmap: name, quantity, stars, rarity, image
	Food: { [string]: { quantity: number, stars: number, rarity: string, image: ImageLabel } },
	Image: ImageLabel,
}

local Entries: { [string]: RecipeEntry } = {}

--[[format Entries[FoodFusionName] = {
    Food = {
        [FoodName] = {
            quantity = number,
            stars = number,
            rarity = string,
            image = ImageLabel
        }
    Image
    }
}
]]
local function CreateRecipeEntries(userID: number): { [string]: RecipeEntry }
	local PlayerData = PlayerMap.RuntimeGetPlayerData(userID)
	local foodInventory = PlayerData.Inventory.Food

	for recipe, info in pairs(FusionList) do
		Entries[info.name] = {
			Food = {},
			Image = FoodData.foodList[info.name].image or "rbxassetid://0",
		}

		local ingredients = string.split(recipe, "|")
		for _, v in ipairs(ingredients) do
			Entries[info.name].Food[v] = {
				quantity = 0, --placeholder
				stars = 0, --placeholder
				rarity = FoodData.foodList[v].rarity,
				image = FoodData.foodList[v].image or "rbxassetid://0",
			}
			--owned food
			if foodInventory[v] then
				Entries[info.name].Food[v].quantity = foodInventory[v].Quantity
			end
		end --for loop
	end

	return Entries
end

return CreateRecipeEntries
