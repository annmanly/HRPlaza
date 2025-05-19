--!AddComponentMenu("")

-- BlurEvent
type BlurEvent =
{
    eventTypeId: number,
    relatedTarget: Focusable,
}

-- BlurEventType
type BlurEventType =
{
    __tostring: () -> string,
}

if not _G.BlurEvent then
    local BlurEventType_instance : BlurEventType = {}
    _G.BlurEvent = BlurEventType_instance;
end
