local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local InventoryGui = PlayerGui:WaitForChild("InventoryGui")
local DefaultGui = PlayerGui:WaitForChild("DefaultGui")

local renderInven = require(script.Parent.inventoryRender)
local InventoryDefaultButtonInit = require(script.Parent.inventoryDefaultButton)
local pageRender = require(script.Parent.pageRender)

local page = 1

local function InventoryInit()
	--Params: (sorting category, owned: boolean)
	renderInven("rarity", true, page)
	page = pageRender(page, "rarity")

	--Params: (InventoryDefaultButton, InventoryGui)
	InventoryDefaultButtonInit(DefaultGui:WaitForChild("InventoryButton"), InventoryGui)
end

return InventoryInit
