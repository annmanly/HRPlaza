--!AddComponentMenu("")

-- SwipeFromEdgeEnded
type SwipeFromEdgeEnded =
{
    dragDistance: number,
    velocity: number,
    eventTypeId: number,
}

-- SwipeFromEdgeEndedType
type SwipeFromEdgeEndedType =
{
    __tostring: () -> string,
}

if not _G.SwipeFromEdgeEnded then
    local SwipeFromEdgeEndedType_instance : SwipeFromEdgeEndedType = {}
    _G.SwipeFromEdgeEnded = SwipeFromEdgeEndedType_instance;
end
