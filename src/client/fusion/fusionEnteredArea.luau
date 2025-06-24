local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local locPlayer = Players.LocalPlayer

local fusionHitbox = Workspace:WaitForChild("shops"):WaitForChild("fusionHitbox")

local withinArea = require(script.Parent.Parent.WithinArea)

local openGui = require(locPlayer:WaitForChild("PlayerScripts"):WaitForChild("Client"):WaitForChild("OpenGui"))
local fusionGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("FusionGui")
--local defaultGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")

--default gui gets error does not exist

--[[local currentlyWithin = false

local function checkFusionEntered()
	if withinArea(fusionHitbox) then
		if not currentlyWithin then
			currentlyWithin = true
			openGui(fusionGui)
		end
	else
		currentlyWithin = false
		openGui(defaultGui)
	end
end

return checkFusionEntered]]
--

return function() end
