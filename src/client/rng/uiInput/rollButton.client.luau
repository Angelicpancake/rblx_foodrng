local rngImports = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Client"):WaitForChild("rng").rngImportsClient)

local rngGui = rngImports.general.ui:WaitForChild("rngGui")
local rollButton = rngGui:WaitForChild("rollButton")

rollButton.MouseButton1Click:Connect(function()
    rngImports.rollEvent:FireServer()
end)