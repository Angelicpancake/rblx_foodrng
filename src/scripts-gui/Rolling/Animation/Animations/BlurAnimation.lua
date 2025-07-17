local TweenService = game:GetService("TweenService")

local Animation = {}

Animation._BlurEffect = Instance.new("BlurEffect")
Animation._BlurEffect.Size = 0
Animation._BlurEffect.Parent = game.Lighting

local ShowInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
local HideInfo = TweenInfo.new(0.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

local ShowGoal = { Size = 24 }
local HideGoal = { Size = 0 }

local ShowTween = TweenService:Create(Animation._BlurEffect, ShowInfo, ShowGoal)
local HideTween = TweenService:Create(Animation._BlurEffect, HideInfo, HideGoal)

function Animation:Play()
    ShowTween:Play()
end

function Animation:Cleanup()
    ShowTween:Cancel()
    HideTween:Play()
end

return Animation