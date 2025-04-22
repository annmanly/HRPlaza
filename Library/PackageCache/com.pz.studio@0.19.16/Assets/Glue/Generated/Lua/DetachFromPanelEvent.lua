--!AddComponentMenu("")

-- DetachFromPanelEvent
type DetachFromPanelEvent =
{
    destinationPanel: IPanel,
    eventTypeId: number,
    originPanel: IPanel,
}

-- DetachFromPanelEventType
type DetachFromPanelEventType =
{
    __tostring: () -> string,
}

if not _G.DetachFromPanelEvent then
    local DetachFromPanelEventType_instance : DetachFromPanelEventType = {}
    _G.DetachFromPanelEvent = DetachFromPanelEventType_instance;
end
