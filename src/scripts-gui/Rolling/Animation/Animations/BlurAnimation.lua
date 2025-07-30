local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

local Animation = {}

Animation._BlurEffect = Lighting.DepthOfField
Animation._BlurEffect.InFocusRadius = 50
Animation._BlurEffect.Parent = game.Lighting

local ShowInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
local HideInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

local ShowGoal = { InFocusRadius = 5 }
local HideGoal = { InFocusRadius = 50 }

local ShowTween = TweenService:Create(Animation._BlurEffect, ShowInfo, ShowGoal)
local HideTween = TweenService:Create(Animation._BlurEffect, HideInfo, HideGoal)

function Animation:Play()
    Animation._BlurEffect.Enabled = true
    ShowTween:Play()
end

function Animation:Cleanup()
    ShowTween:Cancel()
    HideTween:Play()
    HideTween.Completed:Once(function()
        Animation._BlurEffect.Enabled = false
    end)
end

return Animation