local ReplicatedStorage = game:GetService("ReplicatedStorage")
local readonly = require(ReplicatedStorage:WaitForChild("Shared").readonly)

local food = {
    name = "", 
    image = nil,
}

food.__index = food

function food.new(params)
  local copy = setmetatable(params or {}, food)
  return readonly(copy)
end

return food