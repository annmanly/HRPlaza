--!AddComponentMenu("")

-- FontStyle
type FontStyle =
{
}

-- FontStyleType
type FontStyleType =
{
    Bold: FontStyle,
    BoldAndItalic: FontStyle,
    Italic: FontStyle,
    Normal: FontStyle,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.FontStyle then
    local FontStyleType_instance : FontStyleType = {}
    _G.FontStyle = FontStyleType_instance;
end
