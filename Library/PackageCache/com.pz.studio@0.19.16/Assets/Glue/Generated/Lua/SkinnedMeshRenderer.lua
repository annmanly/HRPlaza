--!AddComponentMenu("")

-- SkinnedMeshRenderer
type SkinnedMeshRenderer =
{
    bones: {Transform},
    forceMatrixRecalculationPerRender: boolean,
    rootBone: Transform,
    sharedMesh: Mesh,
    skinnedMotionVectors: boolean,
    updateWhenOffscreen: boolean,
    BakeMesh: (mesh: Mesh) -> (),
    BakeMesh: (mesh: Mesh , useScale: boolean) -> (),
    GetBlendShapeWeight: (index: number) -> number,
    SetBlendShapeWeight: (index: number , value: number) -> (),
}

-- SkinnedMeshRendererType
type SkinnedMeshRendererType =
{
    __tostring: () -> string,
}

if not _G.SkinnedMeshRenderer then
    local SkinnedMeshRendererType_instance : SkinnedMeshRendererType = {}
    _G.SkinnedMeshRenderer = SkinnedMeshRendererType_instance;
end
