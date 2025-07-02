local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local locPlayer = Players.LocalPlayer

local fusionHitbox = Workspace:WaitForChild("Shops"):WaitForChild("FusionHitbox")

local withinArea = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").withinArea)

local openExclusiveGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").openExclusiveGui)
local fusionGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("FusionGui")
local defaultGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")

local currentlyWithin = false

local function checkFusionEntered()
	if withinArea(fusionHitbox) then
		currentlyWithin = true
		openExclusiveGui(fusionGui)
	elseif currentlyWithin then
		currentlyWithin = false
		openExclusiveGui(defaultGui)
	end
end

return checkFusionEntered
