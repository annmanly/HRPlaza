--!AddComponentMenu("")

-- GeometryChangedEvent
type GeometryChangedEvent =
{
    eventTypeId: number,
    newRect: Rect,
    oldRect: Rect,
}

-- GeometryChangedEventType
type GeometryChangedEventType =
{
    GetPooled: (oldRect: Rect, newRect: Rect) -> GeometryChangedEvent,
    __tostring: () -> string,
}

if not _G.GeometryChangedEvent then
    local GeometryChangedEventType_instance : GeometryChangedEventType = {}
    _G.GeometryChangedEvent = GeometryChangedEventType_instance;
end
