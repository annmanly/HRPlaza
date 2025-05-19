--!AddComponentMenu("")

-- Asset
type Asset =
{
}

-- AssetType
type AssetType =
{
}

if not _G.Asset then
    local AssetType_instance : AssetType = {}
    _G.Asset = AssetType_instance;
end
