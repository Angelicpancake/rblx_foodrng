local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events")
local RollingEvents = Events:WaitForChild("Rng")

local RollResultEvent: RemoteEvent = RollingEvents:WaitForChild("RollResultEvent")

local function RollingInitClient()   
    -- RollResultEvent.OnClientEvent:Connect(function(RollResult)
    --     print(RollResult)
    -- end)
end

return RollingInitClient