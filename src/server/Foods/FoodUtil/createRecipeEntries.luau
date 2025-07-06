local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Template: Frame = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates").Template

local Fusions = require(script.Parent.FoodUtil.fusionList)

local function CreateRecipeEntries()
    local Entries = {}
    for key, Fusion in Fusions do

        --string table of ingredients
        local Ingredients = { string.split(key, "|") }
        local Clone = Template:Clone()

        --set frame name to fusion food name
        Clone.Name = Fusion

        local Food1: ImageLabel = Clone.Food1
        local Food2: ImageLabel = Clone.Food2

        Food1.Name = Ingredients[1]
        Food2.Name = Ingredients[2]

        table.insert(Entries, Clone)
    end
end

return CreateRecipeEntries