local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

--local foodList = require(modules:WaitForChild("foodList"))
local RollEvent = Events:WaitForChild("Rng"):WaitForChild("RollEvent")
local RollResultEvent: RemoteEvent = Events:WaitForChild("Rng"):WaitForChild("RollResultEvent")
local PlayerDataFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").playerDataMap)

local RollForFood = require(script.Parent.rollForFood)

local TimerFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("TimedEvents").timerManager)

local function RollingInit()
	RollEvent.OnServerEvent:Connect(function(player, zone)
		print(`zone is in {zone}`)
		local PlayerData = PlayerDataFuncs.RuntimeGetPlayerData(player.UserId)
		local LuckBoost = PlayerData.Upgrades.LuckBoost
		local FoodResult = RollForFood(player, LuckBoost, zone)
		RollResultEvent:FireClient(player, FoodResult)
	end)
end
--get a random rarity

return RollingInit
