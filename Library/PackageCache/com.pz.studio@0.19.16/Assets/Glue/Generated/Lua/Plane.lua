--!AddComponentMenu("")

-- Plane
type Plane =
{
    flipped: Plane,
    distance: number,
    normal: Vector3,
    ClosestPointOnPlane: (point: Vector3) -> Vector3,
    Flip: () -> (),
    GetDistanceToPoint: (point: Vector3) -> number,
    GetSide: (point: Vector3) -> boolean,
    Raycast: (ray: Ray) -> (boolean , number),
    SameSide: (inPt0: Vector3 , inPt1: Vector3) -> boolean,
    Set3Points: (a: Vector3 , b: Vector3 , c: Vector3) -> (),
    SetNormalAndPosition: (inNormal: Vector3 , inPoint: Vector3) -> (),
    Translate: (translation: Vector3) -> (),
}

-- PlaneType
type PlaneType =
{
    new: (a: Vector3, b: Vector3, c: Vector3) -> Plane,
    new: (inNormal: Vector3, d: number) -> Plane,
    Translate: (plane: Plane, translation: Vector3) -> Plane,
    new: (inNormal: Vector3, inPoint: Vector3) -> Plane,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Plane then
    local PlaneType_instance : PlaneType = {}
    _G.Plane = PlaneType_instance;
end
