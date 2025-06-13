local ServerScriptService = game:GetService("ServerScriptService")
local fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("fusion").fusionHandlerServer)

print("Hello world, from server!")

fusion:Start()