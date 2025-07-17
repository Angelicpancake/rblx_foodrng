local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local DefaultGui = PlayerGui:WaitForChild("DefaultGui")
local RollButton = DefaultGui:WaitForChild("RollButton")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

local RngEvents = Events:WaitForChild("Rng")
local RollEvent = RngEvents:WaitForChild("RollEvent")
local RollResultEvent: RemoteEvent = RngEvents:WaitForChild("RollResultEvent")

local RollingDefaultButtonInit = require(script.Parent.rollingDefaultButton)
local RollingAnimationInit = require(script.Parent.Animation.AnimationHandler)

local function RollingInit()
	RollingDefaultButtonInit(RollButton, RollEvent)
	RollingAnimationInit(RollResultEvent)
end

return RollingInit
