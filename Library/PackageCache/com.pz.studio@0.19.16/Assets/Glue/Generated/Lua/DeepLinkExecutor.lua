--!AddComponentMenu("")

-- DeepLinkExecutor
type DeepLinkExecutor =
{
}

-- DeepLinkExecutorType
type DeepLinkExecutorType =
{
    __tostring: () -> string,
}

if not _G.DeepLinkExecutor then
    local DeepLinkExecutorType_instance : DeepLinkExecutorType = {}
    _G.DeepLinkExecutor = DeepLinkExecutorType_instance;
end
