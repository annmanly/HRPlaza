--!AddComponentMenu("")

-- PressEvent
type PressEvent =
{
    position: Vector2,
    eventTypeId: number,
    screenPosition: Vector2,
}

-- PressEventType
type PressEventType =
{
    __tostring: () -> string,
}

if not _G.PressEvent then
    local PressEventType_instance : PressEventType = {}
    _G.PressEvent = PressEventType_instance;
end
