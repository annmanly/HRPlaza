--!AddComponentMenu("")

-- SpriteRenderer
type SpriteRenderer =
{
    adaptiveModeThreshold: number,
    color: Color,
    flipX: boolean,
    flipY: boolean,
    size: Vector2,
    sprite: Sprite,
    RegisterSpriteChangeCallback: (callback: (SpriteRenderer) -> ()) -> (),
    UnregisterSpriteChangeCallback: (callback: (SpriteRenderer) -> ()) -> (),
}

-- SpriteRendererType
type SpriteRendererType =
{
    __tostring: () -> string,
}

if not _G.SpriteRenderer then
    local SpriteRendererType_instance : SpriteRendererType = {}
    _G.SpriteRenderer = SpriteRendererType_instance;
end
