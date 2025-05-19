--!AddComponentMenu("")

-- PinchGestureEnded
type PinchGestureEnded =
{
    deltaPosition: Vector2,
    distance: number,
    position: Vector2,
    scale: number,
    startPosition: Vector2,
    velocity: Vector2,
    eventTypeId: number,
    screenPosition: Vector2,
    screenStartPosition: Vector2,
}

-- PinchGestureEndedType
type PinchGestureEndedType =
{
    __tostring: () -> string,
}

if not _G.PinchGestureEnded then
    local PinchGestureEndedType_instance : PinchGestureEndedType = {}
    _G.PinchGestureEnded = PinchGestureEndedType_instance;
end
