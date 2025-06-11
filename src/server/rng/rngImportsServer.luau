local ServerScriptService = game:GetService("ServerScriptService")

local imports = {}

local i = require(ServerScriptService.Server.importsServer)

imports.general = i
imports.rollEvent = imports.general.repEvents.rng.rollEvent

return imports