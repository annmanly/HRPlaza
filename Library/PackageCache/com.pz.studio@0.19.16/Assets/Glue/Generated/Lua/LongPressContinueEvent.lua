--!AddComponentMenu("")

-- LongPressContinueEvent
type LongPressContinueEvent =
{
    position: Vector2,
    progress: number,
    startTime: number,
    eventTypeId: number,
    screenPosition: Vector2,
    CloneInto: (clone: LongPressContinueEvent) -> LongPressContinueEvent,
}

-- LongPressContinueEventType
type LongPressContinueEventType =
{
    __tostring: () -> string,
}

if not _G.LongPressContinueEvent then
    local LongPressContinueEventType_instance : LongPressContinueEventType = {}
    _G.LongPressContinueEvent = LongPressContinueEventType_instance;
end
