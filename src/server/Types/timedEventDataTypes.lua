export type TimeEventDataType = {
    --union more strings as needed for timer type
    Type: "Bonus",
    Name: string,
    Time: number,
    Callback: ((any?) -> any?)?
}

return {}