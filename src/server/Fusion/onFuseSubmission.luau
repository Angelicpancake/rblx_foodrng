local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FuseClickedFunc: RemoteFunction = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Fusion"):WaitForChild("FuseClickedFunc")
-- local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)
local t = require(ReplicatedStorage:WaitForChild("Packages").t)

local FusionRecipes = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Foods"):
WaitForChild("FoodUtil").fusionList)

local function OnFuseSubmissionInit()
    FuseClickedFunc.OnServerInvoke = function(player: Player, foods: table)
        for _, foodName in ipairs(foods) do
            if not t.string(foodName) then
                return "Error"
            end
        end

        table.sort(foods)

        local key = table.concat(foods, "|")
        local result = FusionRecipes[key]
        if result then
            return result
        else
            return "Not Viable Fusion"
        end
    end
end

return OnFuseSubmissionInit