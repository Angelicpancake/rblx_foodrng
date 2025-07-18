--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Observers = require(ReplicatedStorage:WaitForChild("Packages").Observers)
local t = require(ReplicatedStorage:WaitForChild("Packages").t)
local Trove = require(ReplicatedStorage:WaitForChild("Packages").Trove)

local FusionGui = PlayerGui:WaitForChild("FusionGui")
local InventoryGui = PlayerGui:WaitForChild("InventoryGui")
local AllowedAncestors = { FusionGui, InventoryGui }
local FuseButton: ImageButton = FusionGui:WaitForChild("MainFrame"):WaitForChild("FuseButton")

local FuseButtonCallback: RemoteFunction =
	ReplicatedStorage:WaitForChild("Events"):WaitForChild("Fusion"):WaitForChild("FuseClickedFunc")

local function FusionSelectionInit()
	local FuseSelectTrove = Trove.new()
	local SelectedFoods: { string } = {}

	local LastClicked: ImageButton? = nil

	FuseSelectTrove:Add(function()
		table.clear(SelectedFoods)
		LastClicked = nil
	end)

	--observers.observeTag returns a function that cleanups observing when called
	--initalizes observers for buttons labeled fusionItem
	--should be revamped for new ui
	local StopFuseObserving = Observers.observeTag("fusionItem", function(foodItem: ImageButton)
		local OnFusionItemClick: () -> nil = nil
		--case if imagebutton is in the recipe menu
		if foodItem:GetAttribute("fusionType") == "recipeMenu" then
			OnFusionItemClick = function()
				table.clear(SelectedFoods)

				local ParentFrame = assert(foodItem:FindFirstAncestorOfClass("Frame"), "Could not find Parent Frame")
				print(ParentFrame.Name)

				local Food1 = assert(
					ParentFrame:FindFirstChild("Food1"),
					"Food1 attribute access failed"
				)

				local Food2 = assert(
					ParentFrame:FindFirstChild("Food2"),
					"Food2 attribute access failed"
				)

				local Food1Name = assert( Food1:GetAttribute("Name"), "Could not get name attribute from food1") :: string
				local Food2Name = assert( Food2:GetAttribute("Name"), "Could not get name attribute from food2") :: string
				SelectedFoods = { Food1Name , Food2Name }
			end
		--case if image button is in inventory
		elseif foodItem:GetAttribute("fusionType") == "Inventory" then
			OnFusionItemClick = function()
				local Food = assert(foodItem.Parent, "could not retrieve foodItem parent")
				local value = Food.Name
				assert(t.string(value), "invalid foodname type")

				local foodIndex = table.find(SelectedFoods, value)

				if foodIndex then
					print("food already selected, removing food")
					table.remove(SelectedFoods, foodIndex)
					return
				elseif #SelectedFoods >= 2 then
					print("already max foods")
					return
				end

				table.insert(SelectedFoods, value)
			end
		else
			return
		end

		local connection = foodItem.MouseButton1Click:Connect(function()
			task.spawn(function()
				OnFusionItemClick()
				if LastClicked then
					LastClicked.BackgroundTransparency = 1
				end
				foodItem.BackgroundTransparency = 0.7
				LastClicked = foodItem
			end)
		end)

		return function()
			connection:Disconnect()
			print("connection disconnected")
		end
	end, AllowedAncestors)
	FuseSelectTrove:Add(StopFuseObserving)

	--send fusion items to backend
	local FuseButtonConnection = FuseButton.MouseButton1Click:Connect(function()
		task.spawn(function()
			local result = FuseButtonCallback:InvokeServer(SelectedFoods)
			print(SelectedFoods, "=>", result)

			if LastClicked then
				LastClicked.BackgroundTransparency = 1
				LastClicked = nil
			end

			table.clear(SelectedFoods)
		end)
	end)
	FuseSelectTrove:Add(FuseButtonConnection)
	return FuseSelectTrove
end

return FusionSelectionInit
