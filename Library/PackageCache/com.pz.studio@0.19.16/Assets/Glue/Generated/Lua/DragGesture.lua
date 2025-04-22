--!AddComponentMenu("")

-- DragGesture
type DragGesture =
{
    Custom: (directionLimit: Vector2 , isBidirectional: boolean , directionRecognitionDegs: number) -> DragGesture,
    HasReachedDuration: (duration: number) -> boolean,
    HasReachedMinDistance: (position: Vector2) -> boolean,
    Horizontal: () -> DragGesture,
    Vertical: () -> DragGesture,
}

-- DragGestureType
type DragGestureType =
{
    new: (helper: IDragGestureHelper, minDistance: number?) -> DragGesture,
    new: (minDistance: number?) -> DragGesture,
    __tostring: () -> string,
}

if not _G.DragGesture then
    local DragGestureType_instance : DragGestureType = {}
    _G.DragGesture = DragGestureType_instance;
end
