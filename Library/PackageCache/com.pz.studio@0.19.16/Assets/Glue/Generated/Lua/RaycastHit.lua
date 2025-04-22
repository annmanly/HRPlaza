--!AddComponentMenu("")

-- RaycastHit
type RaycastHit =
{
    collider: Collider,
    colliderInstanceID: number,
    lightmapCoord: Vector2,
    rigidbody: Rigidbody,
    textureCoord: Vector2,
    textureCoord2: Vector2,
    transform: Transform,
    triangleIndex: number,
    barycentricCoordinate: Vector3,
    distance: number,
    normal: Vector3,
    point: Vector3,
}

-- RaycastHitType
type RaycastHitType =
{
    __tostring: () -> string,
}

if not _G.RaycastHit then
    local RaycastHitType_instance : RaycastHitType = {}
    _G.RaycastHit = RaycastHitType_instance;
end
