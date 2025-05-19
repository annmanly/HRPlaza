--!AddComponentMenu("")

-- NavMeshSurface
type NavMeshSurface =
{
    agentTypeID: number,
    buildHeightMesh: boolean,
    center: Vector3,
    defaultArea: number,
    ignoreNavMeshAgent: boolean,
    ignoreNavMeshObstacle: boolean,
    layerMask: LayerMask,
    minRegionArea: number,
    overrideTileSize: boolean,
    overrideVoxelSize: boolean,
    size: Vector3,
    tileSize: number,
    voxelSize: number,
    AddData: () -> (),
    BuildNavMesh: () -> (),
    RemoveData: () -> (),
}

-- NavMeshSurfaceType
type NavMeshSurfaceType =
{
    activeSurfaces: {NavMeshSurface},
    __tostring: () -> string,
}

if not _G.NavMeshSurface then
    local NavMeshSurfaceType_instance : NavMeshSurfaceType = {}
    _G.NavMeshSurface = NavMeshSurfaceType_instance;
end
