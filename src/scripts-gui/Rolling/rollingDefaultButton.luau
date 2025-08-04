local LastClicked = 0
local CurrentTime
local cooldownBool = false

local function cooldown(RollButton)
	local remainTime = 5
	while remainTime > 0 do
		print(remainTime)
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
	RollButton.MouseButton1Click:Connect(function()
		print(cooldownBool)
		--CurrentTime = os.clock()
		--print("rollButton client => clicked")
		if not cooldownBool then--[[CurrentTime - LastClicked > 4]]
			RollEvent:FireServer() --fire to server
			cooldownBool = true

			cooldown(RollButton)
			cooldownBool = false
			--LastClicked = CurrentTime
		end
	end)
end

return RollDefaultButtonInit
