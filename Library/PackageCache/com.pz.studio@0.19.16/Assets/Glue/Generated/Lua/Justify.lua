--!AddComponentMenu("")

-- Justify
type Justify =
{
}

-- JustifyType
type JustifyType =
{
    Center: Justify,
    FlexEnd: Justify,
    FlexStart: Justify,
    SpaceAround: Justify,
    SpaceBetween: Justify,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Justify then
    local JustifyType_instance : JustifyType = {}
    _G.Justify = JustifyType_instance;
end
