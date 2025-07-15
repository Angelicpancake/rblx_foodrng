--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Types = ServerScriptService:WaitForChild("Server"):WaitForChild("Types")
local TimeEventDataTypes = require(Types.timedEventDataTypes)

local TimerClass = require(script.Parent.timerClass)

local t = require(ReplicatedStorage:WaitForChild("Packages").t)
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)

type TroveType = typeof(Trove.new())

--takes in userId or specific string as key
local ValidEventTypes = {
    "Bonus"
}

local FormattedValidEventTypes = {}
for _, Type in ValidEventTypes do
    table.insert(FormattedValidEventTypes, t.literal(Type))
end

local CheckForValidEventType = t.union(table.unpack(FormattedValidEventTypes))

local function AddTimer(TimerEvent: TimeEventDataTypes.TimeEventDataType)
    assert(CheckForValidEventType(TimerEvent.Type))
    local TimerTrove = Trove.new()

    local EventTimer = TimerClass.New()
    local connection = EventTimer.Finished:Connect(function()
        print(`timer {TimerEvent.Name} finished`)

        if TimerEvent.Callback then
            TimerEvent.Callback()
        end

        TimerTrove:Destroy()
    end)

    TimerTrove:Add(connection)
    TimerTrove:Add(function()
        EventTimer:Destroy()
    end)
    EventTimer:Start(TimerEvent.Time)
end

-- local function RunTimer()
--     task.spawn(function()
--     local TimeRunning = true
--         while(TimeRunning) do
--             local now = os.clock()
--             for Key, EventTable in pairs(TimedEvents) do
--                 print(EventTable)
--                 --go to next event if event is not expired yet
--                 for Index, Event in ipairs(EventTable) do
--                     if Event.Time > now then
--                         continue
--                     end

--                     if Event.Type == "Bonus" then

--                     end

--                     print("event ended")
--                     table.remove(EventTable, Index)
--                 end
--             end

--             task.wait(1)
--         end
--     end)
-- end

return {
    AddTimer = AddTimer,
    -- RunTimer = RunTimer
}