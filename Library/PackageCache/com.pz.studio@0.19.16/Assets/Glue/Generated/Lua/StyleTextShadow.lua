--!AddComponentMenu("")

-- StyleTextShadow
type StyleTextShadow =
{
    keyword: StyleKeyword,
    value: TextShadow,
    Equals: (other: StyleTextShadow) -> boolean,
}

-- StyleTextShadowType
type StyleTextShadowType =
{
    new: (keyword: StyleKeyword) -> StyleTextShadow,
    new: (v: TextShadow) -> StyleTextShadow,
    __eq: (lhs: StyleTextShadow, rhs: StyleTextShadow) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleTextShadow then
    local StyleTextShadowType_instance : StyleTextShadowType = {}
    _G.StyleTextShadow = StyleTextShadowType_instance;
end
