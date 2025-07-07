--[[
    Server connection to recieve fusion list on player join

    @param GetRecipeListEvent RemoteEvent
    @param RecipeList ScrollingFrame
]]--
local function GenerateRecipeListInit(GetRecipeListFunction: RemoteFunction, RecipeList: ScrollingFrame, Template: Frame)
    local Entries = GetRecipeListFunction:InvokeServer()
    print(Entries)
    for _, Entry in Entries do
        local Clone: Frame = Template:Clone()

        Clone.Food1.Image = Entry.Food1.Image
        Clone.Food2.Image = Entry.Food2.Image
        Clone.FusionResult.Image = Entry.FusionResult.Image

        Clone.Food1:SetAttribute("Name", Entry.Food1.Name)
        Clone.Food2:SetAttribute("Name", Entry.Food2.Name)
        Clone.FusionResult:SetAttribute("Name", Entry.FusionResult.Name)
        Clone.Name = Entry.FusionResult.Name

        Clone.Parent = RecipeList

        --Add tag for iamge button overlaying clone for observers in fuseSelect
        Clone.GridLayoutIgnore.ImageButton:SetAttribute("fusionType", "recipeMenu")
        Clone.GridLayoutIgnore.ImageButton:AddTag("fusionItem")
    end
end

return GenerateRecipeListInit