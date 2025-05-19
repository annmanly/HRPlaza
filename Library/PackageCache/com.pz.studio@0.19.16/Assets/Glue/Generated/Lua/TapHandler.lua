--!AddComponentMenu("")

-- TapHandler
type TapHandler =
{
    Tapped: LuaEvent,
    hasAnchors: boolean,
    moveTarget: Vector3,
    distance: number,
    moveTo: boolean,
    GetClosestAnchor: (position: Vector3) -> Anchor,
    Perform: (position: Vector3) -> (),
}

-- TapHandlerType
type TapHandlerType =
{
    __tostring: () -> string,
}

if not _G.TapHandler then
    local TapHandlerType_instance : TapHandlerType = {}
    _G.TapHandler = TapHandlerType_instance;
end
