local StartFusionInput = require(script:WaitForChild("Fusion").fuseSelect)
local CleanupFusion = StartFusionInput()

local InventoryInit = require(script:WaitForChild("Inventory").InventoryUIManager)
local RollingInit = require(script:WaitForChild("Rolling").rollingUIManager)

InventoryInit()
RollingInit()
