local RunService = game:GetService("RunService")

local checkFusionEntered = require(script.Parent.fusionEnteredArea)

local fusion = {}

function fusion.Start()
    RunService.RenderStepped:Connect(checkFusionEntered)
end

return fusion