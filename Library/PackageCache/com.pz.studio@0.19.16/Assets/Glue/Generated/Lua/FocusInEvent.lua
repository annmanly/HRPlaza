--!AddComponentMenu("")

-- FocusInEvent
type FocusInEvent =
{
    eventTypeId: number,
    relatedTarget: Focusable,
}

-- FocusInEventType
type FocusInEventType =
{
    __tostring: () -> string,
}

if not _G.FocusInEvent then
    local FocusInEventType_instance : FocusInEventType = {}
    _G.FocusInEvent = FocusInEventType_instance;
end
