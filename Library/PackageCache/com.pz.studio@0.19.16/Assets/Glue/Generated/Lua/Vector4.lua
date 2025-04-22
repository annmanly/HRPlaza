--!AddComponentMenu("")

-- Vector4
type Vector4 =
{
    w: number,
    x: number,
    y: number,
    z: number,
    magnitude: number,
    normalized: Vector4,
    sqrMagnitude: number,
    Equals: (other: Vector4) -> boolean,
    Normalize: () -> (),
    Scale: (scale: Vector4) -> (),
    Set: (newX: number , newY: number , newZ: number , newW: number) -> (),
    SqrMagnitude: () -> number,
}

-- Vector4Type
type Vector4Type =
{
    kEpsilon: number,
    negativeInfinity: Vector4,
    one: Vector4,
    positiveInfinity: Vector4,
    zero: Vector4,
    new: (x: number, y: number) -> Vector4,
    new: (x: number, y: number, z: number) -> Vector4,
    new: (x: number, y: number, z: number, w: number) -> Vector4,
    Distance: (a: Vector4, b: Vector4) -> number,
    Dot: (a: Vector4, b: Vector4) -> number,
    Lerp: (a: Vector4, b: Vector4, t: number) -> Vector4,
    LerpUnclamped: (a: Vector4, b: Vector4, t: number) -> Vector4,
    Magnitude: (a: Vector4) -> number,
    Max: (lhs: Vector4, rhs: Vector4) -> Vector4,
    Min: (lhs: Vector4, rhs: Vector4) -> Vector4,
    MoveTowards: (current: Vector4, target: Vector4, maxDistanceDelta: number) -> Vector4,
    Normalize: (a: Vector4) -> Vector4,
    Project: (a: Vector4, b: Vector4) -> Vector4,
    Scale: (a: Vector4, b: Vector4) -> Vector4,
    SqrMagnitude: (a: Vector4) -> number,
    __add: (a: Vector4, b: Vector4) -> Vector4,
    __div: (a: Vector4, d: number) -> Vector4,
    __eq: (lhs: Vector4, rhs: Vector4) -> boolean,
    __mul: (a: Vector4, b: number) -> Vector4,
    __mul: (d: number, a: Vector4) -> Vector4,
    __sub: (a: Vector4, b: Vector4) -> Vector4,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
    __unm: (a: Vector4) -> Vector4,
}

if not _G.Vector4 then
    local Vector4Type_instance : Vector4Type = {}
    _G.Vector4 = Vector4Type_instance;
end
