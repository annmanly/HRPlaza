--!AddComponentMenu("")

-- OffMeshLinkHandler
type OffMeshLinkHandler =
{
    heightMultiplier: number,
    speedMultiplier: number,
}

-- OffMeshLinkHandlerType
type OffMeshLinkHandlerType =
{
    __tostring: () -> string,
}

if not _G.OffMeshLinkHandler then
    local OffMeshLinkHandlerType_instance : OffMeshLinkHandlerType = {}
    _G.OffMeshLinkHandler = OffMeshLinkHandlerType_instance;
end
