local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerDataTemplate = require(script.Parent.playerDataTemplate)

local t = require(ReplicatedStorage:WaitForChild("Packages").t)

local tableCheck = t.typeof("table")
local function deepCopy(template)
    local copy = {}
    for k, v in pairs(template) do
        if tableCheck(v) == t.table then
            copy[k] = deepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

local function onPlayerJoin(player, dataStore)
    local userId = player.UserId
    local success, playerData = pcall(function()
        return dataStore:GetAsync(userId)
    end)

    print(playerData)

    if not success then
        warn("failed to load data for", player.Name, playerData)
    end

    if not playerData then
        print("creating new copy")
        --rollback() -- make function later to rollback to old versions if playerDataFails
        local copy = deepCopy(playerDataTemplate)
        dataStore:SetAsync(userId, copy)

        playerData = pcall(dataStore:GetAsync(userId))

        print("player data:", playerData)
    end
end

return onPlayerJoin