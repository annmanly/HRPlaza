--!AddComponentMenu("")

-- Ray
type Ray =
{
    direction: Vector3,
    origin: Vector3,
    GetPoint: (distance: number) -> Vector3,
}

-- RayType
type RayType =
{
    new: (origin: Vector3, direction: Vector3) -> Ray,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Ray then
    local RayType_instance : RayType = {}
    _G.Ray = RayType_instance;
end
