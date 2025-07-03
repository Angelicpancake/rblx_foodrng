print("Hello world, from scripts-gui")
--[[
    gui entry ]]
local replicatedStorage = game:GetService("ReplicatedStorage")
local openGui = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("openGui"))
local closeGui = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Util"):WaitForChild("closeGui"))

local remotes = replicatedStorage:WaitForChild("Events")

local DefaultGui = script.Parent.DefaultGui
local rollButton = DefaultGui:WaitForChild("RollButton")

local invenGui = script.Parent.InventoryGui
local invenButton = DefaultGui.InventoryButton

local renderInven = require(script.Inventory.inventoryRender)

rollButton.MouseButton1Click:Connect(function()
	--print("rollButton client => clicked")
	remotes:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end)

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

--local stopFuseObserving = require(script:WaitForChild("Fusion").fuseSelect)
