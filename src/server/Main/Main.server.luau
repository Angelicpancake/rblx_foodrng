--[[
    handle the datastore/playerdata
]]

local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local dataStoreService = game:GetService("DataStoreService")
local runService = game:GetService("RunService")

local dataStore = dataStoreService:GetDataStore("test1")

local function setUpPlayer(player: Player)
	--player credentials
	local userID = player.UserId
	local key = "Player_" .. userID --unique key

	--[[
        create leaderstats 
    ]]

	local inventory = Instance.new("Folder", player)
	inventory.Name = "Inventory"
end

Players.PlayerAdded:Connect(function(player)
	setUpPlayer(player)
end)
