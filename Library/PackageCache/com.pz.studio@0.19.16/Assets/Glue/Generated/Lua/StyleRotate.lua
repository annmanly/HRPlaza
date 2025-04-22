--!AddComponentMenu("")

-- StyleRotate
type StyleRotate =
{
    keyword: StyleKeyword,
    value: Rotate,
    Equals: (other: StyleRotate) -> boolean,
}

-- StyleRotateType
type StyleRotateType =
{
    new: (v: Rotate) -> StyleRotate,
    new: (keyword: StyleKeyword) -> StyleRotate,
    __eq: (lhs: StyleRotate, rhs: StyleRotate) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleRotate then
    local StyleRotateType_instance : StyleRotateType = {}
    _G.StyleRotate = StyleRotateType_instance;
end
