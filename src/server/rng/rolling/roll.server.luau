local rngImports = require(game:GetService("ServerScriptService"):WaitForChild("Server"):WaitForChild("rng").rngImportsServer)

rngImports.rollEvent.OnServerEvent:Connect(function()
    print("rolled")
end)