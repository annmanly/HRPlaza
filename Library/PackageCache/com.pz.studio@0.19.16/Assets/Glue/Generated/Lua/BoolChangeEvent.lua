--!AddComponentMenu("")

-- BoolChangeEvent
type BoolChangeEvent =
{
    eventTypeId: number,
    newValue: boolean,
    previousValue: boolean,
}

-- BoolChangeEventType
type BoolChangeEventType =
{
    __tostring: () -> string,
}

if not _G.BoolChangeEvent then
    local BoolChangeEventType_instance : BoolChangeEventType = {}
    _G.BoolChangeEvent = BoolChangeEventType_instance;
end
