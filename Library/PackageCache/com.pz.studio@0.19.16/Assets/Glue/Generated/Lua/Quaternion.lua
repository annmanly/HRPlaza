--!AddComponentMenu("")

-- Quaternion
type Quaternion =
{
    w: number,
    x: number,
    y: number,
    z: number,
    normalized: Quaternion,
    eulerAngles: Vector3,
    Equals: (other: Quaternion) -> boolean,
    Normalize: () -> (),
    Set: (newX: number , newY: number , newZ: number , newW: number) -> (),
    SetFromToRotation: (fromDirection: Vector3 , toDirection: Vector3) -> (),
    SetLookRotation: (view: Vector3) -> (),
    SetLookRotation: (view: Vector3 , up: Vector3) -> (),
    ToAngleAxis: () -> (number , Vector3),
}

-- QuaternionType
type QuaternionType =
{
    identity: Quaternion,
    new: (x: number, y: number, z: number, w: number) -> Quaternion,
    Angle: (a: Quaternion, b: Quaternion) -> number,
    AngleAxis: (angle: number, axis: Vector3) -> Quaternion,
    Dot: (a: Quaternion, b: Quaternion) -> number,
    Euler: (euler: Vector3) -> Quaternion,
    Euler: (x: number, y: number, z: number) -> Quaternion,
    FromToRotation: (fromDirection: Vector3, toDirection: Vector3) -> Quaternion,
    Inverse: (rotation: Quaternion) -> Quaternion,
    Lerp: (a: Quaternion, b: Quaternion, t: number) -> Quaternion,
    LerpUnclamped: (a: Quaternion, b: Quaternion, t: number) -> Quaternion,
    LookRotation: (forward: Vector3) -> Quaternion,
    LookRotation: (forward: Vector3, upwards: Vector3) -> Quaternion,
    Multiply: (lhs: Quaternion, rhs: Quaternion) -> Quaternion,
    Normalize: (q: Quaternion) -> Quaternion,
    RotateTowards: (from: Quaternion, to: Quaternion, maxDegreesDelta: number) -> Quaternion,
    Slerp: (a: Quaternion, b: Quaternion, t: number) -> Quaternion,
    SlerpUnclamped: (a: Quaternion, b: Quaternion, t: number) -> Quaternion,
    __eq: (lhs: Quaternion, rhs: Quaternion) -> boolean,
    __mul: (lhs: Quaternion, rhs: Quaternion) -> Quaternion,
    __mul: (rotation: Quaternion, point: Vector3) -> Vector3,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Quaternion then
    local QuaternionType_instance : QuaternionType = {}
    _G.Quaternion = QuaternionType_instance;
end
