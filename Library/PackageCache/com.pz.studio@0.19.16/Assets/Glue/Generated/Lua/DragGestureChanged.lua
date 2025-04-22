--!AddComponentMenu("")

-- DragGestureChanged
type DragGestureChanged =
{
    deltaPosition: Vector2,
    position: Vector2,
    startPosition: Vector2,
    velocity: Vector2,
    eventTypeId: number,
    screenPosition: Vector2,
    screenStartPosition: Vector2,
}

-- DragGestureChangedType
type DragGestureChangedType =
{
    __tostring: () -> string,
}

if not _G.DragGestureChanged then
    local DragGestureChangedType_instance : DragGestureChangedType = {}
    _G.DragGestureChanged = DragGestureChangedType_instance;
end
