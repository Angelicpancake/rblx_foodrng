local RollingAnimation = require(script.Parent.RollingAnimation)

local function AnimationHandlerInit(RollResultEvent: RemoteEvent)
    RollingAnimation.RollingAnimationInit()

    RollResultEvent.OnClientEvent:Connect(function(RollResult)
        local AboveRarityThreshold = true

        print(RollResult)

        if AboveRarityThreshold then
            RollingAnimation.PlayRollingAnimation(RollResult)
        end
    end)
end

return AnimationHandlerInit