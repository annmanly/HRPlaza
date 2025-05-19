--!AddComponentMenu("")

-- DragGestureEnded
type DragGestureEnded =
{
    deltaPosition: Vector2,
    position: Vector2,
    startPosition: Vector2,
    velocity: Vector2,
    eventTypeId: number,
    screenPosition: Vector2,
    screenStartPosition: Vector2,
    cancelled: boolean,
}

-- DragGestureEndedType
type DragGestureEndedType =
{
    __tostring: () -> string,
}

if not _G.DragGestureEnded then
    local DragGestureEndedType_instance : DragGestureEndedType = {}
    _G.DragGestureEnded = DragGestureEndedType_instance;
end
