local InventoryInit = require(script:WaitForChild("Inventory").InventoryUIManager)
local RollingInit = require(script:WaitForChild("Rolling").rollingUIManager)
local FusionInit = require(script:WaitForChild("Fusion").fuseUIMangager)

InventoryInit()
RollingInit()

--FusionInit returns a function to clean all connections and tables
--local CleanupFusion = FusionInit()
