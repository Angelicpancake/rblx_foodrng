print("Hello world, from client!")
--[[
    main client entry point]]

local Players = game:GetService("Players")
local locPlay = Players.LocalPlayer

local scripts = locPlay:WaitForChild("PlayerScripts"):WaitForChild("Client")

local Fusion = require(scripts:WaitForChild("Fusion").fusionHandlerClient)

Fusion.Start()

print("client, execution ended")
