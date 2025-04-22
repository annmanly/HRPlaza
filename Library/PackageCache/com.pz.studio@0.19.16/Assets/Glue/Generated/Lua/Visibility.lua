--!AddComponentMenu("")

-- Visibility
type Visibility =
{
}

-- VisibilityType
type VisibilityType =
{
    Hidden: Visibility,
    Visible: Visibility,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Visibility then
    local VisibilityType_instance : VisibilityType = {}
    _G.Visibility = VisibilityType_instance;
end
