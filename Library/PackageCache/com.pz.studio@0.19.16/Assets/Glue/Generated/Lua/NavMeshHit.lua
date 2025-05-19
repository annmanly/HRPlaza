--!AddComponentMenu("")

-- NavMeshHit
type NavMeshHit =
{
    distance: number,
    hit: boolean,
    mask: number,
    normal: Vector3,
    position: Vector3,
}

-- NavMeshHitType
type NavMeshHitType =
{
    __tostring: () -> string,
}

if not _G.NavMeshHit then
    local NavMeshHitType_instance : NavMeshHitType = {}
    _G.NavMeshHit = NavMeshHitType_instance;
end
