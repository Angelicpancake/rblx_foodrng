local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Fusion").FusionHandlerServer)
local data = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").DataHandler)

print("Hello world, from server!")

fusion.Start()
data.Start()
