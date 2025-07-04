local ServerScriptService = game:GetService("ServerScriptService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Fusion").fusionHandlerServer)
local data = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").dataHandler)
local roll = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Roll").rollHandler)

local remotes = replicatedStorage:WaitForChild("Events")

local rollEvent = remotes:WaitForChild("Rng"):WaitForChild("RollEvent")

print("Hello world, from server!")

--fusion.Start()
data.Start()

rollEvent.OnServerEvent:Connect(function(player)
	roll.Start(player)
end)

print("Server, execution ended")
print("d")

