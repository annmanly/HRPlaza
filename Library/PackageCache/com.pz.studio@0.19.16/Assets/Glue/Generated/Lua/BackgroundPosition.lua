--!AddComponentMenu("")

-- BackgroundPosition
type BackgroundPosition =
{
    keyword: BackgroundPositionKeyword,
    offset: Length,
    Equals: (other: BackgroundPosition) -> boolean,
}

-- BackgroundPositionType
type BackgroundPositionType =
{
    new: (keyword: BackgroundPositionKeyword) -> BackgroundPosition,
    new: (keyword: BackgroundPositionKeyword, offset: Length) -> BackgroundPosition,
    __eq: (style1: BackgroundPosition, style2: BackgroundPosition) -> boolean,
    __tostring: () -> string,
}

if not _G.BackgroundPosition then
    local BackgroundPositionType_instance : BackgroundPositionType = {}
    _G.BackgroundPosition = BackgroundPositionType_instance;
end
