--!AddComponentMenu("")

-- Sprite
type Sprite =
{
    associatedAlphaSplitTexture: Texture2D,
    border: Vector4,
    bounds: Bounds,
    packed: boolean,
    pivot: Vector2,
    pixelsPerUnit: number,
    rect: Rect,
    spriteAtlasTextureScale: number,
    texture: Texture2D,
    textureRect: Rect,
    textureRectOffset: Vector2,
    triangles: {number},
    uv: {Vector2},
    vertices: {Vector2},
    GetPhysicsShapeCount: () -> number,
    GetPhysicsShapePointCount: (shapeIdx: number) -> number,
    GetSecondaryTextureCount: () -> number,
}

-- SpriteType
type SpriteType =
{
    Create: (texture: Texture2D, rect: Rect, pivot: Vector2) -> Sprite,
    Create: (texture: Texture2D, rect: Rect, pivot: Vector2, pixelsPerUnit: number) -> Sprite,
    Create: (texture: Texture2D, rect: Rect, pivot: Vector2, pixelsPerUnit: number, extrude: number) -> Sprite,
    __tostring: () -> string,
}

if not _G.Sprite then
    local SpriteType_instance : SpriteType = {}
    _G.Sprite = SpriteType_instance;
end
