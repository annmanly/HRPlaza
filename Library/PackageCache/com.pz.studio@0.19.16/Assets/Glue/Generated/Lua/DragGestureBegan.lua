--!AddComponentMenu("")

-- DragGestureBegan
type DragGestureBegan =
{
    deltaPosition: Vector2,
    position: Vector2,
    startPosition: Vector2,
    velocity: Vector2,
    eventTypeId: number,
    screenPosition: Vector2,
    screenStartPosition: Vector2,
}

-- DragGestureBeganType
type DragGestureBeganType =
{
    __tostring: () -> string,
}

if not _G.DragGestureBegan then
    local DragGestureBeganType_instance : DragGestureBeganType = {}
    _G.DragGestureBegan = DragGestureBeganType_instance;
end
