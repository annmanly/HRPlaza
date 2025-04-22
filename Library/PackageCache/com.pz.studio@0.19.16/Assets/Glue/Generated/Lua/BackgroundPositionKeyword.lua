--!AddComponentMenu("")

-- BackgroundPositionKeyword
type BackgroundPositionKeyword =
{
}

-- BackgroundPositionKeywordType
type BackgroundPositionKeywordType =
{
    Bottom: BackgroundPositionKeyword,
    Center: BackgroundPositionKeyword,
    Left: BackgroundPositionKeyword,
    Right: BackgroundPositionKeyword,
    Top: BackgroundPositionKeyword,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.BackgroundPositionKeyword then
    local BackgroundPositionKeywordType_instance : BackgroundPositionKeywordType = {}
    _G.BackgroundPositionKeyword = BackgroundPositionKeywordType_instance;
end
