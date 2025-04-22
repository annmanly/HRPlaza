--!AddComponentMenu("")

-- Position
type Position =
{
}

-- PositionType
type PositionType =
{
    Absolute: Position,
    Relative: Position,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Position then
    local PositionType_instance : PositionType = {}
    _G.Position = PositionType_instance;
end
