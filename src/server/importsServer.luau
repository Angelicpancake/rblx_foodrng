local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local imports = {}

imports.rep = ReplicatedStorage
imports.work = Workspace
imports.repEvents = imports.rep.Events

imports.players = game:GetService("Players")

return imports