--!AddComponentMenu("")

-- Renderer
type Renderer =
{
    isPartOfStaticBatch: boolean,
    isVisible: boolean,
    localToWorldMatrix: Matrix4x4,
    worldToLocalMatrix: Matrix4x4,
    allowOcclusionWhenDynamic: boolean,
    bounds: Bounds,
    enabled: boolean,
    forceRenderingOff: boolean,
    lightProbeProxyVolumeOverride: GameObject,
    lightmapIndex: number,
    lightmapScaleOffset: Vector4,
    localBounds: Bounds,
    material: Material,
    materials: {Material},
    probeAnchor: Transform,
    realtimeLightmapIndex: number,
    realtimeLightmapScaleOffset: Vector4,
    receiveShadows: boolean,
    rendererPriority: number,
    renderingLayerMask: number,
    sharedMaterial: Material,
    sharedMaterials: {Material},
    sortingLayerID: number,
    sortingLayerName: string,
    sortingOrder: number,
    staticShadowCaster: boolean,
    HasPropertyBlock: () -> boolean,
    ResetBounds: () -> (),
    ResetLocalBounds: () -> (),
    SetMaterials: (materials: {Material}) -> (),
    SetPropertyBlock: (properties: MaterialPropertyBlock) -> (),
    SetPropertyBlock: (properties: MaterialPropertyBlock , materialIndex: number) -> (),
    SetSharedMaterials: (materials: {Material}) -> (),
}

-- RendererType
type RendererType =
{
    __tostring: () -> string,
}

if not _G.Renderer then
    local RendererType_instance : RendererType = {}
    _G.Renderer = RendererType_instance;
end
