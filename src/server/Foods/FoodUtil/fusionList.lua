local Japan = require(script.Parent:WaitForChild("Fusions").japanFusions)
local China = require(script.Parent:WaitForChild("Fusions").chineseFusions)
local France = require(script.Parent:WaitForChild("Fusions").frenchFusions)
local Italy = require(script.Parent:WaitForChild("Fusions").italianFusions)
local Korea = require(script.Parent:WaitForChild("Fusions").koreanFusions)
local America = require(script.Parent:WaitForChild("Fusions").americanFusions)

local fusions = {}

local function add(tab)
	for key, value in pairs(tab) do
		fusions[key] = value
	end
end

add(Japan)
add(China)
add(France)
add(Italy)
add(Korea)
add(America)

return fusions
