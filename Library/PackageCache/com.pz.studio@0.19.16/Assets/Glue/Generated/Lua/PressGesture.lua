--!AddComponentMenu("")

-- PressGesture
type PressGesture =
{
}

-- PressGestureType
type PressGestureType =
{
    __tostring: () -> string,
}

if not _G.PressGesture then
    local PressGestureType_instance : PressGestureType = {}
    _G.PressGesture = PressGestureType_instance;
end
