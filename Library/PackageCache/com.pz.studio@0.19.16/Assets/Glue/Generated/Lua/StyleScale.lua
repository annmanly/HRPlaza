--!AddComponentMenu("")

-- StyleScale
type StyleScale =
{
    keyword: StyleKeyword,
    value: Scale,
    Equals: (other: StyleScale) -> boolean,
}

-- StyleScaleType
type StyleScaleType =
{
    new: (v: Scale) -> StyleScale,
    new: (keyword: StyleKeyword) -> StyleScale,
    new: (scale: Vector2) -> StyleScale,
    __eq: (lhs: StyleScale, rhs: StyleScale) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleScale then
    local StyleScaleType_instance : StyleScaleType = {}
    _G.StyleScale = StyleScaleType_instance;
end
