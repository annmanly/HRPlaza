--!AddComponentMenu("")

-- BackgroundSizeType
type BackgroundSizeType =
{
}

-- BackgroundSizeTypeType
type BackgroundSizeTypeType =
{
    Contain: BackgroundSizeType,
    Cover: BackgroundSizeType,
    Length: BackgroundSizeType,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.BackgroundSizeType then
    local BackgroundSizeTypeType_instance : BackgroundSizeTypeType = {}
    _G.BackgroundSizeType = BackgroundSizeTypeType_instance;
end
