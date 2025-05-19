--!AddComponentMenu("")

-- Image
type Image =
{
    image: Texture,
    sourceRect: Rect,
    sprite: Sprite,
    tintColor: Color,
    uv: Rect,
}

-- ImageType
type ImageType =
{
    ussClassName: string,
    new: () -> Image,
    __tostring: () -> string,
}

if not _G.Image then
    local ImageType_instance : ImageType = {}
    _G.Image = ImageType_instance;
end
