local ProximityPromptService = game:GetService("ProximityPromptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local locPlayer = Players.LocalPlayer

local FusionShopHitbox: Part = Workspace:WaitForChild("Shops"):WaitForChild("FusionHitbox")

local OpenExclusiveGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").openExclusiveGui)
local FusionGui: ScreenGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("FusionGui")
local DefaultGui: ScreenGui = locPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")

local WithinArea = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").withinArea)

--[[
    Initializes function connectiosn to shop hitboxes which checks if the player is within them
]]--
local function CheckAreaInit()
    task.spawn(function()
        local FusionShopDistance = 20
        while true do
            if WithinArea(FusionShopHitbox, FusionShopDistance) then
                OpenExclusiveGui(FusionGui)
                while WithinArea(FusionShopHitbox, FusionShopDistance) do
                    task.wait()
                end
                OpenExclusiveGui(DefaultGui)
            end

            task.wait(0.1)
        end
    end)
end

return CheckAreaInit