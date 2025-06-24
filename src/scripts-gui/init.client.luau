print("Hello world, from scripts-gui")
--[[
    gui entry ]]
local replicatedStorage = game:GetService("ReplicatedStorage")

local remotes = replicatedStorage:WaitForChild("Events")

local rollGui = script.Parent.RollGui
local rollButton = rollGui:WaitForChild("RollButton")
--local rollOnClick = require(script:WaitForChild("Roll"):WaitForChild("RollScript"))
--rollButton.MouseButton1Click:Connect(rollOnClick)

rollButton.MouseButton1Click:Connect(function()
	--print("rollButton client => clicked")
	remotes:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end)

print("scripts-gui, executiong ended")