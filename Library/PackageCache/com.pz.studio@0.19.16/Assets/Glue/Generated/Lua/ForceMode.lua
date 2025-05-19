--!AddComponentMenu("")

-- ForceMode
type ForceMode =
{
}

-- ForceModeType
type ForceModeType =
{
    Acceleration: ForceMode,
    Force: ForceMode,
    Impulse: ForceMode,
    VelocityChange: ForceMode,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.ForceMode then
    local ForceModeType_instance : ForceModeType = {}
    _G.ForceMode = ForceModeType_instance;
end
