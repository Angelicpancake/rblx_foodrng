--[[
    gui entry ]]
local replicatedStorage = game:GetService("ReplicatedStorage")

local remotes = replicatedStorage:WaitForChild("Events")

local rollGui = script.Parent.Parent.Parent:WaitForChild("RollGui")
local rollButton = rollGui:WaitForChild("RollButton")
local rollEvent = remotes:WaitForChild("Rng"):WaitForChild("RollEvent")
--local rollOnClick = require(script:WaitForChild("Roll"):WaitForChild("RollScript"))

--rollButton.MouseButton1Click:Connect(rollOnClick)

rollButton.MouseButton1Click:Connect(function()
	print("button clicked")
	rollEvent:FireServer() --fire to server
end)
