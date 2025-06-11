local imports = {}

local playerScripts = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts")

local i = require(playerScripts.Client.importsClient)

imports.general = i
imports.rollEvent = imports.general.repEvents.rng.rollEvent

return imports