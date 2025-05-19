--!AddComponentMenu("")

-- TransitionEndEvent
type TransitionEndEvent =
{
    elapsedTime: number,
    eventTypeId: number,
}

-- TransitionEndEventType
type TransitionEndEventType =
{
    __tostring: () -> string,
}

if not _G.TransitionEndEvent then
    local TransitionEndEventType_instance : TransitionEndEventType = {}
    _G.TransitionEndEvent = TransitionEndEventType_instance;
end
