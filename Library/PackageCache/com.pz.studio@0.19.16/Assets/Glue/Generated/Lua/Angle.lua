--!AddComponentMenu("")

-- Angle
type Angle =
{
    unit: AngleUnit,
    value: number,
    Equals: (other: Angle) -> boolean,
    ToDegrees: () -> number,
    ToGradians: () -> number,
    ToRadians: () -> number,
    ToTurns: () -> number,
}

-- AngleType
type AngleType =
{
    new: (value: number) -> Angle,
    new: (value: number, unit: AngleUnit) -> Angle,
    Degrees: (value: number) -> Angle,
    Gradians: (value: number) -> Angle,
    Radians: (value: number) -> Angle,
    Turns: (value: number) -> Angle,
    __eq: (lhs: Angle, rhs: Angle) -> boolean,
    __tostring: () -> string,
}

if not _G.Angle then
    local AngleType_instance : AngleType = {}
    _G.Angle = AngleType_instance;
end
