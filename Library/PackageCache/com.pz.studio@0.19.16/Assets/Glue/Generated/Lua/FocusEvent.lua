--!AddComponentMenu("")

-- FocusEvent
type FocusEvent =
{
    eventTypeId: number,
    relatedTarget: Focusable,
}

-- FocusEventType
type FocusEventType =
{
    __tostring: () -> string,
}

if not _G.FocusEvent then
    local FocusEventType_instance : FocusEventType = {}
    _G.FocusEvent = FocusEventType_instance;
end
