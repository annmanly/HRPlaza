--!AddComponentMenu("")

-- StyleFloat
type StyleFloat =
{
    keyword: StyleKeyword,
    value: number,
    Equals: (other: StyleFloat) -> boolean,
}

-- StyleFloatType
type StyleFloatType =
{
    new: (keyword: StyleKeyword) -> StyleFloat,
    new: (v: number) -> StyleFloat,
    __eq: (lhs: StyleFloat, rhs: StyleFloat) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleFloat then
    local StyleFloatType_instance : StyleFloatType = {}
    _G.StyleFloat = StyleFloatType_instance;
end
