--!AddComponentMenu("")

-- SwipeFromEdgeBegan
type SwipeFromEdgeBegan =
{
    dragDistance: number,
    eventTypeId: number,
}

-- SwipeFromEdgeBeganType
type SwipeFromEdgeBeganType =
{
    __tostring: () -> string,
}

if not _G.SwipeFromEdgeBegan then
    local SwipeFromEdgeBeganType_instance : SwipeFromEdgeBeganType = {}
    _G.SwipeFromEdgeBegan = SwipeFromEdgeBeganType_instance;
end
