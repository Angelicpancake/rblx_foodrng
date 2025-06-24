local ReplicatedStorage = game:GetService("ReplicatedStorage")

local playerDataTemplate = require(script.Parent.playerDataTemplate)
local deepCopy = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").deepCopy)

local function onPlayerJoin(player, dataStore)
	local userId = player.UserId
	local success, playerData = pcall(function()
		return dataStore:GetAsync(userId)
	end)

	local inventory = Instance.new("Folder", player)
	inventory.Name = "Inventory"

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
