--!strict
local PolicyService = game:GetService("PolicyService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local WorldModel: WorldModel = Players.LocalPlayer:WaitForChild("PlayerGui")
    :WaitForChild("RollingAnimationGui"):WaitForChild("RollingViewportFrame"):WaitForChild("WorldModel")
local CookingPan: Model = (WorldModel:WaitForChild("Cooking pan")) :: Model
local Pancake: Model = (WorldModel:WaitForChild("Pancake")) :: Model

local PanAnimationTypes = require(Players.LocalPlayer:WaitForChild("PlayerScripts")
    :WaitForChild("Client"):WaitForChild("Types").PanAnimationTypes)

local Animation: PanAnimationTypes.AnimationType = {
    Cleaning = false,
    PancakeConnection = nil :: RBXScriptConnection?,
    Components = {
        ScalingAnimation = {
            ModelsToScale = {CookingPan, Pancake},
            TargetScales = {} :: {number},
            InitialScales = {} :: {number},
            Multiplier = 10,
            Duration = 0.8,
            EasingStyle = Enum.EasingStyle.Bounce,
            EasingDirection = Enum.EasingDirection.Out,
            ScaleValues = {} :: {NumberValue},
            Tweens = {} :: {Tween},
            NumOfCompletedTweens = 0,
            Completed = Instance.new("BindableEvent"),
            Init = function(self)
                local Models = {CookingPan, Pancake}
                for _, Model in Models do
                    self.TargetScales[Model.Name] = Model:GetScale()
                    self.InitialScales[Model.Name] = self.TargetScales[Model.Name] / self.Multiplier
                    self.ScaleValues[Model.Name] = Instance.new("NumberValue")
                    local TargetScale = self.TargetScales[Model.Name]
                    local ScaleValue = self.ScaleValues[Model.Name]
                    local TweenInfo = TweenInfo.new(self.Duration, self.EasingStyle, self.EasingDirection)
                    local Goal = { Value = TargetScale }

                    self.Tweens[Model.Name] = TweenService:Create(ScaleValue, TweenInfo, Goal)

                    ScaleValue:GetPropertyChangedSignal("Value"):Connect(function()
                        Model:ScaleTo(ScaleValue.Value)
                    end)
                end
            end,
            Play = function(self)
                for _, Tween: Tween in self.Tweens do
                    Tween:Play()
                    Tween.Completed:Once(function()
                        if self.NumOfCompletedTweens == #(self.Tweens) then
                            print("All Tween Completed")
                            self.Completed:Fire()
                        end
                    end)
                end
            end,
            Cleanup = function(self)
                for _, Model in self.ModelsToScale do
                    self.Tweens[Model.Name]:Cancel()
                    local InitialScale = self.InitialScales[Model.Name]
                    self.ScaleValues[Model.Name].Value = InitialScale
                    Model:ScaleTo(InitialScale)
                end
                self.NumOfCompletedTweens = 0
                return true
            end
        },
        FlippingAnimation = {
            ModelsToRotate = {CookingPan, Pancake},
            OriginalCFrames = {},
            UpDuration = 0.7,
            UpEasingStyle = Enum.EasingStyle.Back,
            UpEasingDirection = Enum.EasingDirection.In,
            DownDuration = 1,
            DownEasingStyle = Enum.EasingStyle.Back,
            DownEasingDirection = Enum.EasingDirection.In,
            UpTargetRotation = 30,
            DownTargetRotation = 0,
            CurrentRotation = 0,
            CurrRepeats = 0,
            RotationValue = Instance.new("NumberValue"),
            UpTween = nil :: Tween?,
            DownTween = nil :: Tween?,
            UpTweenConnection = nil :: RBXScriptConnection?,
            DownTweenConnection = nil :: RBXScriptConnection?,
            RotationValueConnection = nil :: RBXScriptConnection?,
            Repeats = 999,
            ShouldRepeat = false :: boolean,
            OriginalPanCFrame = CookingPan.PrimaryPart.CFrame,
            Init = function(self)
                for _, Model in pairs(self.ModelsToRotate) do
                    self.OriginalCFrames[Model.Name] = Model.PrimaryPart.CFrame
                end
                local UpTweenInfo = TweenInfo.new(self.UpDuration, self.UpEasingStyle, self.UpEasingDirection)
                local UpGoal = { Value = -(self.UpTargetRotation + self.CurrentRotation) }

                local DownTweenInfo = TweenInfo.new(self.DownDuration, self.DownEasingStyle, self.DownEasingDirection)
                local DownGoal = { Value = self.DownTargetRotation + self.CurrentRotation }

                self.UpTween = TweenService:Create(self.RotationValue, UpTweenInfo, UpGoal)
                self.DownTween = TweenService:Create(self.RotationValue, DownTweenInfo, DownGoal)
                self.RotationValueConnection = self.RotationValue:GetPropertyChangedSignal("Value"):Connect(function()
                    if self.Cleaning then
                        return
                    end
                    local RotationLeft = self.RotationValue.Value - self.CurrentRotation
                    self.CurrentRotation = self.RotationValue.Value
                    for _, Model in pairs(self.ModelsToRotate) do
                        Model:PivotTo(Model.PrimaryPart.CFrame
                            * CFrame.Angles(math.rad(0), math.rad(0), math.rad(RotationLeft)))
                    end
                end)

                self.UpTweenConnection = self.UpTween.Completed:Connect(function()
                    if self.CurrRepeats < self.Repeats and self.ShouldRepeat then
                        self.DownTween:Play()
                    end
                end)

                self.DownTweenConnection = self.DownTween.Completed:Connect(function()
                    if self.CurrRepeats < self.Repeats and self.ShouldRepeat then
                        self.UpTween:Play()
                        self.CurrRepeats += 1
                    end
                end)
            end,
            Play = function(self)
                self.ShouldRepeat = true
                self.UpTween:Play()
            end,
            Cleanup = function(self)
                self.ShouldRepeat = false
                self.UpTween:Cancel()
                self.DownTween:Cancel()

                self.CurrentRotation = 0
                self.CurrRepeats = 0
                self.RotationValue.Value = 0
                for _, Model in pairs(self.ModelsToRotate) do
                    Model:PivotTo(self.OriginalCFrames[Model.Name])
                end
                return true
            end
        },
        PancakeAnimation = {
            UpDuration = 0.5,
            UpEasingStyle = Enum.EasingStyle.Quad,
            UpEasingDirection = Enum.EasingDirection.Out,
            DownDuration = 0.5,
            DownEasingStyle = Enum.EasingStyle.Quad,
            DownEasingDirection = Enum.EasingDirection.In,
            SquishUpDuration = 0.2,
            SquishUpEasingStyle = Enum.EasingStyle.Quad,
            SquishUpEasingDirection = Enum.EasingDirection.In,
            SquishDownDuration = 0.4,
            SquishDownEasingStyle = Enum.EasingStyle.Quad,
            SquishDownEasingDirection = Enum.EasingDirection.Out,
            TargetHeight = 1,
            TargetSquish = -0.145,
            LastSquishValue = 0 :: number,
            LastHeightValue = 0 :: number,
            HeightValue = Instance.new("NumberValue") :: NumberValue,
            SquishValue = Instance.new("NumberValue") :: NumberValue,
            UpTween = nil :: Tween?,
            DownTween = nil :: Tween?,
            SquishDownTween = nil :: Tween?,
            SquishUpTween = nil :: Tween?,
            HeightValueConnection = nil :: RBXScriptConnection?,
            OriginalCFrame = Pancake.PrimaryPart.CFrame,
            --should change later to make more secure
            Textures = Pancake.MeshPart:GetChildren(),
            PancakeChildren = Pancake:GetChildren(),
            Init = function(self)
                local UpTweenInfo = TweenInfo.new(self.UpDuration, self.UpEasingStyle, self.UpEasingDirection)
                local UpGoal = { Value = self.TargetHeight }
                local DownTweenInfo = TweenInfo.new(self.DownDuration, self.DownEasingStyle, self.DownEasingDirection)
                local DownGoal = { Value = 0 }
                local SquishUpTweenInfo = TweenInfo.new(self.SquishUpDuration, self.SquishUpEasingStyle, self.SquishUpEasingDirection)
                local SquishUpGoal = { Value = 0 }
                local SquishDownTweenInfo = TweenInfo.new(self.SquishDownDuration, self.SquishDownEasingStyle, self.SquishDownEasingDirection)
                local SquishDownGoal = { Value = self.TargetSquish }

                self.UpTween = TweenService:Create(self.HeightValue, UpTweenInfo, UpGoal)
                self.DownTween = TweenService:Create(self.HeightValue, DownTweenInfo, DownGoal)
                self.SquishDownTween = TweenService:Create(self.SquishValue, SquishDownTweenInfo, SquishDownGoal)
                self.SquishUpTween = TweenService:Create(self.SquishValue, SquishUpTweenInfo, SquishUpGoal)

                --should make this more descriptive later
                self.DownTween.Completed:Connect(function()
                    for _, Texture: Texture in ipairs(self.Textures) do
                        -- Texture.Transparency -= 0.5
                    end
                end)

                self.HeightValueConnection = self.HeightValue:GetPropertyChangedSignal("Value"):Connect(function()
                    local HeightOffset = self.HeightValue.Value - self.LastHeightValue
                    self.LastHeightValue = self.HeightValue.Value
                    Pancake:TranslateBy(Vector3.new(0, HeightOffset, 0))
                    Pancake:PivotTo(Pancake.PrimaryPart.CFrame
                        * CFrame.Angles(math.rad(0), math.rad(0), math.rad(12)))
                end)

                self.SquishValueConnection = self.SquishValue:GetPropertyChangedSignal("Value"):Connect(function()
                    local SquishValue = self.SquishValue.Value
                    local YOffset = SquishValue - self.LastSquishValue
                    self.LastSquishValue = SquishValue
                    for _, Child in self.PancakeChildren do
                        if Child.ClassName == "MeshPart" or Child.ClassName == "BasePart" then
                            Child.Size += Vector3.new(-YOffset, YOffset, -YOffset)
                        end
                    end
                end)
            end,
            Play = function(self)
                self.UpTween:Play()
                self.UpTween.Completed:Once(function()
                    self.DownTween:Play()
                end)
                self.DownTween.Completed:Once(function()
                    self.SquishDownTween:Play()
                end)
                self.SquishDownTween.Completed:Once(function()
                    self.SquishUpTween:Play()
                end)
            end,
            Cleanup = function(self)
                self.UpTween:Cancel()
                self.DownTween:Cancel()
                print("changed height value")
                self.HeightValue.Value = 0
                self.SquishValue.Value = 0
                self.LastHeightValue = 0
                self.LastSquishValue = 0
                for _, Texture: Texture in ipairs(self.Textures) do
                        Texture.Transparency = 1
                end
                return true
            end
        }
    },

    Init = function(self)
        self.Components.ScalingAnimation:Init()
        self.Components.FlippingAnimation:Init()
        self.Components.PancakeAnimation:Init()
        self.PancakeConnection = self.Components.FlippingAnimation.UpTween.Completed:Connect(function()
            if not self.Cleaning then
                self.Components.PancakeAnimation:Play()
                self.Components.FlippingAnimation.ModelsToRotate[Pancake] = nil
            end
        end)
        self.Components.PancakeAnimation.DownTween.Completed:Connect(function()
            self.Components.FlippingAnimation.ModelsToRotate[Pancake] = Pancake
            local Remaining = self.Components.FlippingAnimation.RotationValue.Value - Pancake.PrimaryPart.Orientation.Z
            Pancake:PivotTo(Pancake.PrimaryPart.CFrame * CFrame.Angles(
                math.rad(0),
                math.rad(0),
                math.rad(Remaining)
            ))
        end)
    end,

    Play = function(self)
        while self.Cleaning do
            task.wait(0.1)
        end
        self.Components.ScalingAnimation:Play()
        self.Components.ScalingAnimation.Completed.Event:Once(function()
            self.Components.FlippingAnimation:Play()
        end)
    end,

    Cleanup = function(self)
        self.Cleaning = true
        local Done1 = self.Components.FlippingAnimation:Cleanup()
        local Done2 = self.Components.ScalingAnimation:Cleanup()
        local Done3 = self.Components.PancakeAnimation:Cleanup()
        while not Done1 and not Done2 and not Done3 do
            task.wait(0.1)
        end
        self.Cleaning = false
    end
}

return Animation