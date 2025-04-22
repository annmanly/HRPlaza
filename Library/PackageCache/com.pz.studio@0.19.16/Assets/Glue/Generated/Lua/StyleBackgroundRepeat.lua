--!AddComponentMenu("")

-- StyleBackgroundRepeat
type StyleBackgroundRepeat =
{
    keyword: StyleKeyword,
    value: BackgroundRepeat,
    Equals: (other: StyleBackgroundRepeat) -> boolean,
}

-- StyleBackgroundRepeatType
type StyleBackgroundRepeatType =
{
    new: (v: BackgroundRepeat) -> StyleBackgroundRepeat,
    new: (keyword: StyleKeyword) -> StyleBackgroundRepeat,
    __eq: (lhs: StyleBackgroundRepeat, rhs: StyleBackgroundRepeat) -> boolean,
    __tostring: () -> string,
}

if not _G.StyleBackgroundRepeat then
    local StyleBackgroundRepeatType_instance : StyleBackgroundRepeatType = {}
    _G.StyleBackgroundRepeat = StyleBackgroundRepeatType_instance;
end
