--!AddComponentMenu("")

-- StyleColor
type StyleColor =
{
    keyword: StyleKeyword,
    value: Color,
    Equals: (other: StyleColor) -> boolean,
}

-- StyleColorType
type StyleColorType =
{
    new: (v: Color) -> StyleColor,
    new: (keyword: StyleKeyword) -> StyleColor,
    __eq: (lhs: StyleColor, rhs: Color) -> boolean,
    __eq: (lhs: StyleColor, rhs: StyleColor) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleColor then
    local StyleColorType_instance : StyleColorType = {}
    _G.StyleColor = StyleColorType_instance;
end
