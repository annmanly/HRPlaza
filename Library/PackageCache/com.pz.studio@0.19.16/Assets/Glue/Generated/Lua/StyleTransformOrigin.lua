--!AddComponentMenu("")

-- StyleTransformOrigin
type StyleTransformOrigin =
{
    keyword: StyleKeyword,
    value: TransformOrigin,
    Equals: (other: StyleTransformOrigin) -> boolean,
}

-- StyleTransformOriginType
type StyleTransformOriginType =
{
    new: (keyword: StyleKeyword) -> StyleTransformOrigin,
    new: (v: TransformOrigin) -> StyleTransformOrigin,
    __eq: (lhs: StyleTransformOrigin, rhs: StyleTransformOrigin) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleTransformOrigin then
    local StyleTransformOriginType_instance : StyleTransformOriginType = {}
    _G.StyleTransformOrigin = StyleTransformOriginType_instance;
end
