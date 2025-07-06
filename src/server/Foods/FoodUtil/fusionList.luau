local japan = require(script.Parent:WaitForChild("Fusions").japanFusions)

local fusions = {}

local function add(tab)
	for key, value in pairs(tab) do
		fusions[key] = value
	end
end

add(japan)

return fusions
