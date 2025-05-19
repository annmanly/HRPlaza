--!AddComponentMenu("")

-- StyleKeyword
type StyleKeyword =
{
}

-- StyleKeywordType
type StyleKeywordType =
{
    Auto: StyleKeyword,
    Initial: StyleKeyword,
    None: StyleKeyword,
    Null: StyleKeyword,
    Undefined: StyleKeyword,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.StyleKeyword then
    local StyleKeywordType_instance : StyleKeywordType = {}
    _G.StyleKeyword = StyleKeywordType_instance;
end
