local DataStoreService = game:GetService("DataStoreService")
local testDataStore = DataStoreService:GetDataStore("playerData", "alpha")
-- use this datastore later in the actual release -> local defaultDataStore = DataStoreService:GetGlobalDataStore()
local dataStore = testDataStore

local onPlayerJoined = require(script.Parent:WaitForChild("PlayerJoined"))
-- local onPlayerLeft = require(script.Parent:WaitForChild("saving").playerLeft)

local data = {}

function data.Start()
	game.Players.PlayerAdded:Connect(function(player)
		onPlayerJoined(player, dataStore)
	end)

	-- game.Players.PlayerRemoving(function(player)
	--     -- onPlayerLeft(player, dataStore)
	-- end)
end

return data
