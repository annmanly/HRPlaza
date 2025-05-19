--!AddComponentMenu("")

-- UIUserThumbnail
type UIUserThumbnail =
{
    showOnlineIndicator: boolean,
    Load: (player: Player) -> (),
    Load: (userId: string) -> (),
    Unload: () -> (),
}

-- UIUserThumbnailType
type UIUserThumbnailType =
{
    new: () -> UIUserThumbnail,
    __tostring: () -> string,
}

if not _G.UIUserThumbnail then
    local UIUserThumbnailType_instance : UIUserThumbnailType = {}
    _G.UIUserThumbnail = UIUserThumbnailType_instance;
end
