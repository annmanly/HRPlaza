--!AddComponentMenu("")

-- TrickleDown
type TrickleDown =
{
}

-- TrickleDownType
type TrickleDownType =
{
    NoTrickleDown: TrickleDown,
    TrickleDown: TrickleDown,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.TrickleDown then
    local TrickleDownType_instance : TrickleDownType = {}
    _G.TrickleDown = TrickleDownType_instance;
end
