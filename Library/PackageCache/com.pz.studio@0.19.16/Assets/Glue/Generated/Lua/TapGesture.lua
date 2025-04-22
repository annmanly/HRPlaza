--!AddComponentMenu("")

-- TapGesture
type TapGesture =
{
}

-- TapGestureType
type TapGestureType =
{
    cancelThreshold: number,
    durationThreshold: number,
    __tostring: () -> string,
}

if not _G.TapGesture then
    local TapGestureType_instance : TapGestureType = {}
    _G.TapGesture = TapGestureType_instance;
end
