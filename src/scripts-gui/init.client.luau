print("Hello world, from scripts-gui")
--[[
    gui entry ]]
local replicatedStorage = game:GetService("ReplicatedStorage")

local remotes = replicatedStorage:WaitForChild("Events")

local rollGui = script.Parent.DefaultGui
local rollButton = rollGui:WaitForChild("RollButton")

local invenGui = script.Parent.InventoryGui
local invenButton = script.Parent.DefaultGui.InventoryButton
local temp = false

local invenRender = require(script.Inventory.inventoryRender)

rollButton.MouseButton1Click:Connect(function()
	--print("rollButton client => clicked")
	remotes:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end)

invenButton.MouseButton1Click:Connect(function()
	invenGui.Enabled = not temp
	temp = not temp
end)

print("scripts-gui, execution ended")
