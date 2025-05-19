--!AddComponentMenu("")

-- ContactPoint
type ContactPoint =
{
    impulse: Vector3,
    normal: Vector3,
    otherCollider: Collider,
    point: Vector3,
    separation: number,
    thisCollider: Collider,
}

-- ContactPointType
type ContactPointType =
{
    __tostring: () -> string,
}

if not _G.ContactPoint then
    local ContactPointType_instance : ContactPointType = {}
    _G.ContactPoint = ContactPointType_instance;
end
