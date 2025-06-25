--[[
    gui entry ]]
local replicatedStorage = game:GetService("ReplicatedStorage")

local remotes = replicatedStorage:WaitForChild("Events")

local rollGui = script.Parent.RollGui
local rollButton = rollGui:WaitForChild("RollButton")

local invenGui = script.Parent.InventoryGui
local invenFrame = invenGui.Inventory
local invenButton = invenGui.InventoryButton

rollButton.MouseButton1Click:Connect(function()
	--print("rollButton client => clicked")
	remotes:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end)

invenButton.MouseButton1Click:Connect(function()
	local temp = invenFrame.Visible

	invenFrame.Visible = not temp
end)
