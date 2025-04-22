--!AddComponentMenu("")

-- TapEvent
type TapEvent =
{
    position: Vector2,
    startFrame: number,
    eventTypeId: number,
    screenPosition: Vector2,
    CloneInto: (clone: TapEvent) -> TapEvent,
}

-- TapEventType
type TapEventType =
{
    __tostring: () -> string,
}

if not _G.TapEvent then
    local TapEventType_instance : TapEventType = {}
    _G.TapEvent = TapEventType_instance;
end
