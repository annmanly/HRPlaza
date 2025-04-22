--!AddComponentMenu("")

-- IPanel
type IPanel =
{
    isDirty: boolean,
    visualTree: VisualElement,
    GetScaledDisplayHeight: () -> number,
    GetScaledDisplayWidth: () -> number,
    LocalToWorld: (point: Vector2) -> Vector2,
    Pick: (point: Vector2) -> VisualElement,
    PickAll: (point: Vector2 , picked: {VisualElement}) -> VisualElement,
    WorldToLocal: (point: Vector2) -> Vector2,
}

-- IPanelType
type IPanelType =
{
}

if not _G.IPanel then
    local IPanelType_instance : IPanelType = {}
    _G.IPanel = IPanelType_instance;
end
