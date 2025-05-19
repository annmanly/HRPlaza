--!AddComponentMenu("")

-- StudioRoomManager
type StudioRoomManager =
{
}

-- StudioRoomManagerType
type StudioRoomManagerType =
{
    Load: (room: RoomAsset, roomWasLoaded: () -> ()?) -> (),
}

if not _G.StudioRoomManager then
    local StudioRoomManagerType_instance : StudioRoomManagerType = {}
    _G.StudioRoomManager = StudioRoomManagerType_instance;
end
