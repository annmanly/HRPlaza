--!AddComponentMenu("")

-- Rotate
type Rotate =
{
    angle: Angle,
    Equals: (other: Rotate) -> boolean,
}

-- RotateType
type RotateType =
{
    new: (angle: Angle) -> Rotate,
    None: () -> Rotate,
    __eq: (lhs: Rotate, rhs: Rotate) -> boolean,
    __tostring: () -> string,
}

if not _G.Rotate then
    local RotateType_instance : RotateType = {}
    _G.Rotate = RotateType_instance;
end
