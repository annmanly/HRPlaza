--!AddComponentMenu("")

-- Vector3
type Vector3 =
{
    x: number,
    y: number,
    z: number,
    magnitude: number,
    normalized: Vector3,
    sqrMagnitude: number,
    Equals: (other: Vector3) -> boolean,
    Normalize: () -> (),
    Scale: (scale: Vector3) -> (),
    Set: (newX: number , newY: number , newZ: number) -> (),
}

-- Vector3Type
type Vector3Type =
{
    back: Vector3,
    down: Vector3,
    forward: Vector3,
    left: Vector3,
    negativeInfinity: Vector3,
    one: Vector3,
    positiveInfinity: Vector3,
    right: Vector3,
    up: Vector3,
    zero: Vector3,
    new: (x: number, y: number) -> Vector3,
    new: (x: number, y: number, z: number) -> Vector3,
    Angle: (from: Vector3, to: Vector3) -> number,
    ClampMagnitude: (vector: Vector3, maxLength: number) -> Vector3,
    Cross: (lhs: Vector3, rhs: Vector3) -> Vector3,
    Distance: (a: Vector3, b: Vector3) -> number,
    Dot: (lhs: Vector3, rhs: Vector3) -> number,
    Lerp: (a: Vector3, b: Vector3, t: number) -> Vector3,
    LerpUnclamped: (a: Vector3, b: Vector3, t: number) -> Vector3,
    Magnitude: (vector: Vector3) -> number,
    Max: (lhs: Vector3, rhs: Vector3) -> Vector3,
    Min: (lhs: Vector3, rhs: Vector3) -> Vector3,
    MoveTowards: (current: Vector3, target: Vector3, maxDistanceDelta: number) -> Vector3,
    Normalize: (value: Vector3) -> Vector3,
    OrthoNormalize: (normal: Vector3, tangent: Vector3) -> (Vector3 , Vector3),
    OrthoNormalize: (normal: Vector3, tangent: Vector3, binormal: Vector3) -> (Vector3 , Vector3 , Vector3),
    Project: (vector: Vector3, onNormal: Vector3) -> Vector3,
    ProjectOnPlane: (vector: Vector3, planeNormal: Vector3) -> Vector3,
    Reflect: (inDirection: Vector3, inNormal: Vector3) -> Vector3,
    RotateTowards: (current: Vector3, target: Vector3, maxRadiansDelta: number, maxMagnitudeDelta: number) -> Vector3,
    Scale: (a: Vector3, b: Vector3) -> Vector3,
    SignedAngle: (from: Vector3, to: Vector3, axis: Vector3) -> number,
    Slerp: (a: Vector3, b: Vector3, t: number) -> Vector3,
    SlerpUnclamped: (a: Vector3, b: Vector3, t: number) -> Vector3,
    SmoothDamp: (current: Vector3, target: Vector3, currentVelocity: Vector3, smoothTime: number) -> (Vector3 , Vector3),
    SmoothDamp: (current: Vector3, target: Vector3, currentVelocity: Vector3, smoothTime: number, maxSpeed: number) -> (Vector3 , Vector3),
    SmoothDamp: (current: Vector3, target: Vector3, currentVelocity: Vector3, smoothTime: number, maxSpeed: number, deltaTime: number) -> (Vector3 , Vector3),
    SqrMagnitude: (vector: Vector3) -> number,
    __add: (a: Vector3, b: Vector3) -> Vector3,
    __div: (a: Vector3, d: number) -> Vector3,
    __eq: (lhs: Vector3, rhs: Vector3) -> boolean,
    __mul: (a: Vector3, b: number) -> Vector3,
    __mul: (d: number, a: Vector3) -> Vector3,
    __sub: (a: Vector3, b: Vector3) -> Vector3,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
    __unm: (a: Vector3) -> Vector3,
}

if not _G.Vector3 then
    local Vector3Type_instance : Vector3Type = {}
    _G.Vector3 = Vector3Type_instance;
end
