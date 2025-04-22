--!AddComponentMenu("")

-- LongPressGesture
type LongPressGesture =
{
}

-- LongPressGestureType
type LongPressGestureType =
{
    defaultCancelThreshold: number,
    defaultDurationThreshold: number,
    __tostring: () -> string,
}

if not _G.LongPressGesture then
    local LongPressGestureType_instance : LongPressGestureType = {}
    _G.LongPressGesture = LongPressGestureType_instance;
end
