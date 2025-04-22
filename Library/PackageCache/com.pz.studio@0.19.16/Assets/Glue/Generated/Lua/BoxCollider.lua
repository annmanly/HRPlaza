--!AddComponentMenu("")

-- BoxCollider
type BoxCollider =
{
    center: Vector3,
    size: Vector3,
}

-- BoxColliderType
type BoxColliderType =
{
    __tostring: () -> string,
}

if not _G.BoxCollider then
    local BoxColliderType_instance : BoxColliderType = {}
    _G.BoxCollider = BoxColliderType_instance;
end
