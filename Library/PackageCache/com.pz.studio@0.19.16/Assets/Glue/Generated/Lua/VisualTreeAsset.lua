--!AddComponentMenu("")

-- VisualTreeAsset
type VisualTreeAsset =
{
    importedWithErrors: boolean,
    importedWithWarnings: boolean,
    templateDependencies: {VisualTreeAsset},
    contentHash: number,
    CloneTree: (target: VisualElement) -> (),
}

-- VisualTreeAssetType
type VisualTreeAssetType =
{
    __tostring: () -> string,
}

if not _G.VisualTreeAsset then
    local VisualTreeAssetType_instance : VisualTreeAssetType = {}
    _G.VisualTreeAsset = VisualTreeAssetType_instance;
end
