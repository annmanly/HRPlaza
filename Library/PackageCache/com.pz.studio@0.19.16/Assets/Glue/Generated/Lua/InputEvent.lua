--!AddComponentMenu("")

-- InputEvent
type InputEvent =
{
    eventTypeId: number,
    newData: string,
    previousData: string,
}

-- InputEventType
type InputEventType =
{
    GetPooled: (previousData: string, newData: string) -> InputEvent,
    __tostring: () -> string,
}

if not _G.InputEvent then
    local InputEventType_instance : InputEventType = {}
    _G.InputEvent = InputEventType_instance;
end
