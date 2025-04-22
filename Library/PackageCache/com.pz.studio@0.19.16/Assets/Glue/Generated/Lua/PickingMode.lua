--!AddComponentMenu("")

-- PickingMode
type PickingMode =
{
}

-- PickingModeType
type PickingModeType =
{
    Ignore: PickingMode,
    Position: PickingMode,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.PickingMode then
    local PickingModeType_instance : PickingModeType = {}
    _G.PickingMode = PickingModeType_instance;
end
