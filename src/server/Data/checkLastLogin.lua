local ServerScriptService = game:GetService("ServerScriptService")
local PlayerDataTypes = require(script.Parent.Parent.Types.playerDataTypes)

function CheckLastLogin(Profile: PlayerDataTypes.ProfileDataType)
    print(Profile.LastLogin)
    local Now = DateTime.now()
    local LastLogin = DateTime.fromUnixTimestampMillis(Profile.LastLogin)

    local NowUni = Now:ToUniversalTime()
    local LastLoginUni = LastLogin:ToUniversalTime()

    -- set last login to today
    Profile.LastLogin = Now.UnixTimestampMillis

    if NowUni.Day == LastLoginUni.Day then
        print("Same day")
        return false
    else
        print('New day')
        return true
    end
end

return CheckLastLogin