--!AddComponentMenu("")

-- TransitionCancelEvent
type TransitionCancelEvent =
{
    elapsedTime: number,
    eventTypeId: number,
}

-- TransitionCancelEventType
type TransitionCancelEventType =
{
    __tostring: () -> string,
}

if not _G.TransitionCancelEvent then
    local TransitionCancelEventType_instance : TransitionCancelEventType = {}
    _G.TransitionCancelEvent = TransitionCancelEventType_instance;
end
