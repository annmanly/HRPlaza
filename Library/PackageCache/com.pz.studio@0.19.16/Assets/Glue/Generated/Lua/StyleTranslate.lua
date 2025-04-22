--!AddComponentMenu("")

-- StyleTranslate
type StyleTranslate =
{
    keyword: StyleKeyword,
    value: Translate,
    Equals: (other: StyleTranslate) -> boolean,
}

-- StyleTranslateType
type StyleTranslateType =
{
    new: (keyword: StyleKeyword) -> StyleTranslate,
    new: (v: Translate) -> StyleTranslate,
    __eq: (lhs: StyleTranslate, rhs: StyleTranslate) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleTranslate then
    local StyleTranslateType_instance : StyleTranslateType = {}
    _G.StyleTranslate = StyleTranslateType_instance;
end
