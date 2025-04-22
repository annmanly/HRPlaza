--!AddComponentMenu("")

-- LongPressEndedEvent
type LongPressEndedEvent =
{
    cancelled: boolean,
    position: Vector2,
    progress: number,
    eventTypeId: number,
    screenPosition: Vector2,
    CloneInto: (clone: LongPressEndedEvent) -> LongPressEndedEvent,
}

-- LongPressEndedEventType
type LongPressEndedEventType =
{
    __tostring: () -> string,
}

if not _G.LongPressEndedEvent then
    local LongPressEndedEventType_instance : LongPressEndedEventType = {}
    _G.LongPressEndedEvent = LongPressEndedEventType_instance;
end
