local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Template: Frame = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates").Template

local Icons = require(script.Parent.foodIconMap)

local Fusions = require(script.Parent.Parent:WaitForChild("Foods"):WaitForChild("FoodUtil").fusionList)

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

        --assign emtpy string if no image
        Food1.Image = Icons[Ingredients[1]] or ""
        Food2.Image = Icons[Ingredients[2]] or ""

        table.insert(Entries, Clone)
    end

    return Entries
end

return CreateRecipeEntries