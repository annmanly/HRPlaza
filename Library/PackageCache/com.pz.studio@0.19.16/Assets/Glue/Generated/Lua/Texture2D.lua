--!AddComponentMenu("")

-- Texture2D
type Texture2D =
{
    activeMipmapLimit: number,
    calculatedMipmapLevel: number,
    desiredMipmapLevel: number,
    isReadable: boolean,
    loadedMipmapLevel: number,
    loadingMipmapLevel: number,
    mipmapLimitGroup: string,
    streamingMipmaps: boolean,
    streamingMipmapsPriority: number,
    vtOnly: boolean,
    ignoreMipmapLimit: boolean,
    minimumMipmapLevel: number,
    requestedMipmapLevel: number,
    Apply: () -> (),
    Apply: (updateMipmaps: boolean) -> (),
    Apply: (updateMipmaps: boolean , makeNoLongerReadable: boolean) -> (),
    ClearMinimumMipmapLevel: () -> (),
    ClearRequestedMipmapLevel: () -> (),
    Compress: (highQuality: boolean) -> (),
    GetPixel: (x: number , y: number) -> Color,
    GetPixel: (x: number , y: number , mipLevel: number) -> Color,
    GetPixelBilinear: (u: number , v: number) -> Color,
    GetPixelBilinear: (u: number , v: number , mipLevel: number) -> Color,
    GetPixels: () -> {Color},
    GetPixels: (miplevel: number) -> {Color},
    GetPixels: (x: number , y: number , blockWidth: number , blockHeight: number) -> {Color},
    GetPixels: (x: number , y: number , blockWidth: number , blockHeight: number , miplevel: number) -> {Color},
    IsRequestedMipmapLevelLoaded: () -> boolean,
    ReadPixels: (source: Rect , destX: number , destY: number) -> (),
    ReadPixels: (source: Rect , destX: number , destY: number , recalculateMipMaps: boolean) -> (),
    Reinitialize: (width: number , height: number) -> boolean,
    SetPixel: (x: number , y: number , color: Color) -> (),
    SetPixel: (x: number , y: number , color: Color , mipLevel: number) -> (),
}

-- Texture2DType
type Texture2DType =
{
    blackTexture: Texture2D,
    grayTexture: Texture2D,
    linearGrayTexture: Texture2D,
    normalTexture: Texture2D,
    redTexture: Texture2D,
    whiteTexture: Texture2D,
    new: (width: number, height: number) -> Texture2D,
    __tostring: () -> string,
}

if not _G.Texture2D then
    local Texture2DType_instance : Texture2DType = {}
    _G.Texture2D = Texture2DType_instance;
end
