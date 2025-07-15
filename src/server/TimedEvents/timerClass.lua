local Timer = {}
Timer.__index = Timer

export type TimerType = typeof(setmetatable({}, Timer))

function Timer.New()
	local self = setmetatable({}, Timer)

	self._finishedEvent = Instance.new("BindableEvent")
	self.Finished = self._finishedEvent.Event

	self._running = false
	self._startTime = nil
	self._duration = nil

	return self
end

function Timer:Start(duration: number)
	if not self._running then
		task.spawn(function()
			self._running = true
			self._duration = duration
			self._startTime = tick()
			while self._running and tick() - self._startTime < duration do
				task.wait()
			end
			local completed = self._running
			self._running = false
			self._startTime = nil
			self._duration = nil
			self._finishedEvent:Fire(completed)
		end)
	else
		warn("Warning: timer could not start again as it is already running.")
	end
end

function Timer:GetTimeLeft()
	if self._running then
		local now = tick()
		local timeLeft = self._startTime + self._duration - now
		if timeLeft < 0 then
			timeLeft = 0
		end
		return timeLeft
	else
		warn("Warning: could not get remaining time, timer is not running.")
        return nil
	end
end

function Timer:IsRunning()
	return self._running
end

function Timer:Stop()
	self._running = false
end

function Timer:Destroy()
	if self._finishedEvent then
		self._finishedEvent:Destroy()
		self._finishedEvent = nil
	end

	self.Finished = nil
	self._running = nil
	self._startTime = nil
	self._duration = nil

	setmetatable(self, nil)
end

return Timer