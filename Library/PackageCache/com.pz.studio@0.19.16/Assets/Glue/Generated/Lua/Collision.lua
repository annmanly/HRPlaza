--!AddComponentMenu("")

-- Collision
type Collision =
{
    body: Component,
    collider: Collider,
    contactCount: number,
    contacts: {ContactPoint},
    gameObject: GameObject,
    impulse: Vector3,
    relativeVelocity: Vector3,
    rigidbody: Rigidbody,
    transform: Transform,
    GetContact: (index: number) -> ContactPoint,
}

-- CollisionType
type CollisionType =
{
    __tostring: () -> string,
}

if not _G.Collision then
    local CollisionType_instance : CollisionType = {}
    _G.Collision = CollisionType_instance;
end
