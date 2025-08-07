local LastClicked = 0
local CurrentTime
local cooldownBool = false

local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")

local zones = {
	["Japan"] = workspace:WaitForChild("Zones"):WaitForChild("Japan"),
}

local withinArea = require(replicatedStorage.Shared.Util.withinArea)

local function cooldown(RollButton)
	local remainTime = 5
	while remainTime > 0 do
		RollButton.Text = `Cooldown: {remainTime}s`
		task.wait(1)
		remainTime -= 1
	end

	RollButton.Text = "Roll"
	--[[
		task.wait(1)
		print(CurrentTime - LastClicked)]]
	--[[	task.spawn(function()
			local remainTime = math.ceil(4 - (CurrentTime - LastClicked))
			while remainTime > 0 do
				print(remainTime)
				RollButton.Text = `Cooldown: {remainTime}s`
				task.wait(1)
				remainTime = math.ceil(4 - (os.clock() - LastClicked))
			end
			RollButton.Text = "Roll"
		end)]]
end

local function RollDefaultButtonInit(RollButton, RollEvent)
	local zone = "none"

	RollButton.MouseButton1Click:Connect(function()
		print(cooldownBool)
		--CurrentTime = os.clock()
		--print("rollButton client => clicked")
		if not cooldownBool then--[[CurrentTime - LastClicked > 4]]
			if withinArea(zones["Japan"], zones["Japan"].Size.X / 2) then
				zone = "Japan"
			end
			RollEvent:FireServer(zone) --fire to server
			cooldownBool = true

			cooldown(RollButton)
			cooldownBool = false
			--LastClicked = CurrentTime
		end
	end)
end

return RollDefaultButtonInit
