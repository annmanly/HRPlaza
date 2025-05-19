--!AddComponentMenu("")

-- LayerMask
type LayerMask =
{
    value: number,
}

-- LayerMaskType
type LayerMaskType =
{
    GetMask: (layerNames: {string}) -> number,
    LayerToName: (layer: number) -> string,
    NameToLayer: (layerName: string) -> number,
    __tostring: () -> string,
}

if not _G.LayerMask then
    local LayerMaskType_instance : LayerMaskType = {}
    _G.LayerMask = LayerMaskType_instance;
end
