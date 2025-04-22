--!AddComponentMenu("")

-- SwipeFromEdgeChanged
type SwipeFromEdgeChanged =
{
    dragDistance: number,
    eventTypeId: number,
}

-- SwipeFromEdgeChangedType
type SwipeFromEdgeChangedType =
{
    __tostring: () -> string,
}

if not _G.SwipeFromEdgeChanged then
    local SwipeFromEdgeChangedType_instance : SwipeFromEdgeChangedType = {}
    _G.SwipeFromEdgeChanged = SwipeFromEdgeChangedType_instance;
end
