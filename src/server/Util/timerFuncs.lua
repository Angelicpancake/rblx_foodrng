--!strict
local ServerScriptService = game:GetService("ServerScriptService")
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local TimeEventDataTypes = require(Types.timedEventDataTypes)

--takes in userId or specific string
local TimedEvents: { [string]: TimeEventDataTypes.TimeEventDataType } = {}

local function UpdateTimer(Event: TimeEventDataTypes.TimeEventDataType, Key: string)
    table.insert(TimedEvents[Key], Event)
end

local function RunTimer()
    task.spawn(function()
    local TimeRunning = true
        while(TimeRunning) do
            local now = os.clock()
            for _, Event in TimedEvents do
                print(Event)
                --go to next event if event is not expired yet
                if Event.Time > now then
                    continue
                end

                if Event.Type == "Bonus" then

                end
            end

            task.wait(1)
        end
    end)
end

return {
    UpdateTimer = UpdateTimer,
    RunTimer = RunTimer
}