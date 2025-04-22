--!AddComponentMenu("")

-- EmoteAsset
type EmoteAsset =
{
}

-- EmoteAssetType
type EmoteAssetType =
{
}

if not _G.EmoteAsset then
    local EmoteAssetType_instance : EmoteAssetType = {}
    _G.EmoteAsset = EmoteAssetType_instance;
end
