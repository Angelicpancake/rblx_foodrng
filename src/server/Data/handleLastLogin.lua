local PlayerDataTypes = require(script.Parent.Parent.Types.playerDataTypes)

function CheckLastLogin(Profile: PlayerDataTypes.ProfileDataType)
    print(Profile.LastLogin)
    local Now = DateTime.now()
    local LastLogin = DateTime.fromUnixTimestampMillis(Profile.LastLogin)
    local NowUni = Now:ToUniversalTime()
    local LastLoginUni = LastLogin:ToUniversalTime()
    if NowUni.Day == LastLoginUni.Day then
        print("Same day")
    else
        print('New day')
    end
end

return CheckLastLogin