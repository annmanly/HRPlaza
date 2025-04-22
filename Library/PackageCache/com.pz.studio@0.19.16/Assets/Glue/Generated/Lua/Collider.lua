--!AddComponentMenu("")

-- Collider
type Collider =
{
    attachedRigidbody: Rigidbody,
    bounds: Bounds,
    contactOffset: number,
    enabled: boolean,
    excludeLayers: LayerMask,
    hasModifiableContacts: boolean,
    includeLayers: LayerMask,
    isTrigger: boolean,
    layerOverridePriority: number,
    providesContacts: boolean,
    ClosestPoint: (position: Vector3) -> Vector3,
    ClosestPointOnBounds: (position: Vector3) -> Vector3,
    Raycast: (ray: Ray , maxDistance: number) -> (boolean , RaycastHit),
}

-- ColliderType
type ColliderType =
{
    __tostring: () -> string,
}

if not _G.Collider then
    local ColliderType_instance : ColliderType = {}
    _G.Collider = ColliderType_instance;
end
