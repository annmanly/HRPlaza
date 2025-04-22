--!AddComponentMenu("")

-- TextAsset
type TextAsset =
{
    bytes: {Byte},
    dataSize: number,
    text: string,
}

-- TextAssetType
type TextAssetType =
{
    __tostring: () -> string,
}

if not _G.TextAsset then
    local TextAssetType_instance : TextAssetType = {}
    _G.TextAsset = TextAssetType_instance;
end
