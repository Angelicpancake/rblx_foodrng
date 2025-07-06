local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local DefaultGui = PlayerGui:WaitForChild("DefaultGui")
local RollButton = DefaultGui:WaitForChild("RollButton")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")
local RollEvent = Events:WaitForChild("Rng"):WaitForChild("RollEvent")

local RollingDefaultButtonInit = require(script.Parent.rollingDefaultButton)

local function RollingInit()
	RollingDefaultButtonInit(RollButton, RollEvent)
end

return RollingInit
