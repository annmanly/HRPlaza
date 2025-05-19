--!AddComponentMenu("")

-- WorldRoomContext
type WorldRoomContext =
{
    Raycast: (ray: Ray , layerMask: number) -> (boolean , RaycastHit),
}

-- WorldRoomContextType
type WorldRoomContextType =
{
}

if not _G.WorldRoomContext then
    local WorldRoomContextType_instance : WorldRoomContextType = {}
    _G.WorldRoomContext = WorldRoomContextType_instance;
end
