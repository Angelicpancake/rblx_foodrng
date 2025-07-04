local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)
local FuseSelectionInit = require(script.Parent.fuseSelect)

local function StartFusionInput()
    local FuseSelectTrove = FuseSelectionInit()
    print(FuseSelectTrove)
    print("Fusion Input Connected")

    local function CleanupFusion()
        FuseSelectTrove:Clean()
    end

    return CleanupFusion
end

return StartFusionInput