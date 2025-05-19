--!AddComponentMenu("")

-- RoomAsset
type RoomAsset =
{
}

-- RoomAssetType
type RoomAssetType =
{
    new: () -> RoomAsset,
    __tostring: () -> string,
}

if not _G.RoomAsset then
    local RoomAssetType_instance : RoomAssetType = {}
    _G.RoomAsset = RoomAssetType_instance;
end
