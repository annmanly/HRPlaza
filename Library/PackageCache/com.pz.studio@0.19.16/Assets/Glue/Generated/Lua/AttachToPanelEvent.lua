--!AddComponentMenu("")

-- AttachToPanelEvent
type AttachToPanelEvent =
{
    destinationPanel: IPanel,
    eventTypeId: number,
    originPanel: IPanel,
}

-- AttachToPanelEventType
type AttachToPanelEventType =
{
    __tostring: () -> string,
}

if not _G.AttachToPanelEvent then
    local AttachToPanelEventType_instance : AttachToPanelEventType = {}
    _G.AttachToPanelEvent = AttachToPanelEventType_instance;
end
