--!AddComponentMenu("")

-- MeshCollider
type MeshCollider =
{
    convex: boolean,
    sharedMesh: Mesh,
}

-- MeshColliderType
type MeshColliderType =
{
    __tostring: () -> string,
}

if not _G.MeshCollider then
    local MeshColliderType_instance : MeshColliderType = {}
    _G.MeshCollider = MeshColliderType_instance;
end
