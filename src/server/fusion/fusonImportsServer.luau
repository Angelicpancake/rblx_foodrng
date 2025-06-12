local ServerScriptService = game:GetService("ServerScriptService")

local imports = {}

local i = require(ServerScriptService:WaitForChild("Server").importsServer)

imports.general = i
imports.fusionHitbox = imports.general.work:WaitForChild("shops"):WaitForChild("fusionHitbox")
imports.fusionEvents = imports.general.repEvents:WaitForChild("fusion")

return imports