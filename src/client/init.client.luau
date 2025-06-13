local Players = game:GetService("Players")
local locPlay = Players.LocalPlayer

local scripts = locPlay:WaitForChild("PlayerScripts"):WaitForChild("Client")

local fusion = require(scripts:WaitForChild("fusion").fusionHandlerClient)

print("Hello world, from client!")

fusion.Start()