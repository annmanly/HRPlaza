--!AddComponentMenu("")

-- SingleClickEvent
type SingleClickEvent =
{
    eventTypeId: number,
}

-- SingleClickEventType
type SingleClickEventType =
{
    __tostring: () -> string,
}

if not _G.SingleClickEvent then
    local SingleClickEventType_instance : SingleClickEventType = {}
    _G.SingleClickEvent = SingleClickEventType_instance;
end
