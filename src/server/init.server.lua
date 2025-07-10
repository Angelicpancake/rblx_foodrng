local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Fusion").fusionHandlerServer)
local Data = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").dataHandler)
local RollingInit = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Roll").rollHandler)

local Events = ReplicatedStorage:WaitForChild("Events")

local DataEvents = Events:WaitForChild("Data")

local FoodData = require(script.Foods.FoodUtil.foodSource)
local GetFoodList = ReplicatedStorage.Events.Rng.GetFoodList
local DataReadyEvent: BindableEvent = DataEvents.dataReadyEvent

print("Hello world, from server!")

Data.Start()

DataReadyEvent.Event:Connect(function()
	GetFoodList.OnServerInvoke = function(player) return FoodData end--send table to client
	RollingInit()
	Fusion.Start()
end)

print("Server, execution ended")
