--[[
	dataHandler:
	the entry point for data in server script
]]
local data = {}

local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dataStore = DataStoreService:GetDataStore("playerData", "43")--for testing

local onPlayerJoined = require(script.Parent.playerJoined) --function onPlayerJoined(player, dataStore)
local onPlayerLeft = require(script.Parent:WaitForChild("saving").playerLeft)

local SettingsChangeEvent : RemoteEvent = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Data"):WaitForChild("SettingChangeEvent")
local OnSettingsEvent = require(script.Parent.Settings.onSettingsEvents)

function data.Start()
	--when a player connects to the game
	game.Players.PlayerAdded:Connect(function(player)
		onPlayerJoined(player, dataStore)
	end)

	game.Players.PlayerRemoving:Connect(function(player)
		onPlayerLeft(player, dataStore)
	end)

	SettingsChangeEvent.OnServerEvent:Connect(function(player : Player, Setting : string)
		OnSettingsEvent(player, Setting)
	end)
end

return data

--[[
	-- local onPlayerLeft = require(script.Parent:WaitForChild("saving").playerLeft)
	-- game.Players.PlayerRemoving(function(player)
	--     -- onPlayerLeft(player, dataStore)
	-- end)]]
