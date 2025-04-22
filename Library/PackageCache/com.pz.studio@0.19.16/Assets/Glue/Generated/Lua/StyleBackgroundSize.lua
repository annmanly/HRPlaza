--!AddComponentMenu("")

-- StyleBackgroundSize
type StyleBackgroundSize =
{
    keyword: StyleKeyword,
    value: BackgroundSize,
    Equals: (other: StyleBackgroundSize) -> boolean,
}

-- StyleBackgroundSizeType
type StyleBackgroundSizeType =
{
    new: (v: BackgroundSize) -> StyleBackgroundSize,
    new: (keyword: StyleKeyword) -> StyleBackgroundSize,
    __eq: (lhs: StyleBackgroundSize, rhs: StyleBackgroundSize) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleBackgroundSize then
    local StyleBackgroundSizeType_instance : StyleBackgroundSizeType = {}
    _G.StyleBackgroundSize = StyleBackgroundSizeType_instance;
end
