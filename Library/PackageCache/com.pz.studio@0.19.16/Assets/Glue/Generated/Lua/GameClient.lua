--!AddComponentMenu("")

-- GameClient
type GameClient =
{
    FocusGained: LuaEvent,
    FocusLost: LuaEvent,
    Reset: LuaEvent,
    isoRoomContext: WorldRoomContext,
    mainCamera: Camera,
    worldBounds: Bounds,
}

-- GameClientType
type GameClientType =
{
}

if not _G.GameClient then
    local GameClientType_instance : GameClientType = {}
    _G.GameClient = GameClientType_instance;
end
