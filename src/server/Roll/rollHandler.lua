local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

--local foodList = require(modules:WaitForChild("foodList"))
local rollEvent = Events:WaitForChild("Rng"):WaitForChild("RollEvent")
local PlayerDataFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Data").playerDataMap)

local RollForFood = require(script.Parent.roll)

local TimerFuncs = require(ServerScriptService:WaitForChild("Server"):WaitForChild("TimedEvents").timerFuncs)

local function RollingInit()
	rollEvent.OnServerEvent:Connect(function(player)
		task.spawn(function()
			TimerFuncs.AddEvent({
				Type = "Bonus",
				Name = "TestEvent",
				Time = os.clock() + 10,
			}, player.UserId)
			local PlayerData = PlayerDataFuncs.RuntimeGetPlayerData(player.UserId)
			local LuckBoost = PlayerData.Upgrades.LuckBoost
			RollForFood(player, LuckBoost)
		end)
	end)
end
--get a random rarity

return RollingInit