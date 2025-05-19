--!AddComponentMenu("")

-- NavMeshObstacle
type NavMeshObstacle =
{
    carveOnlyStationary: boolean,
    carving: boolean,
    carvingMoveThreshold: number,
    carvingTimeToStationary: number,
    center: Vector3,
    height: number,
    radius: number,
    size: Vector3,
    velocity: Vector3,
}

-- NavMeshObstacleType
type NavMeshObstacleType =
{
    __tostring: () -> string,
}

if not _G.NavMeshObstacle then
    local NavMeshObstacleType_instance : NavMeshObstacleType = {}
    _G.NavMeshObstacle = NavMeshObstacleType_instance;
end
