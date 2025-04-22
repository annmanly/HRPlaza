--!AddComponentMenu("")

-- UIImage
type UIImage =
{
    Dispose: () -> (),
    LoadFromCdnUrl: (url: string) -> (),
    LoadItemPreview: (category: string , id: string , clothingPaletteId: number?) -> (),
    ShowLoadingIndicator: (show: boolean) -> (),
}

-- UIImageType
type UIImageType =
{
    new: () -> UIImage,
    __tostring: () -> string,
}

if not _G.UIImage then
    local UIImageType_instance : UIImageType = {}
    _G.UIImage = UIImageType_instance;
end
