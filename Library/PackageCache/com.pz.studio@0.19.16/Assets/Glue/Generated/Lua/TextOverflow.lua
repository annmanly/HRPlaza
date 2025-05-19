--!AddComponentMenu("")

-- TextOverflow
type TextOverflow =
{
}

-- TextOverflowType
type TextOverflowType =
{
    Clip: TextOverflow,
    Ellipsis: TextOverflow,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.TextOverflow then
    local TextOverflowType_instance : TextOverflowType = {}
    _G.TextOverflow = TextOverflowType_instance;
end
