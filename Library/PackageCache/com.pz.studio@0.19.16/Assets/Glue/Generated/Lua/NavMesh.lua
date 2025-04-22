--!AddComponentMenu("")

-- NavMesh
type NavMesh =
{
}

-- NavMeshType
type NavMeshType =
{
    allAreas: number,
    onPreUpdate: () -> (),
    avoidancePredictionTime: number,
    pathfindingIterationsPerFrame: number,
    FindClosestEdge: (sourcePosition: Vector3, areaMask: number) -> (boolean , NavMeshHit),
    GetAreaCost: (areaIndex: number) -> number,
    GetAreaFromName: (areaName: string) -> number,
    GetSettingsCount: () -> number,
    GetSettingsNameFromID: (agentTypeID: number) -> string,
    Raycast: (sourcePosition: Vector3, targetPosition: Vector3, areaMask: number) -> (boolean , NavMeshHit),
    RemoveAllNavMeshData: () -> (),
    RemoveSettings: (agentTypeID: number) -> (),
    SamplePosition: (sourcePosition: Vector3, maxDistance: number, areaMask: number) -> (boolean , NavMeshHit),
    SetAreaCost: (areaIndex: number, cost: number) -> (),
}

if not _G.NavMesh then
    local NavMeshType_instance : NavMeshType = {}
    _G.NavMesh = NavMeshType_instance;
end
