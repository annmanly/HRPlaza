--!AddComponentMenu("")

-- AngleUnit
type AngleUnit =
{
}

-- AngleUnitType
type AngleUnitType =
{
    Degree: AngleUnit,
    Gradian: AngleUnit,
    Radian: AngleUnit,
    Turn: AngleUnit,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.AngleUnit then
    local AngleUnitType_instance : AngleUnitType = {}
    _G.AngleUnit = AngleUnitType_instance;
end
