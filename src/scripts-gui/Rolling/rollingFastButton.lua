function FastButtonInit(Button: ImageButton, SettingChangeEvent: RemoteEvent)
    Button.MouseButton1Click:Connect(function()
        SettingChangeEvent:FireServer("FastRoll")
    end)
end

return FastButtonInit