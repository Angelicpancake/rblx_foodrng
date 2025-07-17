local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local InventoryGui = PlayerGui:WaitForChild("InventoryGui")
local DefaultGui = PlayerGui:WaitForChild("DefaultGui")

local renderInven = require(script.Parent.inventoryRender)
local InventoryDefaultButtonInit = require(script.Parent.inventoryDefaultButton)
local pageRender = require(script.Parent.pageRender)
local search = require(script.Parent.inventorySearch)

local replicatedStorage = game:GetService("ReplicatedStorage")
local inventoryUpdateRemote = replicatedStorage.Events.Rng.UpdateInventory

local SearchBox = InventoryGui.Inventory.Search.SearchBox

local page = 1

local sort = "rarity"

local function InventoryInit()
	--Params: (sorting category, owned: boolean)
	renderInven(sort, true, page, "")
	page = pageRender(page, sort)

	--Params: (InventoryDefaultButton, InventoryGui)
	InventoryDefaultButtonInit(DefaultGui:WaitForChild("InventoryButton"), InventoryGui)

	SearchBox:GetPropertyChangedSignal("Text"):Connect(search)
end

inventoryUpdateRemote.OnClientInvoke = function()
	print("updated because of remote")
	renderInven(sort, true, page, "")
end

return InventoryInit
