local FuseSelectInit = require(script.Parent.fuseSelect)

local function StartFusionInput()
    local FuseSelectTrove = FuseSelectInit()
    print("Fusion Input Connected")

    local function CleanupFusion()
        FuseSelectTrove:Clean()
    end

    return CleanupFusion
end

return StartFusionInput