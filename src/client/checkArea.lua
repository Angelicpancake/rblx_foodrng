local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local locPlayer = Players.LocalPlayer

local FusionProxPrompt: ProximityPrompt = Workspace:WaitForChild("Shops"):WaitForChild("FusionHitbox"):WaitForChild("ProximityPrompt")

local openExclusiveGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").openExclusiveGui)
local fusionGui: ScreenGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("FusionGui")
local defaultGui: ScreenGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")

local currentlyWithin = false

local function CheckAreaInit()
    FusionProxPrompt.PromptShown:Connect(function(promptObject, player)
        openExclusiveGui(fusionGui)
        FusionProxPrompt.PromptHidden:Connect(function()
            if fusionGui.Enabled then
                openExclusiveGui(defaultGui)
            end
        end)
    end)
end

return CheckAreaInit