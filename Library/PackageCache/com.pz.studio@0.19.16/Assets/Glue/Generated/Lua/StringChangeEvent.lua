--!AddComponentMenu("")

-- StringChangeEvent
type StringChangeEvent =
{
    eventTypeId: number,
    newValue: string,
    previousValue: string,
}

-- StringChangeEventType
type StringChangeEventType =
{
    __tostring: () -> string,
}

if not _G.StringChangeEvent then
    local StringChangeEventType_instance : StringChangeEventType = {}
    _G.StringChangeEvent = StringChangeEventType_instance;
end
