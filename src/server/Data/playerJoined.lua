--!strict
--[[
	when player joins:
		create player data if none exists or 
]]

local replicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

--playerDataTemplate contains type PlayerData
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local PlayerDataTypes = require(Types.playerDataTypes)
local PlayerDataTemplate = require(script.Parent.playerDataTemplate) --player data template
local deepCopy = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Util").deepCopy) --deep copy function
local PlayerDataFuncs = require(script.Parent.playerDataMap)
local CheckLastLogin = require(script.Parent.checkLastLogin)
local GivePlayerItem = require(ServerScriptService:WaitForChild("Server"):WaitForChild("Util").givePlayerItem)
local Calendar = require(script.Parent.gameData)

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

	local success, PlayerData = pcall(function()
		return dataStore:GetAsync(userId)
	end)

	--if success failed: could not retrieve data from player's datastore
	if not success then
		local RetryCount = 1
		print(`failed to load data for ${player.Name}, Retrying ${RetryCount}`)
		while not success do
			success, PlayerData = pcall(function()
				return dataStore:GetAsync(userId)
			end)
			task.wait(5)
		end
	end

	if not PlayerData then
		print("creating new copy")
		PlayerData = deepCopy(PlayerDataTemplate)
		dataStore:SetAsync(userId, PlayerData)
	end

	if PlayerData._DATAVERSION ~= PlayerDataTemplate._DATAVERSION then
		print("wrong data verision, migrating")
		--should migrate data here
	end

	if not PlayerDataTypes.PlayerDataTypeChecker(PlayerData) then
		local _success2, ErrorMessage = PlayerDataTypes.PlayerDataTypeChecker(PlayerData)
		print("corrupted data, rolling back", ErrorMessage)
		--go to previous saved data
	end

	--updates players login info and returns true if logging in on a new day
	local NewDay = CheckLastLogin(PlayerData.Profile)
	if NewDay then
		PlayerData.Profile.CalendarProgress += 1
		-- GivePlayer
	end

	print("Player Data:", PlayerData)
	addToPlayer(player, PlayerData)
	PlayerDataFuncs.RuntimeSetPlayerData(player.UserId, PlayerData)

	if NewDay then
		GivePlayerItem(Calendar[PlayerData.Profile.CalendarProgress], player)
	end
end

return onPlayerJoin
