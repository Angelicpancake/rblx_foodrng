local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ViewportFrame = Players.LocalPlayer
	:WaitForChild("PlayerGui")
	:WaitForChild("RollingAnimationGui")
	:WaitForChild("RollingViewportFrame")
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)
local ParticleEmitterPartTemplate =
	ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Templates"):WaitForChild("ParticleEmitterPartTemplate")

local LastClicked = 0

local Animation = {}
Animation.__index = Animation

function Animation.new(Color: Color3)
	local self = setmetatable({}, Animation)
	self._Color = Color
	self._Amount = 60
	self._Trove = Trove.new()
	self._Completed = Instance.new("BindableEvent")
	self.CompletedEvent = self._Completed.Event
	self._ParticleEmitter = ParticleEmitterPartTemplate:Clone()
	self._Trove:Add(self._ParticleEmitter)
	return self
end

function Animation:Play()
	self._ParticleEmitter.Attachment.ParticleEmitter.Enabled = true
	self._ParticleEmitter.Attachment.ParticleEmitter.Color = ColorSequence.new(self._Color)
	self._ParticleEmitter.Attachment.ParticleEmitter.Rate = self._Amount
	self._ParticleEmitter.Parent = Workspace
	self._Trove:Add(RunService.RenderStepped:Connect(function(deltaTime)
		self._ParticleEmitter.CFrame = Workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2)
	end))

	self._Trove:Add(UserInputService.InputBegan:Connect(function(Input, GameProcessed)
		if GameProcessed then
			return
		end

		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			--add animation clicking cooldown
			LastClicked = os.clock() - 0.2

			local CurrentTime = os.clock()
			while CurrentTime - LastClicked < 1 do
				task.wait(0.7)
				self._Completed:Fire()
			end
		end
	end))
end

function Animation:Cleanup()
	self._Trove:Clean()
end

return Animation
