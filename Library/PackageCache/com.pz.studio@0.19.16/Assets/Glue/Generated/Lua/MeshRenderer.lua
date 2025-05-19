--!AddComponentMenu("")

-- MeshRenderer
type MeshRenderer =
{
    subMeshStartIndex: number,
}

-- MeshRendererType
type MeshRendererType =
{
    __tostring: () -> string,
}

if not _G.MeshRenderer then
    local MeshRendererType_instance : MeshRendererType = {}
    _G.MeshRenderer = MeshRendererType_instance;
end
