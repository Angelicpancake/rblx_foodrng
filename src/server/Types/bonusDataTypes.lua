local TimedEventDataTypes = require(script.Parent.timedEventDataTypes)

export type BonusDataType = {
    Name: string,
    Luck: number,
    --add more fields as needed
    Stackable: boolean,
    ExpiryEvent: TimedEventDataTypes.TimeEventDataType?
}

return {}