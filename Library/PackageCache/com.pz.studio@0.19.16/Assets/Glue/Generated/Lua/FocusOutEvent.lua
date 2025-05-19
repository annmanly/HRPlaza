--!AddComponentMenu("")

-- FocusOutEvent
type FocusOutEvent =
{
    eventTypeId: number,
    relatedTarget: Focusable,
}

-- FocusOutEventType
type FocusOutEventType =
{
    __tostring: () -> string,
}

if not _G.FocusOutEvent then
    local FocusOutEventType_instance : FocusOutEventType = {}
    _G.FocusOutEvent = FocusOutEventType_instance;
end
