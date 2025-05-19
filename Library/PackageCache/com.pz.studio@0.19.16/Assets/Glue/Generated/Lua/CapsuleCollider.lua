--!AddComponentMenu("")

-- CapsuleCollider
type CapsuleCollider =
{
    center: Vector3,
    direction: number,
    height: number,
    radius: number,
}

-- CapsuleColliderType
type CapsuleColliderType =
{
    __tostring: () -> string,
}

if not _G.CapsuleCollider then
    local CapsuleColliderType_instance : CapsuleColliderType = {}
    _G.CapsuleCollider = CapsuleColliderType_instance;
end
