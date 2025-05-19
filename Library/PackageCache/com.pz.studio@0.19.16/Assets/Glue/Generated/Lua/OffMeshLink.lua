--!AddComponentMenu("")

-- OffMeshLink
type OffMeshLink =
{
    occupied: boolean,
    activated: boolean,
    area: number,
    autoUpdatePositions: boolean,
    biDirectional: boolean,
    costOverride: number,
    endTransform: Transform,
    startTransform: Transform,
    UpdatePositions: () -> (),
}

-- OffMeshLinkType
type OffMeshLinkType =
{
    __tostring: () -> string,
}

if not _G.OffMeshLink then
    local OffMeshLinkType_instance : OffMeshLinkType = {}
    _G.OffMeshLink = OffMeshLinkType_instance;
end
