--!AddComponentMenu("")

-- Wrap
type Wrap =
{
}

-- WrapType
type WrapType =
{
    NoWrap: Wrap,
    Wrap: Wrap,
    WrapReverse: Wrap,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Wrap then
    local WrapType_instance : WrapType = {}
    _G.Wrap = WrapType_instance;
end
