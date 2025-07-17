-- main client entry point

-- local Fusion = require(scripts:WaitForChild("Fusion").fusionHandlerClient)

-- Fusion.Start()

local CheckAreaInit = require(script.checkArea)
local RollingClientInit = require(script:WaitForChild("Rolling").rollingHandlerClient)

CheckAreaInit()
RollingClientInit()