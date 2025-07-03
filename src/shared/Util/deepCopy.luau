-- local ReplicatedStorage = game:GetService("ReplicatedStorage")
--[[local t = require(ReplicatedStorage:WaitForChild("Packages").t)

local tableCheck = t.typeof("table")]]
local function deepCopy(template)
	local copy = {}
	for k, v in pairs(template) do
		if type(v) == "table" then
			copy[k] = deepCopy(v)
		else
			copy[k] = v
		end
	end
	return copy
end

return deepCopy
