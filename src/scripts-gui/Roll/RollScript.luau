local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")

local function onClick()
	Events:WaitForChild("Rng"):WaitForChild("RollEvent"):FireServer() --fire to server
end

return onClick
