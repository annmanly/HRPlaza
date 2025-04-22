--!AddComponentMenu("")

-- TransitionStartEvent
type TransitionStartEvent =
{
    elapsedTime: number,
    eventTypeId: number,
}

-- TransitionStartEventType
type TransitionStartEventType =
{
    __tostring: () -> string,
}

if not _G.TransitionStartEvent then
    local TransitionStartEventType_instance : TransitionStartEventType = {}
    _G.TransitionStartEvent = TransitionStartEventType_instance;
end
