--!AddComponentMenu("")

-- Overflow
type Overflow =
{
}

-- OverflowType
type OverflowType =
{
    Hidden: Overflow,
    Visible: Overflow,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Overflow then
    local OverflowType_instance : OverflowType = {}
    _G.Overflow = OverflowType_instance;
end
