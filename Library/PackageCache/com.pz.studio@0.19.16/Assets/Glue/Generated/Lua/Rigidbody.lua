--!AddComponentMenu("")

-- Rigidbody
type Rigidbody =
{
    worldCenterOfMass: Vector3,
    angularDrag: number,
    angularVelocity: Vector3,
    automaticCenterOfMass: boolean,
    automaticInertiaTensor: boolean,
    centerOfMass: Vector3,
    detectCollisions: boolean,
    drag: number,
    excludeLayers: LayerMask,
    freezeRotation: boolean,
    includeLayers: LayerMask,
    inertiaTensor: Vector3,
    inertiaTensorRotation: Quaternion,
    isKinematic: boolean,
    mass: number,
    maxAngularVelocity: number,
    maxDepenetrationVelocity: number,
    maxLinearVelocity: number,
    position: Vector3,
    rotation: Quaternion,
    sleepThreshold: number,
    solverIterations: number,
    solverVelocityIterations: number,
    useGravity: boolean,
    velocity: Vector3,
    AddExplosionForce: (explosionForce: number , explosionPosition: Vector3 , explosionRadius: number , upwardsModifier: number? , mode: ForceMode?) -> (),
    AddForce: (force: Vector3 , mode: ForceMode?) -> (),
    AddForce: (x: number , y: number , z: number) -> (),
    AddForce: (x: number , y: number , z: number , mode: ForceMode) -> (),
    AddForceAtPosition: (force: Vector3 , position: Vector3 , mode: ForceMode?) -> (),
    AddRelativeForce: (force: Vector3 , mode: ForceMode?) -> (),
    AddRelativeForce: (x: number , y: number , z: number) -> (),
    AddRelativeForce: (x: number , y: number , z: number , mode: ForceMode) -> (),
    AddRelativeTorque: (torque: Vector3 , mode: ForceMode?) -> (),
    AddRelativeTorque: (x: number , y: number , z: number) -> (),
    AddRelativeTorque: (x: number , y: number , z: number , mode: ForceMode) -> (),
    AddTorque: (torque: Vector3 , mode: ForceMode?) -> (),
    AddTorque: (x: number , y: number , z: number) -> (),
    AddTorque: (x: number , y: number , z: number , mode: ForceMode) -> (),
    ClosestPointOnBounds: (position: Vector3) -> Vector3,
    GetAccumulatedForce: (step: number?) -> Vector3,
    GetAccumulatedTorque: (step: number?) -> Vector3,
    GetPointVelocity: (worldPoint: Vector3) -> Vector3,
    GetRelativePointVelocity: (relativePoint: Vector3) -> Vector3,
    IsSleeping: () -> boolean,
    Move: (position: Vector3 , rotation: Quaternion) -> (),
    MovePosition: (position: Vector3) -> (),
    MoveRotation: (rot: Quaternion) -> (),
    ResetCenterOfMass: () -> (),
    ResetInertiaTensor: () -> (),
    SetDensity: (density: number) -> (),
    Sleep: () -> (),
    SweepTest: (direction: Vector3) -> (boolean , RaycastHit),
    SweepTest: (direction: Vector3 , maxDistance: number) -> (boolean , RaycastHit),
    SweepTestAll: (direction: Vector3 , maxDistance: number?) -> {RaycastHit},
    WakeUp: () -> (),
}

-- RigidbodyType
type RigidbodyType =
{
    __tostring: () -> string,
}

if not _G.Rigidbody then
    local RigidbodyType_instance : RigidbodyType = {}
    _G.Rigidbody = RigidbodyType_instance;
end
