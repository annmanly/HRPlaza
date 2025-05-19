--!AddComponentMenu("")

-- DisplayStyle
type DisplayStyle =
{
}

-- DisplayStyleType
type DisplayStyleType =
{
    Flex: DisplayStyle,
    None: DisplayStyle,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.DisplayStyle then
    local DisplayStyleType_instance : DisplayStyleType = {}
    _G.DisplayStyle = DisplayStyleType_instance;
end
