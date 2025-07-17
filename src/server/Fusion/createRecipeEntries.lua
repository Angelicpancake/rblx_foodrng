local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Template: Frame = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates").RecipeTemplate

local Icons = require(script.Parent.Parent:WaitForChild("Foods"):WaitForChild("FoodUtil").foodIconMap)

-- local Fusions = require(script.Parent.Parent:WaitForChild("Foods"):WaitForChild("FoodUtil").fusionList)

local function CreateRecipeEntries()
    -- local Entries = {}
    -- for Key, FusionName in Fusions do

    --     --string table of ingredients
    --     local Ingredients = string.split(Key, "|")
    --     local Clone = Template:Clone()

    --     --assign emtpy string if no image
    --     local F1Image = Icons[Ingredients[1]] or ""
    --     local F2Image = Icons[Ingredients[2]] or ""
    --     local FResImage = Icons[FusionName] or ""

    --     table.insert(Entries, {
    --         Food1 = {Name = Ingredients[1], Image = F1Image},
    --         Food2 = {Name = Ingredients[2], Image = F2Image},
    --         FusionResult = {Name = FusionName, Image = FResImage} 
    --     })
    -- end

    -- return Entries
end

return CreateRecipeEntries