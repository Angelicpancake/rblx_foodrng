--[[
    This script checks if the player is within a specific shop area through async functions
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local OpenExclusiveGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").openExclusiveGui)
local WithinArea = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").withinArea)

local FusionShopHitbox: Part = Workspace:WaitForChild("Shops"):WaitForChild("FusionHitbox")
local FusionGui: ScreenGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FusionGui")
local DefaultGui: ScreenGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")

local function FusionAreaCheck()
	if WithinArea(FusionShopHitbox, FusionShopHitbox.Size.X / 2) then
		OpenExclusiveGui(FusionGui)
		while WithinArea(FusionShopHitbox, FusionShopHitbox.Size.X / 2) do
			task.wait()
		end
		OpenExclusiveGui(DefaultGui)
	end
end

local function CheckAreaInit()
	task.spawn(function()
		while true do
			FusionAreaCheck()

			task.wait(0.15)
		end --while
	end)
end

return CheckAreaInit
