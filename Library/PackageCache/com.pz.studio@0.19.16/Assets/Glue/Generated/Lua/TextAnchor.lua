--!AddComponentMenu("")

-- TextAnchor
type TextAnchor =
{
}

-- TextAnchorType
type TextAnchorType =
{
    LowerCenter: TextAnchor,
    LowerLeft: TextAnchor,
    LowerRight: TextAnchor,
    MiddleCenter: TextAnchor,
    MiddleLeft: TextAnchor,
    MiddleRight: TextAnchor,
    UpperCenter: TextAnchor,
    UpperLeft: TextAnchor,
    UpperRight: TextAnchor,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.TextAnchor then
    local TextAnchorType_instance : TextAnchorType = {}
    _G.TextAnchor = TextAnchorType_instance;
end
