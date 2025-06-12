local imports = {}

local playerScripts = game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts")

local i = require(playerScripts:WaitForChild("Client").importsClient)

imports.general = i
imports.fusionGui = imports.general.ui:WaitForChild("RollGui")

return imports