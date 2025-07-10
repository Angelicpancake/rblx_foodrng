--!strict
--[[
	when player joins:
		create player data if none exists or 
]]

local replicatedStorage = game:GetService("ReplicatedStorage")
local t = require(replicatedStorage:WaitForChild("Packages").t)

--playerDataTemplate contains type PlayerData
local PlayerDataTypes = require(script.Parent.playerDataTypes)
local PlayerDataTemplate = require(script.Parent.playerDataTemplate) --player data template
local deepCopy = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Util").deepCopy) --deep copy function
local PlayerDataFuncs = require(script.Parent.playerDataMap)
local DataReadyEvent: BindableEvent = replicatedStorage:WaitForChild("Events"):WaitForChild("Data"):WaitForChild("dataReadyEvent")

local function addToPlayer(parent: Player | Folder, DataObj: PlayerDataTypes.PlayerDataType)
	for key, value in pairs(DataObj) do
		if type(value) == "table" then 
			local folder = Instance.new("Folder", parent)
			folder.Name = key
			addToPlayer(folder, value) --copy the values within the table value
		elseif type(value) == "number" then
			local val = Instance.new("NumberValue", parent)
			val.Name = key
			val.Value = value
		elseif type(value) == "string" then
			local val = Instance.new("StringValue", parent)
			val.Name = key
			val.Value = value
		end
	end
end

local function MigratePlayerData(playerData, template)
    -- Ensure playerData exists
    for key, value in pairs(template) do
        -- Check if the template value is a table
        if type(value) == "table" then
            -- Initialize nested table if it doesn't exist
            playerData[key] = playerData[key] or {}
            -- Recursively migrate nested tables
            MigratePlayerData(playerData[key], value)
        elseif playerData[key] == nil then
            -- Copy default value if field doesn't exist
			print("Making new field for player", key, "->", value)
            playerData[key] = value
        end
    end
    
    return playerData
end

local function onPlayerJoin(player, dataStore)
	local userId = player.UserId --unique player id

	local success, playerData = pcall(function()
		return dataStore:GetAsync(userId)
	end)

	--if success failed: could not retrieve data from player's datastore
	if not success then
		error([[failed to load data for ${player.Name}]])
	elseif not playerData then
		print("creating new copy")

		local secondSuccess, newPlayerData = pcall(function()
			dataStore:GetAsync(userId)
		end)

		if not secondSuccess then
			warn("Failed to save new data for", player.Name)
			return
		end

		if type(newPlayerData) == "table" then
			playerData = newPlayerData
		else
			print("creating new data for player")
			playerData = deepCopy(PlayerDataTemplate)
			dataStore:SetAsync(userId, newPlayerData)
		end
	end

	if playerData._DATAVERSION ~= PlayerDataTemplate._DATAVERSION then
		playerData = MigratePlayerData(playerData, PlayerDataTemplate)
		dataStore:SetAsync(userId, playerData)
	end

	if not PlayerDataTypes.PlayerDataTypeChecker(playerData) then
		local Success, ErrorMessage = PlayerDataTypes.PlayerDataTypeChecker(playerData)
		print("corrupted data, rolling back", ErrorMessage)
		--go to previous versions
	end

	print("Player Data:", playerData)
	addToPlayer(player, playerData)
	PlayerDataFuncs.RuntimeSetPlayerData(player.UserId, playerData)
	DataReadyEvent:Fire()
end

return onPlayerJoin