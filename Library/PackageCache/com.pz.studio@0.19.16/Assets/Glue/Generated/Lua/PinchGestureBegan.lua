--!AddComponentMenu("")

-- PinchGestureBegan
type PinchGestureBegan =
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

-- PinchGestureBeganType
type PinchGestureBeganType =
{
    __tostring: () -> string,
}

if not _G.PinchGestureBegan then
    local PinchGestureBeganType_instance : PinchGestureBeganType = {}
    _G.PinchGestureBegan = PinchGestureBeganType_instance;
end
