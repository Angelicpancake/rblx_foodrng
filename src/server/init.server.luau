local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("fusion").fusionHandlerServer)
local data = require(ServerScriptService:WaitForChild("Server"):WaitForChild("data").dataHandler)

print("Hello world, from server!")

fusion.Start()
data.Start()