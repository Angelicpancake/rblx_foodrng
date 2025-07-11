--[[
	dataHandler:
	the entry point for data in server script
]]

local DataStoreService = game:GetService("DataStoreService")
local dataStore = DataStoreService:GetDataStore("playerData", "26") --for testing

local onPlayerJoined = require(script.Parent.playerJoined) --function onPlayerJoined(player, dataStore)
local onPlayerLeft = require(script.Parent:WaitForChild("saving").playerLeft)

local data = {}

function data.Start()
	--when a player connects to the game
	game.Players.PlayerAdded:Connect(function(player)
		onPlayerJoined(player, dataStore)
	end)

	game.Players.PlayerRemoving:Connect(function(player)
		onPlayerLeft(player, dataStore)
	end)
end

return data

--[[
	-- local onPlayerLeft = require(script.Parent:WaitForChild("saving").playerLeft)
	-- game.Players.PlayerRemoving(function(player)
	--     -- onPlayerLeft(player, dataStore)
	-- end)]]
