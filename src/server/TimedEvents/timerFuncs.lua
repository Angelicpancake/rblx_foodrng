--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local TimeEventDataTypes = require(Types.timedEventDataTypes)

--takes in userId or specific string
local TimedEvents: { [string]: {TimeEventDataTypes.TimeEventDataType} } = {}

local t = require(ReplicatedStorage:WaitForChild("Packages").t)

local ValidEventTypes = {
    "Bonus"
}

local CheckForValidEventType = t.union(table.unpack((function()
    local ValidTypes = {}
    for _, Type in ValidEventTypes do
        table.insert(ValidTypes, t.literal(Type))
    end
    return ValidTypes
end)()))

local function AddEvent(Event: TimeEventDataTypes.TimeEventDataType, Key: string)
    assert(CheckForValidEventType(Event.Type))
    if not TimedEvents[Key] then
        TimedEvents[Key] = {}
    end
    table.insert(TimedEvents[Key], Event)
end

local function RunTimer()
    task.spawn(function()
    local TimeRunning = true
        while(TimeRunning) do
            local now = os.clock()
            for Key, EventTable in pairs(TimedEvents) do
                print(EventTable)
                --go to next event if event is not expired yet
                for Index, Event in ipairs(EventTable) do
                    if Event.Time > now then
                        continue
                    end

                    if Event.Type == "Bonus" then

                    end

                    print("event ended")
                    table.remove(EventTable, Index)
                end
            end

            task.wait(1)
        end
    end)
end

return {
    AddEvent = AddEvent,
    RunTimer = RunTimer
}