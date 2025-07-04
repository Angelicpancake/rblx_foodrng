print("Hello world, from scripts-gui")
--[[
    gui entry ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local openGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("openGui"))
local closeGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("closeGui"))

local remotes = ReplicatedStorage:WaitForChild("Events")

local DefaultGui = script.Parent.DefaultGui
local rollButton = DefaultGui:WaitForChild("RollButton")

local invenGui = script.Parent.InventoryGui
local invenButton = DefaultGui.InventoryButton

rollButton.MouseButton1Click:Connect(function()
	--print("rollButton client => clicked")
	remotes:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end)

local StartFusionInput = require(script:WaitForChild("Fusion").fuseSelect)
local CleanupFusion = StartFusionInput()
local invenOpen = false
invenButton.MouseButton1Click:Connect(function()
	if not invenOpen then
		openGui(invenGui)
	else
		closeGui(invenGui)
	end
	invenOpen = not invenOpen
end)

print("scripts-gui, executiong ended")