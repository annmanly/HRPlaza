--!AddComponentMenu("")

-- Texture
type Texture =
{
    isDataSRGB: boolean,
    isReadable: boolean,
    mipmapCount: number,
    texelSize: Vector2,
    updateCount: number,
    anisoLevel: number,
    height: number,
    mipMapBias: number,
    width: number,
    IncrementUpdateCount: () -> (),
}

-- TextureType
type TextureType =
{
    __tostring: () -> string,
}

if not _G.Texture then
    local TextureType_instance : TextureType = {}
    _G.Texture = TextureType_instance;
end
