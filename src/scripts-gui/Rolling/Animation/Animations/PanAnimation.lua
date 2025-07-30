local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ViewportFrame = Players.LocalPlayer:WaitForChild("PlayerGui")
    :WaitForChild("RollingAnimationGui"):WaitForChild("RollingViewportFrame")
local WorldModel: WorldModel = Players.LocalPlayer:WaitForChild("PlayerGui")
    :WaitForChild("RollingAnimationGui"):WaitForChild("RollingViewportFrame"):WaitForChild("WorldModel")

local CookingPanTemplate = (ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates"):WaitForChild("Cooking pan")) :: Model
local PancakeTemplate = (ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates"):WaitForChild("Pancake")) :: Model
local RockParticleTemplate: Model = (ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates"):WaitForChild("RockParticle")) :: Model
local RollResultPartTemplate = (ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates"):WaitForChild("RollResultPart"))

local CookingPan: Model = nil
local Pancake: Model = nil
local RollResultPart: Part = nil

local ShineAnimation = require(script.Parent.ShineAnimation)

local PanAnimationTypes = require(Players.LocalPlayer:WaitForChild("PlayerScripts")
    :WaitForChild("Client"):WaitForChild("Types").PanAnimationTypes)

local Animation: PanAnimationTypes.AnimationType = {
    _Trove = Trove.new(),
    _Completed = Instance.new("BindableEvent"),
    Components = {
        ScalingAnimation = {
            ModelsToScale = {} :: {Model},
            Multiplier = 10,
            Duration = 0.8,
            EasingStyle = Enum.EasingStyle.Bounce,
            EasingDirection = Enum.EasingDirection.Out,
            _Trove = Trove.new(),
            _Tweens = {} :: {Tween},
            _ScaleValues = {} :: {NumberValue},
            _Completed = Instance.new("BindableEvent"),
            _CurrNumOfCompletedTweens = 0,
            _TargetScales = {} :: {number},
            _InitialScales = {} :: {number},
            Init = function(self)
                self.ModelsToScale = {CookingPan, Pancake}
                for _, Model in self.ModelsToScale do
                    self._TargetScales[Model.Name] = Model:GetScale()
                    self._InitialScales[Model.Name] = self._TargetScales[Model.Name] / self.Multiplier
                    self._ScaleValues[Model.Name] = Instance.new("NumberValue")

                    local ScaleValue = self._ScaleValues[Model.Name]
                    self._Trove:Add(ScaleValue)

                    local TweenInfo = TweenInfo.new(self.Duration, self.EasingStyle, self.EasingDirection)
                    local Goal = { Value = self._TargetScales[Model.Name] }

                    self._Tweens[Model.Name] = TweenService:Create(ScaleValue, TweenInfo, Goal)
                    self._Trove:Add(self._Tweens[Model.Name])

                    self._Trove:Add(
                        ScaleValue:GetPropertyChangedSignal("Value"):Connect(function()
                            Model:ScaleTo(ScaleValue.Value)
                        end)
                    )
                end
            end,
            Play = function(self)
                for _, Tween: Tween in self._Tweens do
                    Tween:Play()
                    self._Trove:Add(
                        Tween.Completed:Once(function()
                            if self._CurrNumOfCompletedTweens == #(self._Tweens) then
                                self._Completed:Fire()
                            end
                        end)
                    )
                end
            end,
            Cleanup = function(self)
                table.clear(self._TargetScales)
                table.clear(self._InitialScales)
                table.clear(self._ScaleValues)
                table.clear(self._Tweens)
                self._Trove:Clean()
                self._CurrNumOfCompletedTweens = 0
            end
        },
        FlippingAnimation = {
            ModelsToRotate = {} :: {Model},
            Repeats = 3,
            _Tweens = {
                _Up = {
                    Duration = 0.7,
                    EasingStyle = Enum.EasingStyle.Back,
                    EasingDirection = Enum.EasingDirection.In,
                    TargetRotation = 30,
                    _Tween = nil :: Tween?
                },
                _Down = {
                    Duration = 1,
                    EasingStyle = Enum.EasingStyle.Back,
                    EasingDirection = Enum.EasingDirection.In,
                    TargetRotation = 0,
                    _Tween = nil :: Tween?
                },
            },
            _LastRotationValue = 0,
            _CurrRepeats = 0,
            _RotationValue = nil :: NumberValue?,
            _Trove = Trove.new(),
            _Completed = Instance.new("BindableEvent"),
            _FlippedEvent = Instance.new("BindableEvent"),
            Init = function(self)
                self.ModelsToRotate = {CookingPan, Pancake}
                self._RotationValue = Instance.new("NumberValue")
                self._Trove:Add(self._RotationValue)

                for Key, Value in self._Tweens do
                    local TweenInfo = TweenInfo.new(Value.Duration, Value.EasingStyle, Value.EasingDirection)
                    local Target = Value.TargetRotation + self._LastRotationValue
                    --Make up tween rotate up
                    if Key == "_Up" then
                        Target = -Target
                    end
                    local Goal = { Value = Target }
                    Value._Tween = TweenService:Create(self._RotationValue, TweenInfo, Goal)
                    self._Trove:Add(Value._Tween)
                end

                --Value connections
                self._Trove:Add(
                    self._RotationValue:GetPropertyChangedSignal("Value"):Connect(function()
                        local RotationLeft = self._RotationValue.Value - self._LastRotationValue
                        self._LastRotationValue = self._RotationValue.Value
                        for _, Model in pairs(self.ModelsToRotate) do
                            Model:PivotTo(Model.PrimaryPart.CFrame
                                * CFrame.Angles(math.rad(0), math.rad(0), math.rad(RotationLeft)))
                        end
                    end)
                )

                --tween ordering
                local UpTween = self._Tweens._Up._Tween
                local DownTween = self._Tweens._Down._Tween
                self._Trove:Add(
                    UpTween.Completed:Connect(function()
                        self._FlippedEvent:Fire()
                        if self._CurrRepeats < self.Repeats then
                            DownTween:Play()
                        end
                    end)
                )
                self._Trove:Add(
                    DownTween.Completed:Connect(function()
                        self._CurrRepeats += 1
                        if self._CurrRepeats < self.Repeats then
                            UpTween:Play()
                        else
                            self._Completed:Fire()
                        end
                    end)
                )
            end,
            Play = function(self)
                self._Tweens._Up._Tween:Play()
            end,
            Cleanup = function(self)
                self._Trove:Clean()
                self._LastRotationValue = 0
                self._CurrRepeats = 0
            end
        },
        PancakeAnimation = {
            _Tweens = {
                _Up = {
                    Duration = 0.5,
                    EasingStyle = Enum.EasingStyle.Quad,
                    EasingDirection = Enum.EasingDirection.Out,
                    TargetHeight = 1,
                    _Tween = nil :: Tween?,
                },
                _Down = {
                    Duration = 0.5,
                    EasingStyle = Enum.EasingStyle.Quad,
                    EasingDirection = Enum.EasingDirection.In,
                    TargetHeight = 0,
                    _Tween = nil :: Tween?,
                },
                _SquishUp = {
                    Duration = 0.2,
                    EasingStyle = Enum.EasingStyle.Quad,
                    EasingDirection = Enum.EasingDirection.In,
                    TargetSquish = 0,
                    _Tween = nil :: Tween?,
                },
                _SquishDown = {
                    Duration = 0.4,
                    EasingStyle = Enum.EasingStyle.Quad,
                    EasingDirection = Enum.EasingDirection.Out,
                    TargetSquish = -0.145,
                    _Tween = nil :: Tween?,
                }
            },
            _Trove = Trove.new(),
            _HitPanEvent = Instance.new("BindableEvent"),
            _LastSquishValue = 0 :: number,
            _LastHeightValue = 0 :: number,
            _HeightValue = nil :: NumberValue?,
            _SquishValue = nil :: NumberValue?,
            _PancakeChildren = nil,
            --should change later to make more secure
            Init = function(self)
                self._PancakeChildren = Pancake:GetChildren()
                self._HeightValue = Instance.new("NumberValue")
                self._SquishValue = Instance.new("NumberValue")
                self._Trove:Add(self._HeightValue)
                self._Trove:Add(self._SquishValue)

                for Key, Value in self._Tweens do
                    local TweenInfo = TweenInfo.new(Value.Duration, Value.EasingStyle, Value.EasingDirection)
                    local Target
                    local TweenValue
                    if Value.TargetSquish then
                        Target = Value.TargetSquish
                        TweenValue = self._SquishValue
                    elseif Value.TargetHeight then
                        Target = Value.TargetHeight
                        TweenValue = self._HeightValue
                    end
                    --Make up tween rotate up
                    local Goal = { Value = Target }
                    Value._Tween = TweenService:Create(TweenValue, TweenInfo, Goal)
                    self._Trove:Add(Value._Tween)
                end

                --Value connections
                self._Trove:Add(
                    self._HeightValue:GetPropertyChangedSignal("Value"):Connect(function()
                        local HeightOffset = self._HeightValue.Value - self._LastHeightValue
                        self._LastHeightValue = self._HeightValue.Value
                        CookingPan.Shadow.Size += Vector3.new(HeightOffset / 4, 0, HeightOffset / 4)
                        Pancake:TranslateBy(Vector3.new(0, HeightOffset, 0))
                        Pancake:PivotTo(Pancake.PrimaryPart.CFrame
                            * CFrame.Angles(math.rad(0), math.rad(0), math.rad(12)))
                    end)
                )

                self._Trove:Add(
                    self._SquishValue:GetPropertyChangedSignal("Value"):Connect(function()
                        local SquishValue = self._SquishValue.Value
                        local YOffset = SquishValue - self._LastSquishValue
                        self._LastSquishValue = SquishValue
                        for _, Child in self._PancakeChildren do
                            if Child.ClassName == "MeshPart" or Child.ClassName == "BasePart" then
                                Child.Size += Vector3.new(-YOffset, YOffset, -YOffset)
                            end
                        end
                    end)
                )

                --Tween ordering
                local UpTween = self._Tweens._Up._Tween
                local DownTween = self._Tweens._Down._Tween
                local SquishDownTween = self._Tweens._SquishDown._Tween
                local SquishUpTween = self._Tweens._SquishUp._Tween
                self._Trove:Add(
                    UpTween.Completed:Connect(function()
                        DownTween:Play()
                    end)
                )
                self._Trove:Add(
                    DownTween.Completed:Connect(function()
                        self._HitPanEvent:Fire()
                        SquishDownTween:Play()
                    end)
                )
                self._Trove:Add(
                    SquishDownTween.Completed:Connect(function()
                        SquishUpTween:Play()
                    end)
                )
            end,
            Play = function(self)
                self._Tweens._Up._Tween:Play()
            end,
            Cleanup = function(self)
                self._Trove:Clean()
                self._LastSquishValue = 0
                self._LastHeightValue = 0
            end
        },
        ShakingAnimation = {
            _ModelsToShake = {} :: {Model},
            _Trove = Trove.new(),
            _OriginalScales = {},
            Speed = 7,
            _Tweens = {
                Explosion = {
                    Duration = 0.5,
                    EasingStyle = Enum.EasingStyle.Back,
                    EasingDirection = Enum.EasingDirection.In,
                    TargetMultiple = 7,
                    _Tweens = {} :: {Tween?},
                    _CurrNumOfCompletedTweens = 0
                }
            },
            _ElapsedTime = 0,
            _SeedX = nil :: number?,
            _SeedY = nil :: number?,
            _BaseCFrames = {} :: {Vector3?},
            _Completed = Instance.new("BindableEvent"),
            Init = function(self)
                self._ModelsToShake = {CookingPan, Pancake}

                --Shaking stuff
                for _, Model in self._ModelsToShake do
                    self._BaseCFrames[Model] = Model.PrimaryPart.CFrame
                end
                self._SeedX = math.random(1, 1000)
                self._SeedY = math.random(1, 1000)

                --Explosion Stuff
                local Component = self._Tweens.Explosion
                for _, Model in self._ModelsToShake do
                    self._OriginalScales[Model] = Model:GetScale()
                    local TweenValue = Instance.new("NumberValue")
                    TweenValue.Value = self._OriginalScales[Model]
                    self._Trove:Add(TweenValue)
                    local TweenInfo = TweenInfo.new(Component.Duration, Component.EasingStyle, Component.EasingDirection)
                    local Target = self._OriginalScales[Model] * Component.TargetMultiple
                    local Goal = {Value = Target}

                    local Tween = TweenService:Create(TweenValue, TweenInfo, Goal)
                    table.insert(Component._Tweens, Tween)
                    self._Trove:Add(Tween)
                    self._Trove:Add(TweenValue:GetPropertyChangedSignal("Value"):Connect(function()
                        Model:ScaleTo(TweenValue.Value)
                    end))

                    self._Trove:Add(Tween.Completed:Once(function()
                        Component._CurrNumOfCompletedTweens += 1
                        if Component._CurrNumOfCompletedTweens == #(Component._Tweens) then
                            self._Completed:Fire()
                        end
                    end))
                end
            end,
            Play = function(self)
                self._Trove:Add(UserInputService.InputBegan:Connect(function(Input, GameProcessed)
                    if GameProcessed then return end

                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        for _, TweenComponent in self._Tweens.Explosion._Tweens do
                            TweenComponent:Play()
                        end
                    end
                end))
                self._Trove:Add(RunService.RenderStepped:Connect(function(dt)
                    self._ElapsedTime += dt * self.Speed
                    local RandomZ = math.noise(self._ElapsedTime, self._SeedX) / 2

                    for Model, ModelCFrame : CFrame in self._BaseCFrames do
                        local NewPosition = ModelCFrame * CFrame.Angles(
                            math.rad(0),
                            math.rad(0),
                            RandomZ
                        )
                        Model:PivotTo(NewPosition)
                    end
                end))
            end,
            Cleanup = function(self)
                self._Trove:Clean()
                table.clear(self._ModelsToShake)
                table.clear(self._BaseCFrames)
                table.clear(self._Tweens.Explosion._Tweens)
                self._Tweens.Explosion._CurrNumOfCompletedTweens = 0
                self._ElapsedTime = 0
            end
        },
        ShineAnimatiion = {}
    },

    Colors = {
        ["Common"] = Color3.fromRGB(113, 111, 109),
        ["Uncommon"] = Color3.fromRGB(78, 132, 95),
        ["Rare"] = Color3.fromRGB(40, 70, 105),
        ["Epic"] = Color3.fromRGB(71, 57, 87),
        ["Legendary"] = Color3.fromRGB(198, 139, 44),
        ["Mythic"] = Color3.fromRGB(137, 51, 71)
    },

    Init = function(self)
        CookingPan = CookingPanTemplate:Clone()
        CookingPan.Parent = WorldModel
        Pancake = PancakeTemplate:Clone()
        Pancake.Parent = WorldModel

        RollResultPart = RollResultPartTemplate:Clone()
        RollResultPart.FrontDecal.Transparency = 1
        RollResultPart.BackDecal.Transparency = 1
        RollResultPart.Parent = WorldModel

        self._Trove:Add(CookingPan)
        self._Trove:Add(Pancake)
        self._Trove:Add(RollResultPart)
        self.Components.ScalingAnimation:Init()
        self.Components.FlippingAnimation:Init()
        self.Components.PancakeAnimation:Init()
        self.Components.ShakingAnimation:Init()
    end,

    Play = function(self, RollResult)
        --Change color based on rarity
        Pancake.MeshPart.Color = self.Colors[RollResult.Food.rarity]
        self.Components.ShineAnimation = ShineAnimation.new(self.Colors[RollResult.Food.rarity])

        RollResultPart.FrontDecal.Texture = RollResult.Food.image
        RollResultPart.BackDecal.Texture = RollResult.Food.image

        --First Scale
        self._Trove:Add(
            self.Components.ScalingAnimation._Completed.Event:Once(function()
                self.Components.FlippingAnimation:Play()
            end)
        )
        --then flip
        self._Trove:Add(
            self.Components.FlippingAnimation._FlippedEvent.Event:Connect(function()
                --make pancake go in air when flipping up
                self.Components.PancakeAnimation:Play()
            end)
        )

        self._Trove:Add(
            self.Components.PancakeAnimation._HitPanEvent.Event:Connect(function()
                --Make pancake same orientation as pan after flipping in the air
                local Remaining = self.Components.FlippingAnimation._RotationValue.Value
                   - Pancake.PrimaryPart.Orientation.Z
                Pancake:PivotTo(Pancake.PrimaryPart.CFrame * CFrame.Angles(
                    math.rad(0),
                    math.rad(0),
                    math.rad(Remaining)
                ))
                -- make cracks more visible
                for _, Child in Pancake.MeshPart:GetChildren() do
                    if Child.ClassName == ("Decal") then
                        Child.Transparency -= 1/(self.Components.FlippingAnimation.Repeats)
                    end
                end

                --Cracking particle effect stuff
                local NumOfParticles = 100
                local Duration = 10
                local MaxX = 0.57
                local MinX = 0.44
                local MaxY = 0.60
                local MinY = 0.45
                local MaxVel = 5
                local MinVel = 1
                local MinAngle = -150
                local MaxAngle = -30
                for i = 1, NumOfParticles, 1 do
                    task.spawn(function()
                        local RockParticle = RockParticleTemplate:Clone()
                        self._Trove:Add(RockParticle)
                        local RandomXPos = math.random() * (MaxX - MinX) + MinX
                        local RandomYPos = math.random() * (MaxY - MinY) + MinY
                        local RandomVel = math.random(MinVel, MaxVel)
                        local RandomAngle = math.random(MinAngle, MaxAngle)
                        local RandomSizeX = math.random(5, 10)
                        local RandomSizeY = math.random(5, 10)
                        RockParticle.Position = UDim2.new(RandomXPos, 0, RandomYPos, 0)
                        RockParticle.Parent = ViewportFrame
                        RockParticle.BackgroundColor3 = self.Colors[RollResult.Food.rarity]
                        RockParticle.Size = UDim2.new(0, RandomSizeX, 0, RandomSizeY)
                        local YVel = -(math.ceil(math.sin(math.rad(RandomAngle)) * RandomVel) + 10)
                        local XVel = math.ceil(math.cos(math.rad(RandomAngle)) * RandomVel)
                        local StartTime = os.time()
                        while os.time() - StartTime < Duration do
                            --negative y velocity is up
                            YVel += 0.2
                            RockParticle.Position += UDim2.new(0, XVel, 0, YVel)
                            -- RockParticle.ImageTransparency += 0.01
                            -- RockParticle.BackgroundTransparency += 0.01
                            task.wait(0.001)
                        end
                        self._Trove:Remove(RockParticle)
                    end)
                end
            end)
        )

        local ShakingAnimationPlayed = false

        self._Trove:Add(self.Components.FlippingAnimation._Completed.Event:Once(function()
            self.Components.ShakingAnimation:Play()
            ShakingAnimationPlayed = true
        end))

        self._Trove:Add(self.Components.ShakingAnimation._Completed.Event:Once(function()
            --Delete all previous animation things
            self.Components.ShakingAnimation:Cleanup()
            self._Trove:Remove(CookingPan)
            self._Trove:Remove(Pancake)

            RollResultPart.FrontDecal.Transparency = 0
            RollResultPart.BackDecal.Transparency = 0
            self.Components.ShineAnimation:Play()
        end))

        self._Trove:Add(UserInputService.InputBegan:Connect(function(Input, GameProcessed)
            if GameProcessed then return end

            if Input.UserInputType == Enum.UserInputType.MouseButton1 and not ShakingAnimationPlayed then
                print(self._Trove)
                self.Components.ScalingAnimation:Cleanup()
                self.Components.FlippingAnimation:Cleanup()
                self.Components.PancakeAnimation:Cleanup()
                for _, TweenComponent in self.Components.ShakingAnimation._Tweens.Explosion._Tweens do
                    TweenComponent:Play()
                end
                ShakingAnimationPlayed = true
            end
        end))


        self._Trove:Add(self.Components.ShineAnimation.CompletedEvent:Once(function()
            self._Completed:Fire()
        end))
    
        --start off animation with scaling animation
        self.Components.ScalingAnimation:Play()
    end,

    Cleanup = function(self)
        self._Trove:Clean()
        self.Components.ShineAnimation:Cleanup()
        self.Components.ShakingAnimation:Cleanup()
        self.Components.PancakeAnimation:Cleanup()
        self.Components.FlippingAnimation:Cleanup()
        self.Components.ScalingAnimation:Cleanup()
    end
}

return Animation