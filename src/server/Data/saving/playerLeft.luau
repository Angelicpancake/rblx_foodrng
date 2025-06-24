--[[
    save user data when they leave
]]
local replicatedStorage = game:GetService("ReplicatedStorage")

--[[
    go through the player's data folders and create a table based on those values. 
    Use this to save the data to the datastore
]]
local function create(folder)
	local result = {}
	for _, instance in pairs(folder:GetChildren()) do
		if instance:IsA("Folder") then --if folder then recurse
			result[instance.Name] = create(instance)
		elseif instance:IsA("NumberValue") then
			result[instance.Name] = instance.Value
		end
	end
	return result
end

local function onPlayerLeft(player, dataStore)
	local userID = player.UserId
	local savedData = {}

	savedData.Inventory = create(player:WaitForChild("Inventory"))
	savedData.Profile = create(player:WaitForChild("Profile"))

	local success, err = pcall(function()
		dataStore:SetAsync(userID, savedData)
	end)

	if success then
		print("Successfully saved data for", player.Name)
	else
		warn("Failed to save data for", player.Name, err)
	end

	print("on-leave", savedData)
end

return onPlayerLeft
