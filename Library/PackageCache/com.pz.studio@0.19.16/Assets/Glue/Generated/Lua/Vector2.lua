--!AddComponentMenu("")

-- Vector2
type Vector2 =
{
    x: number,
    y: number,
    magnitude: number,
    normalized: Vector2,
    sqrMagnitude: number,
    Equals: (other: Vector2) -> boolean,
    Normalize: () -> (),
    Scale: (scale: Vector2) -> (),
    Set: (newX: number , newY: number) -> (),
    SqrMagnitude: () -> number,
}

-- Vector2Type
type Vector2Type =
{
    down: Vector2,
    left: Vector2,
    negativeInfinity: Vector2,
    one: Vector2,
    positiveInfinity: Vector2,
    right: Vector2,
    up: Vector2,
    zero: Vector2,
    new: (x: number, y: number) -> Vector2,
    Angle: (from: Vector2, to: Vector2) -> number,
    ClampMagnitude: (vector: Vector2, maxLength: number) -> Vector2,
    Distance: (a: Vector2, b: Vector2) -> number,
    Dot: (lhs: Vector2, rhs: Vector2) -> number,
    Lerp: (a: Vector2, b: Vector2, t: number) -> Vector2,
    LerpUnclamped: (a: Vector2, b: Vector2, t: number) -> Vector2,
    Max: (lhs: Vector2, rhs: Vector2) -> Vector2,
    Min: (lhs: Vector2, rhs: Vector2) -> Vector2,
    MoveTowards: (current: Vector2, target: Vector2, maxDistanceDelta: number) -> Vector2,
    Perpendicular: (inDirection: Vector2) -> Vector2,
    Reflect: (inDirection: Vector2, inNormal: Vector2) -> Vector2,
    Scale: (a: Vector2, b: Vector2) -> Vector2,
    SignedAngle: (from: Vector2, to: Vector2) -> number,
    SmoothDamp: (current: Vector2, target: Vector2, currentVelocity: Vector2, smoothTime: number) -> (Vector2 , Vector2),
    SmoothDamp: (current: Vector2, target: Vector2, currentVelocity: Vector2, smoothTime: number, maxSpeed: number) -> (Vector2 , Vector2),
    SmoothDamp: (current: Vector2, target: Vector2, currentVelocity: Vector2, smoothTime: number, maxSpeed: number, deltaTime: number) -> (Vector2 , Vector2),
    SqrMagnitude: (a: Vector2) -> number,
    __add: (a: Vector2, b: Vector2) -> Vector2,
    __div: (a: Vector2, b: Vector2) -> Vector2,
    __div: (a: Vector2, d: number) -> Vector2,
    __eq: (lhs: Vector2, rhs: Vector2) -> boolean,
    __mul: (a: Vector2, b: Vector2) -> Vector2,
    __mul: (a: Vector2, d: number) -> Vector2,
    __mul: (d: number, a: Vector2) -> Vector2,
    __sub: (a: Vector2, b: Vector2) -> Vector2,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
    __unm: (a: Vector2) -> Vector2,
}

if not _G.Vector2 then
    local Vector2Type_instance : Vector2Type = {}
    _G.Vector2 = Vector2Type_instance;
end
