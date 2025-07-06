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

local renderInven = require(script.Inventory.inventoryRender)
local sort = "rarity"
renderInven(sort, true, 1)

local inventory = script.Parent.InventoryGui.Inventory
local nextButton = inventory.Next
local backButton = inventory.Back

local page = 1

nextButton.MouseButton1Click:Connect(function()
	if page < 15 then
		page += 1
		renderInven(sort, true, page)
	end
end)

backButton.MouseButton1Click:Connect(function()
	if page > 1 then
		page -= 1
		renderInven(sort, true, page)
	end
end)

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
