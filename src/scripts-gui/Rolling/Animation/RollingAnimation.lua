local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local openExclusiveGui = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Util").openExclusiveGui)

local RollingAnimationGui = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RollingAnimationGui")
local DefaultGui = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("DefaultGui")

local PanAnimation = require(script.Parent.Animations.PanAnimation)
local BlurAnimation = require(script.Parent.Animations.BlurAnimation)

local function RollingAnimationInit()
    PanAnimation:Init()
end

local function EndRollingAnimation()
    openExclusiveGui(DefaultGui)
    PanAnimation:Cleanup()
    BlurAnimation:Cleanup()
    RollingAnimationInit()
end

local function PlayRollingAnimation(RollResult)
    PanAnimation._Completed.Event:Once(function()
        EndRollingAnimation()
    end)
    openExclusiveGui(RollingAnimationGui)
    BlurAnimation:Play()
    PanAnimation:Play(RollResult)
end

return {PlayRollingAnimation = PlayRollingAnimation, RollingAnimationInit = RollingAnimationInit}