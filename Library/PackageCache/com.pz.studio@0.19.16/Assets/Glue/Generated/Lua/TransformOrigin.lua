--!AddComponentMenu("")

-- TransformOrigin
type TransformOrigin =
{
    x: Length,
    y: Length,
    z: number,
    Equals: (other: TransformOrigin) -> boolean,
}

-- TransformOriginType
type TransformOriginType =
{
    new: (x: Length, y: Length) -> TransformOrigin,
    new: (x: Length, y: Length, z: number) -> TransformOrigin,
    Initial: () -> TransformOrigin,
    __eq: (lhs: TransformOrigin, rhs: TransformOrigin) -> boolean,
    __tostring: () -> string,
}

if not _G.TransformOrigin then
    local TransformOriginType_instance : TransformOriginType = {}
    _G.TransformOrigin = TransformOriginType_instance;
end
