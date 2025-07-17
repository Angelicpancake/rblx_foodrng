--!strict
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local WorldModel: WorldModel = Players.LocalPlayer:WaitForChild("PlayerGui")
    :WaitForChild("RollingAnimationGui"):WaitForChild("RollingViewportFrame"):WaitForChild("WorldModel")
local CookingPan: Model = (WorldModel:WaitForChild("Cooking pan")) :: Model

local PanAnimationTypes = require(Players.LocalPlayer:WaitForChild("PlayerScripts")
    :WaitForChild("Client"):WaitForChild("Types").PanAnimationTypes)

local Animation: PanAnimationTypes.AnimationType = {
    Components = {
        ScalingAnimation = {
            InitialScale = 0.1,
            TargetScale = 1,
            Duration = 0.8,
            EasingStyle = Enum.EasingStyle.Bounce,
            EasingDirection = Enum.EasingDirection.Out,
            ScaleValue = Instance.new("NumberValue"),
            Tween = nil :: Tween?,
            Init = function(self)
                local TweenInfo = TweenInfo.new(self.Duration, self.EasingStyle, self.EasingDirection)
                local Goal = { Value = self.TargetScale }

                self.Tween = TweenService:Create(self.ScaleValue, TweenInfo, Goal)

                self.ScaleValue:GetPropertyChangedSignal("Value"):Connect(function()
                    CookingPan:ScaleTo(self.ScaleValue.Value)
                end)
            end
        },
        FlippingAnimation = {Tween = nil}
    },

    Init = function(self)
        self.Components.ScalingAnimation:Init()
    end,

    Play = function(self)
        for Key, AnimationComponent: any in self.Components do
            if AnimationComponent.Tween then AnimationComponent.Tween:Play() end
        end
    end,

    Cleanup = function(self)
        for Key, AnimationComponent: any in self.Components do
        if Key == "PanModel" then continue end

        if AnimationComponent.Tween then AnimationComponent.Tween:Cancel() end
        end

        self.Components.ScalingAnimation.ScaleValue.Value = 0.1
    end
}

Animation.Components.ScalingAnimation.ScaleValue.Value = Animation.Components.ScalingAnimation.InitialScale

return Animation