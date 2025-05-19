--!AddComponentMenu("")

-- Matrix4x4
type Matrix4x4 =
{
    m00: number,
    m01: number,
    m02: number,
    m03: number,
    m10: number,
    m11: number,
    m12: number,
    m13: number,
    m20: number,
    m21: number,
    m22: number,
    m23: number,
    m30: number,
    m31: number,
    m32: number,
    m33: number,
    determinant: number,
    inverse: Matrix4x4,
    isIdentity: boolean,
    lossyScale: Vector3,
    rotation: Quaternion,
    transpose: Matrix4x4,
    Equals: (other: Matrix4x4) -> boolean,
    GetColumn: (index: number) -> Vector4,
    GetPosition: () -> Vector3,
    GetRow: (index: number) -> Vector4,
    MultiplyPoint: (point: Vector3) -> Vector3,
    MultiplyPoint3x4: (point: Vector3) -> Vector3,
    MultiplyVector: (vector: Vector3) -> Vector3,
    SetColumn: (index: number , column: Vector4) -> (),
    SetRow: (index: number , row: Vector4) -> (),
    SetTRS: (pos: Vector3 , q: Quaternion , s: Vector3) -> (),
    TransformPlane: (plane: Plane) -> Plane,
    ValidTRS: () -> boolean,
}

-- Matrix4x4Type
type Matrix4x4Type =
{
    identity: Matrix4x4,
    zero: Matrix4x4,
    new: (column0: Vector4, column1: Vector4, column2: Vector4, column3: Vector4) -> Matrix4x4,
    Determinant: (m: Matrix4x4) -> number,
    Frustum: (left: number, right: number, bottom: number, top: number, zNear: number, zFar: number) -> Matrix4x4,
    Inverse: (m: Matrix4x4) -> Matrix4x4,
    Inverse3DAffine: (input: Matrix4x4, result: Matrix4x4) -> (boolean , Matrix4x4),
    LookAt: (from: Vector3, to: Vector3, up: Vector3) -> Matrix4x4,
    Ortho: (left: number, right: number, bottom: number, top: number, zNear: number, zFar: number) -> Matrix4x4,
    Perspective: (fov: number, aspect: number, zNear: number, zFar: number) -> Matrix4x4,
    Rotate: (q: Quaternion) -> Matrix4x4,
    Scale: (vector: Vector3) -> Matrix4x4,
    TRS: (pos: Vector3, q: Quaternion, s: Vector3) -> Matrix4x4,
    Translate: (vector: Vector3) -> Matrix4x4,
    Transpose: (m: Matrix4x4) -> Matrix4x4,
    __eq: (lhs: Matrix4x4, rhs: Matrix4x4) -> boolean,
    __mul: (lhs: Matrix4x4, rhs: Matrix4x4) -> Matrix4x4,
    __mul: (lhs: Matrix4x4, vector: Vector4) -> Vector4,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Matrix4x4 then
    local Matrix4x4Type_instance : Matrix4x4Type = {}
    _G.Matrix4x4 = Matrix4x4Type_instance;
end
