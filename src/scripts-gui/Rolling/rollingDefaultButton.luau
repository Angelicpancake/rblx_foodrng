local function RollDefaultButtonInit(RollButton, RollEvent)
    RollButton.MouseButton1Click:Connect(function()
        --print("rollButton client => clicked")
        RollEvent:FireServer() --fire to server
    end)
end

return RollDefaultButtonInit