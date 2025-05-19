--!AddComponentMenu("")

-- StyleInt
type StyleInt =
{
    keyword: StyleKeyword,
    value: number,
    Equals: (other: StyleInt) -> boolean,
}

-- StyleIntType
type StyleIntType =
{
    new: (keyword: StyleKeyword) -> StyleInt,
    new: (v: number) -> StyleInt,
    __eq: (lhs: StyleInt, rhs: StyleInt) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleInt then
    local StyleIntType_instance : StyleIntType = {}
    _G.StyleInt = StyleIntType_instance;
end
