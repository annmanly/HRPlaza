--!AddComponentMenu("")

-- TransitionRunEvent
type TransitionRunEvent =
{
    elapsedTime: number,
    eventTypeId: number,
}

-- TransitionRunEventType
type TransitionRunEventType =
{
    __tostring: () -> string,
}

if not _G.TransitionRunEvent then
    local TransitionRunEventType_instance : TransitionRunEventType = {}
    _G.TransitionRunEvent = TransitionRunEventType_instance;
end
