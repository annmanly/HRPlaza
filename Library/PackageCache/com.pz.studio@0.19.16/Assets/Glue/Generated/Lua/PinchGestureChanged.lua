--!AddComponentMenu("")

-- PinchGestureChanged
type PinchGestureChanged =
{
    deltaPosition: Vector2,
    direction: Vector2,
    distance: number,
    isPinching: boolean,
    position: Vector2,
    scale: number,
    startPosition: Vector2,
    eventTypeId: number,
    screenPosition: Vector2,
    screenStartPosition: Vector2,
}

-- PinchGestureChangedType
type PinchGestureChangedType =
{
    __tostring: () -> string,
}

if not _G.PinchGestureChanged then
    local PinchGestureChangedType_instance : PinchGestureChangedType = {}
    _G.PinchGestureChanged = PinchGestureChangedType_instance;
end
