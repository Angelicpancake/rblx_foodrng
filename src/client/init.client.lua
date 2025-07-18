--[[
    initialize all client modular scripts
]]
local FusionHandler = require(script.Fusion.fusionHandlerClient)
local CheckArea = require(script.checkArea)

FusionHandler.init()
CheckArea()

print("client, execution ended")
