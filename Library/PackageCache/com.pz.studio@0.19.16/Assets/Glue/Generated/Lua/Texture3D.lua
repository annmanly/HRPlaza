--!AddComponentMenu("")

-- Texture3D
type Texture3D =
{
    depth: number,
    isReadable: boolean,
    Apply: () -> (),
    Apply: (updateMipmaps: boolean) -> (),
    Apply: (updateMipmaps: boolean , makeNoLongerReadable: boolean) -> (),
    GetPixel: (x: number , y: number , z: number) -> Color,
    GetPixel: (x: number , y: number , z: number , mipLevel: number) -> Color,
    GetPixelBilinear: (u: number , v: number , w: number) -> Color,
    GetPixelBilinear: (u: number , v: number , w: number , mipLevel: number) -> Color,
    GetPixels: () -> {Color},
    GetPixels: (miplevel: number) -> {Color},
    SetPixel: (x: number , y: number , z: number , color: Color) -> (),
    SetPixel: (x: number , y: number , z: number , color: Color , mipLevel: number) -> (),
}

-- Texture3DType
type Texture3DType =
{
    __tostring: () -> string,
}

if not _G.Texture3D then
    local Texture3DType_instance : Texture3DType = {}
    _G.Texture3D = Texture3DType_instance;
end
