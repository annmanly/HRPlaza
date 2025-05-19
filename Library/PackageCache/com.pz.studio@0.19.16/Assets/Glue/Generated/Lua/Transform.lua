--!AddComponentMenu("")

-- Transform
type Transform =
{
    childCount: number,
    hierarchyCount: number,
    localToWorldMatrix: Matrix4x4,
    lossyScale: Vector3,
    root: Transform,
    worldToLocalMatrix: Matrix4x4,
    eulerAngles: Vector3,
    forward: Vector3,
    hasChanged: boolean,
    hierarchyCapacity: number,
    localEulerAngles: Vector3,
    localPosition: Vector3,
    localRotation: Quaternion,
    localScale: Vector3,
    parent: Transform,
    position: Vector3,
    right: Vector3,
    rotation: Quaternion,
    up: Vector3,
    DetachChildren: () -> (),
    Find: (n: string) -> Transform,
    GetChild: (index: number) -> Transform,
    GetLocalPositionAndRotation: () -> (Vector3 , Quaternion),
    GetPositionAndRotation: () -> (Vector3 , Quaternion),
    GetSiblingIndex: () -> number,
    InverseTransformDirection: (direction: Vector3) -> Vector3,
    InverseTransformPoint: (position: Vector3) -> Vector3,
    InverseTransformVector: (vector: Vector3) -> Vector3,
    IsChildOf: (parent: Transform) -> boolean,
    LookAt: (target: Transform) -> (),
    LookAt: (target: Transform , worldUp: Vector3) -> (),
    LookAt: (target: Vector3) -> (),
    LookAt: (worldPosition: Vector3 , worldUp: Vector3) -> (),
    Rotate: (eulers: Vector3 , relativeTo: Space?) -> (),
    Rotate: (axis: Vector3 , angle: number) -> (),
    Rotate: (axis: Vector3 , angle: number , relativeTo: Space) -> (),
    Rotate: (xAngle: number , yAngle: number , zAngle: number) -> (),
    Rotate: (xAngle: number , yAngle: number , zAngle: number , relativeTo: Space) -> (),
    RotateAround: (point: Vector3 , axis: Vector3 , angle: number) -> (),
    SetAsFirstSibling: () -> (),
    SetAsLastSibling: () -> (),
    SetLocalPositionAndRotation: (localPosition: Vector3 , localRotation: Quaternion) -> (),
    SetParent: (parent: Transform , worldPositionStays: boolean?) -> (),
    SetPositionAndRotation: (position: Vector3 , rotation: Quaternion) -> (),
    SetSiblingIndex: (index: number) -> (),
    TransformDirection: (direction: Vector3) -> Vector3,
    TransformPoint: (position: Vector3) -> Vector3,
    TransformVector: (vector: Vector3) -> Vector3,
    Translate: (translation: Vector3 , relativeTo: Space?) -> (),
    Translate: (translation: Vector3 , relativeTo: Transform) -> (),
    Translate: (x: number , y: number , z: number) -> (),
    Translate: (x: number , y: number , z: number , relativeTo: Space) -> (),
    Translate: (x: number , y: number , z: number , relativeTo: Transform) -> (),
    TweenLocalPosition: (from: Vector3 , to: Vector3) -> Tween,
    TweenLocalPositionTo: (to: Vector3) -> Tween,
    TweenLocalScale: (from: Vector3 , to: Vector3) -> Tween,
    TweenLocalScaleTo: (to: Vector3) -> Tween,
    TweenPosition: (from: Vector3 , to: Vector3) -> Tween,
    TweenPositionTo: (to: Vector3) -> Tween,
}

-- TransformType
type TransformType =
{
    __tostring: () -> string,
}

if not _G.Transform then
    local TransformType_instance : TransformType = {}
    _G.Transform = TransformType_instance;
end
