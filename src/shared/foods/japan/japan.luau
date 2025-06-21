local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ftemp = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("foods").foodTemplate)

local japan = {
	pancake = ftemp.new({ name = "pancake", image = 8 }),
}

return japan
