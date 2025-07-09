local ServerScriptService = game:GetService("ServerScriptService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Fusion").fusionHandlerServer)
local data = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").dataHandler)
local roll = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Roll").rollHandler)

local remotes = replicatedStorage:WaitForChild("Events")

local rollEvent = remotes:WaitForChild("Rng"):WaitForChild("RollEvent")

local foodData = require(script.Foods.FoodUtil.foodSource)
local getFoodList = replicatedStorage.Events.Rng.GetFoodList
local DataReadyEvent: BindableEvent = replicatedStorage.Events.Data.dataReadyEvent

print("Hello world, from server!")

fusion.Start()
data.Start()

DataReadyEvent.Event:Connect(function()
	getFoodList.OnServerInvoke = function(player)
		return foodData --send table to client
	end


	rollEvent.OnServerEvent:Connect(function(player)
		roll.Start(player)
	end)
end)

print("Server, execution ended")
