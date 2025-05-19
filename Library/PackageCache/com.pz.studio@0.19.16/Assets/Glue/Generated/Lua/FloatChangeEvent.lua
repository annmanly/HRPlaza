--!AddComponentMenu("")

-- FloatChangeEvent
type FloatChangeEvent =
{
    eventTypeId: number,
    newValue: number,
    previousValue: number,
    Dispose: () -> (),
}

-- FloatChangeEventType
type FloatChangeEventType =
{
    __tostring: () -> string,
}

if not _G.FloatChangeEvent then
    local FloatChangeEventType_instance : FloatChangeEventType = {}
    _G.FloatChangeEvent = FloatChangeEventType_instance;
end
