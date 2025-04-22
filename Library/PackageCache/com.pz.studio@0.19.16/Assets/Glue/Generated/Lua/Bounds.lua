--!AddComponentMenu("")

-- Bounds
type Bounds =
{
    center: Vector3,
    extents: Vector3,
    max: Vector3,
    min: Vector3,
    size: Vector3,
    ClosestPoint: (point: Vector3) -> Vector3,
    Contains: (point: Vector3) -> boolean,
    Encapsulate: (bounds: Bounds) -> (),
    Encapsulate: (point: Vector3) -> (),
    Equals: (other: Bounds) -> boolean,
    Expand: (amount: Vector3) -> (),
    Expand: (amount: number) -> (),
    IntersectRay: (ray: Ray) -> boolean,
    Intersects: (bounds: Bounds) -> boolean,
    SetMinMax: (min: Vector3 , max: Vector3) -> (),
    SqrDistance: (point: Vector3) -> number,
}

-- BoundsType
type BoundsType =
{
    new: (center: Vector3, size: Vector3) -> Bounds,
    __eq: (lhs: Bounds, rhs: Bounds) -> boolean,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Bounds then
    local BoundsType_instance : BoundsType = {}
    _G.Bounds = BoundsType_instance;
end
