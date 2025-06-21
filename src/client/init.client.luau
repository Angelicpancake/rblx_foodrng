--[[
    main client entry point]]

local Players = game:GetService("Players")
local locPlay = Players.LocalPlayer

local scripts = locPlay:WaitForChild("PlayerScripts"):WaitForChild("Client")

local Fusion = require(scripts:WaitForChild("Fusion").FusionHandlerClient)

Fusion.Start()
