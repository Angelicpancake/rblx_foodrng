local Players = game:GetService("Players")
local CreateRecipeEntries = require(script.Parent.createRecipeEntries)

local function RecipePlayerJoinInit()
    local Entries = CreateRecipeEntries()
    Players.PlayerAdded:Connect(function(player)
        
    end)
end

return RecipePlayerJoinInit