local Players = game:GetService("Players")
local CreateRecipeEntries = require(script.Parent.createRecipeEntries)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeepCopy = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("deepCopy"))

local function RecipePlayerJoinInit(GetRecipeListFunction: RemoteFunction)
    local Entries = CreateRecipeEntries()
    GetRecipeListFunction.OnServerInvoke = function()
        return Entries
    end
end

return RecipePlayerJoinInit