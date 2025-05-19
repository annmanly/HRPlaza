--!AddComponentMenu("")

-- TextOverflowPosition
type TextOverflowPosition =
{
}

-- TextOverflowPositionType
type TextOverflowPositionType =
{
    End: TextOverflowPosition,
    Middle: TextOverflowPosition,
    Start: TextOverflowPosition,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.TextOverflowPosition then
    local TextOverflowPositionType_instance : TextOverflowPositionType = {}
    _G.TextOverflowPosition = TextOverflowPositionType_instance;
end
