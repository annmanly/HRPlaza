--!AddComponentMenu("")

-- Scale
type Scale =
{
    value: Vector3,
    Equals: (other: Scale) -> boolean,
}

-- ScaleType
type ScaleType =
{
    new: (scale: Vector2) -> Scale,
    new: (scale: Vector3) -> Scale,
    None: () -> Scale,
    __eq: (lhs: Scale, rhs: Scale) -> boolean,
    __tostring: () -> string,
}

if not _G.Scale then
    local ScaleType_instance : ScaleType = {}
    _G.Scale = ScaleType_instance;
end
