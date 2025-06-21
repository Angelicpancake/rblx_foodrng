--[[
    gui entry ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rollGui = script.Parent.Parent.Parent:WaitForChild("RollGui")
local rollButton = rollGui:WaitForChild("RollButton")
local rollOnClick = require(script:WaitForChild("Roll"):WaitForChild("RollScript"))

rollButton.MouseButton1Click:Connect(rollOnClick)
