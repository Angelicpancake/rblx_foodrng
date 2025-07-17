--[[
    Server connection to recieve fusion list on player join

    @param GetRecipeListEvent RemoteEvent
    @param RecipeList ScrollingFrame
]]--
local function GenerateRecipeListInit(GetRecipeListFunction: RemoteFunction, RecipeList: ScrollingFrame, Template: Frame)
    -- local Entries = GetRecipeListFunction:InvokeServer()
    -- for _, Entry in Entries do
    --     local Clone: Frame = Template:Clone()

    --     local Food1 = assert(Clone:FindFirstChild("Food1"), "cannot find child food1")
    --     local Food2 = assert(Clone:FindFirstChild("Food2"), "cannot find child food1")
    --     local FusionResult = assert(Clone:FindFirstChild("FusionResult"), "cannot find child food1")

    --     Food1.Image = Entry.Food1.Image
    --     Food2.Image = Entry.Food2.Image
    --     FusionResult.Image = Entry.FusionResult.Image

    --     Food1:SetAttribute("Name", Entry.Food1.Name)
    --     Food2:SetAttribute("Name", Entry.Food2.Name)
    --     FusionResult:SetAttribute("Name", Entry.FusionResult.Name)
    --     Clone.Name = Entry.FusionResult.Name

    --     Clone.Parent = RecipeList

    --     --Add tag for iamge button overlaying clone for observers in fuseSelect
    --     local ImageButtonOverlay = assert(Clone:FindFirstChild("ButtonOverlay", true), "could not find button overlay")
    --     ImageButtonOverlay:SetAttribute("fusionType", "recipeMenu")
    --     ImageButtonOverlay:AddTag("fusionItem")
    -- end
end

return GenerateRecipeListInit