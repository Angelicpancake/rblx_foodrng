local DataStoreService = game:GetService("DataStoreService")
local testDataStore = DataStoreService:GetDataStore("playerData", "alpha")
-- use this datastore later in the actual release -> local defaultDataStore = DataStoreService:GetGlobalDataStore()
local dataStore = testDataStore

local onPlayerJoined = require(script.Parent.playerJoined)

local data = {}

function data.Start()
    game.Players.PlayerAdded:Connect(function(player)
        onPlayerJoined(player, dataStore)
    end)

    game.Players.Player
end

return data