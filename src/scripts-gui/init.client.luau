print("Hello world, from scripts-gui")
--[[
    gui entry ]]

local StartFusionInput = require(script:WaitForChild("Fusion").fuseUIMangager)
local CleanupFusion = StartFusionInput()

local RollingInit = require(script:WaitForChild("Rolling").rollingUIManager)
local InventoryInit = require(script:WaitForChild("Inventory").InventoryUIManager)

RollingInit()
InventoryInit()

print("scripts-gui, executiong ended")