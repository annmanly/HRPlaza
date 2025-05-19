--!AddComponentMenu("")

-- SwipeEvent
type SwipeEvent =
{
    velocity: number,
    eventTypeId: number,
}

-- SwipeEventType
type SwipeEventType =
{
    __tostring: () -> string,
}

if not _G.SwipeEvent then
    local SwipeEventType_instance : SwipeEventType = {}
    _G.SwipeEvent = SwipeEventType_instance;
end
