--[[
	when player joins:
		create player data if none exists or 
]]

local replicatedStorage = game:GetService("ReplicatedStorage")

local playerDataTemplate = require(script.Parent.playerDataTemplate) --player data template
local deepCopy = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("Util").deepCopy) --deep copy function

local function addToPlayer(parent, table)
	for key, value in pairs(table) do
		if type(value) == "table" then
			local folder = Instance.new("Folder", parent)
			folder.Name = key
			addToPlayer(folder, value) --copy the values within the table value
		elseif type(value) == "number" then
			local val = Instance.new("NumberValue", parent)
			val.Name = key
			val.Value = value
		end
	end
end

local function onPlayerJoin(player, dataStore)
	local userId = player.UserId --unique player id

	local success, playerData = pcall(function()
		return dataStore:GetAsync(userId)
	end)

	--if success failed: could not retrieve data from player's datastore
	if not success then
		warn("failed to load data for", player.Name, playerData)
	elseif not playerData then
		print("creating new copy")

		local newPlayerData = deepCopy(playerDataTemplate)
		dataStore:SetAsync(userId, newPlayerData)

		local secondSuccess, newPlayerData = pcall(function()
			return dataStore:GetAsync(userId)
		end)

		if secondSuccess and type(newPlayerData) == "table" then
			playerData = newPlayerData
		end

		if not secondSuccess then
			warn("Failed to save new data for", player.Name)
			return
		end
	end

	print(playerData)
	addToPlayer(player, playerData)
end

return onPlayerJoin
