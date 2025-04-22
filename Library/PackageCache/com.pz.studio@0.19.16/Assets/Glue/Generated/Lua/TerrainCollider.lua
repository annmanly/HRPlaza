--!AddComponentMenu("")

-- TerrainCollider
type TerrainCollider =
{
}

-- TerrainColliderType
type TerrainColliderType =
{
    __tostring: () -> string,
}

if not _G.TerrainCollider then
    local TerrainColliderType_instance : TerrainColliderType = {}
    _G.TerrainCollider = TerrainColliderType_instance;
end
