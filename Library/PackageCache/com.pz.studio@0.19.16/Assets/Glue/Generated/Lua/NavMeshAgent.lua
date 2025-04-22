--!AddComponentMenu("")

-- NavMeshAgent
type NavMeshAgent =
{
    desiredVelocity: Vector3,
    hasPath: boolean,
    isOnNavMesh: boolean,
    isOnOffMeshLink: boolean,
    isPathStale: boolean,
    navMeshOwner: Object,
    pathEndPosition: Vector3,
    pathPending: boolean,
    remainingDistance: number,
    steeringTarget: Vector3,
    acceleration: number,
    agentTypeID: number,
    angularSpeed: number,
    areaMask: number,
    autoBraking: boolean,
    autoRepath: boolean,
    autoTraverseOffMeshLink: boolean,
    avoidancePriority: number,
    baseOffset: number,
    destination: Vector3,
    height: number,
    isStopped: boolean,
    nextPosition: Vector3,
    radius: number,
    speed: number,
    stoppingDistance: number,
    updatePosition: boolean,
    updateRotation: boolean,
    updateUpAxis: boolean,
    velocity: Vector3,
    ActivateCurrentOffMeshLink: (activated: boolean) -> (),
    CompleteOffMeshLink: () -> (),
    FindClosestEdge: () -> (boolean , NavMeshHit),
    GetAreaCost: (areaIndex: number) -> number,
    Move: (offset: Vector3) -> (),
    Raycast: (targetPosition: Vector3) -> (boolean , NavMeshHit),
    ResetPath: () -> (),
    SamplePathPosition: (areaMask: number , maxDistance: number) -> (boolean , NavMeshHit),
    SetAreaCost: (areaIndex: number , areaCost: number) -> (),
    SetDestination: (target: Vector3) -> boolean,
    Warp: (newPosition: Vector3) -> boolean,
}

-- NavMeshAgentType
type NavMeshAgentType =
{
    __tostring: () -> string,
}

if not _G.NavMeshAgent then
    local NavMeshAgentType_instance : NavMeshAgentType = {}
    _G.NavMeshAgent = NavMeshAgentType_instance;
end
