--!AddComponentMenu("")

-- LongPressBeganEvent
type LongPressBeganEvent =
{
    position: Vector2,
    startTime: number,
    successDuration: number,
    eventTypeId: number,
    screenPosition: Vector2,
    CloneInto: (clone: LongPressBeganEvent) -> LongPressBeganEvent,
}

-- LongPressBeganEventType
type LongPressBeganEventType =
{
    __tostring: () -> string,
}

if not _G.LongPressBeganEvent then
    local LongPressBeganEventType_instance : LongPressBeganEventType = {}
    _G.LongPressBeganEvent = LongPressBeganEventType_instance;
end
