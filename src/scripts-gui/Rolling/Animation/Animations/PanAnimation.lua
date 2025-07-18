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
        FlippingAnimation = {
            UpDuration = 0.5,
            UpEasingStyle = Enum.EasingStyle.Back,
            UpEasingDirection = Enum.EasingDirection.In,
            DownDuration = 0.6,
            DownEasingStyle = Enum.EasingStyle.Back,
            DownEasingDirection = Enum.EasingDirection.In,
            UpTargetRotation = 30,
            DownTargetRotation = 0,
            CurrentRotation = 0,
            CurrRepeats = 0,
            RotationValue = Instance.new("NumberValue"),
            UpTween = nil :: Tween?,
            DownTween = nil :: Tween?,
            Repeats = 3,
            Init = function(self)
                self.RotationValue.Value = 0
                local UpTweenInfo = TweenInfo.new(self.UpDuration, self.UpEasingStyle, self.UpEasingDirection)
                local UpGoal = { Value = -(self.UpTargetRotation + self.CurrentRotation) }

                local DownTweenInfo = TweenInfo.new(self.DownDuration, self.DownEasingStyle, self.DownEasingDirection)
                local DownGoal = { Value = self.DownTargetRotation + self.CurrentRotation }

                self.UpTween = TweenService:Create(self.RotationValue, UpTweenInfo, UpGoal)
                self.DownTween = TweenService:Create(self.RotationValue, DownTweenInfo, DownGoal)

                self.RotationValue:GetPropertyChangedSignal("Value"):Connect(function()
                    local RotationLeft = self.RotationValue.Value - self.CurrentRotation
                    self.CurrentRotation = self.RotationValue.Value
                    CookingPan:PivotTo(CookingPan.PrimaryPart.CFrame
                        * CFrame.Angles(math.rad(0), math.rad(0), math.rad(RotationLeft))
)                end)

                self.UpTween.Completed:Connect(function()
                    if self.CurrRepeats <= self.Repeats then
                        self.DownTween:Play()
                    end
                end)
                self.DownTween.Completed:Connect(function()
                    if self.CurrRepeats <= self.Repeats then
                        self.UpTween:Play()
                    end
                end)
            end,
        }
    },

    Init = function(self)
        self.Components.ScalingAnimation:Init()
        self.Components.FlippingAnimation:Init()
    end,

    Play = function(self)
        self.Components.ScalingAnimation.Tween:Play()
        self.Components.ScalingAnimation.Tween.Completed:Connect(function()
            self.Components.FlippingAnimation.UpTween:Play()
        end)
    end,

    Cleanup = function(self)
        for Key, AnimationComponent: any in self.Components do
        if Key == "PanModel" then continue end

        if AnimationComponent.Tween then AnimationComponent.Tween:Cancel() end
        end

        self.Components.ScalingAnimation.ScaleValue.Value = 0.1
        self.Components.FlippingAnimation.RotationValue.Value = 0
        self.Components.FlippingAnimation.CurrRepeats = 0
        self.Components.FlippingAnimation.CurrentRotation = 0
    end
}

Animation.Components.ScalingAnimation.ScaleValue.Value = Animation.Components.ScalingAnimation.InitialScale

return Animation