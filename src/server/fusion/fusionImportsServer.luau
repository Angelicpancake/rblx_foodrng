local ServerScriptService = game:GetService("ServerScriptService")

local imports = {}

local i = require(ServerScriptService:WaitForChild("Server").importsServer)

imports.general = i
imports.fusionEvents = imports.general.repEvents:WaitForChild("fusion")

return imports