--!AddComponentMenu("")

-- SwipeFromEdgeCanceled
type SwipeFromEdgeCanceled =
{
    dragDistance: number,
    velocity: number,
    eventTypeId: number,
}

-- SwipeFromEdgeCanceledType
type SwipeFromEdgeCanceledType =
{
    __tostring: () -> string,
}

if not _G.SwipeFromEdgeCanceled then
    local SwipeFromEdgeCanceledType_instance : SwipeFromEdgeCanceledType = {}
    _G.SwipeFromEdgeCanceled = SwipeFromEdgeCanceledType_instance;
end
