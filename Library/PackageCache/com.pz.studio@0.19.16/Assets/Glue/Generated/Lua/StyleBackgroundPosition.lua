--!AddComponentMenu("")

-- StyleBackgroundPosition
type StyleBackgroundPosition =
{
    keyword: StyleKeyword,
    value: BackgroundPosition,
    Equals: (other: StyleBackgroundPosition) -> boolean,
}

-- StyleBackgroundPositionType
type StyleBackgroundPositionType =
{
    new: (v: BackgroundPosition) -> StyleBackgroundPosition,
    new: (keyword: StyleKeyword) -> StyleBackgroundPosition,
    __eq: (lhs: StyleBackgroundPosition, rhs: StyleBackgroundPosition) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleBackgroundPosition then
    local StyleBackgroundPositionType_instance : StyleBackgroundPositionType = {}
    _G.StyleBackgroundPosition = StyleBackgroundPositionType_instance;
end
