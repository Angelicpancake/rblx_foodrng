local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local imports = {}

imports.rep = ReplicatedStorage
imports.work = Workspace
imports.repEvents = imports.rep:WaitForChild("Events")

imports.players = game:GetService("Players")
imports.locPlay = imports.players.LocalPlayer
imports.ui = imports.locPlay:WaitForChild("PlayerGui")

return imports