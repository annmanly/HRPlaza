--!AddComponentMenu("")

-- Align
type Align =
{
}

-- AlignType
type AlignType =
{
    Auto: Align,
    Center: Align,
    FlexEnd: Align,
    FlexStart: Align,
    Stretch: Align,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Align then
    local AlignType_instance : AlignType = {}
    _G.Align = AlignType_instance;
end
