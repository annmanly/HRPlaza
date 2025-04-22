--!AddComponentMenu("")

-- IntChangeEvent
type IntChangeEvent =
{
    eventTypeId: number,
    newValue: number,
    previousValue: number,
    Dispose: () -> (),
}

-- IntChangeEventType
type IntChangeEventType =
{
    __tostring: () -> string,
}

if not _G.IntChangeEvent then
    local IntChangeEventType_instance : IntChangeEventType = {}
    _G.IntChangeEvent = IntChangeEventType_instance;
end
