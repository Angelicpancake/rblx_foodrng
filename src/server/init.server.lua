local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Fusion").fusionHandlerServer)
local Data = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").dataHandler)
local RollingInit = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Roll").rollHandler)

local FoodData = require(script.Foods.FoodUtil.foodSource)
local GetFoodList = ReplicatedStorage.Events.Rng.GetFoodList

Data.Start()
RollingInit()
Fusion.Start()

GetFoodList.OnServerInvoke = function(player) return FoodData end--send table to client