--!AddComponentMenu("")

-- MeshFilter
type MeshFilter =
{
    mesh: Mesh,
    sharedMesh: Mesh,
}

-- MeshFilterType
type MeshFilterType =
{
    __tostring: () -> string,
}

if not _G.MeshFilter then
    local MeshFilterType_instance : MeshFilterType = {}
    _G.MeshFilter = MeshFilterType_instance;
end
