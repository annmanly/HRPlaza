--!AddComponentMenu("")

-- BackgroundSize
type BackgroundSize =
{
    sizeType: BackgroundSizeType,
    x: Length,
    y: Length,
    Equals: (other: BackgroundSize) -> boolean,
}

-- BackgroundSizeType
type BackgroundSizeType =
{
    new: (sizeType: BackgroundSizeType) -> BackgroundSize,
    new: (sizeX: Length, sizeY: Length) -> BackgroundSize,
    __eq: (style1: BackgroundSize, style2: BackgroundSize) -> boolean,
    __tostring: () -> string,
}

if not _G.BackgroundSize then
    local BackgroundSizeType_instance : BackgroundSizeType = {}
    _G.BackgroundSize = BackgroundSizeType_instance;
end
