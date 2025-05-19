--!AddComponentMenu("")

-- StyleLength
type StyleLength =
{
    keyword: StyleKeyword,
    value: Length,
    Equals: (other: StyleLength) -> boolean,
}

-- StyleLengthType
type StyleLengthType =
{
    new: (v: Length) -> StyleLength,
    new: (keyword: StyleKeyword) -> StyleLength,
    new: (v: number) -> StyleLength,
    __eq: (lhs: StyleLength, rhs: StyleLength) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleLength then
    local StyleLengthType_instance : StyleLengthType = {}
    _G.StyleLength = StyleLengthType_instance;
end
