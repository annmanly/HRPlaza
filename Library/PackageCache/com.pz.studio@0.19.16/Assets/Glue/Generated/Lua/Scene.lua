--!AddComponentMenu("")

-- Scene
type Scene =
{
    PlayerJoined: LuaEvent,
    PlayerLeft: LuaEvent,
    id: number,
    mainCamera: Camera,
    name: string,
    playerCount: number,
    players: {Player},
    renderSettings: RenderSettings,
}

-- SceneType
type SceneType =
{
}

if not _G.Scene then
    local SceneType_instance : SceneType = {}
    _G.Scene = SceneType_instance;
end
