--!AddComponentMenu("")

-- DoubleClickEvent
type DoubleClickEvent =
{
    eventTypeId: number,
}

-- DoubleClickEventType
type DoubleClickEventType =
{
    __tostring: () -> string,
}

if not _G.DoubleClickEvent then
    local DoubleClickEventType_instance : DoubleClickEventType = {}
    _G.DoubleClickEvent = DoubleClickEventType_instance;
end
