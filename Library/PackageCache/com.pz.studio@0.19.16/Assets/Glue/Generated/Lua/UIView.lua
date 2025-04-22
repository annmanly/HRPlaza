--!AddComponentMenu("")

-- UIView
type UIView =
{
    isDisplayed: boolean,
    Dispose: () -> (),
    RegisterBackCallback: (handler: () -> (boolean)) -> (),
    Reset: () -> (),
    UnregisterBackCallback: () -> (),
}

-- UIViewType
type UIViewType =
{
    displayBegin: (UIView) -> (),
    displayEnd: (UIView) -> (),
    new: () -> UIView,
    BindHierarchy: (element: VisualElement) -> (),
    ClearAndDisposeChildren: (element: VisualElement) -> (),
    DisposeChildren: (element: VisualElement) -> (),
    __tostring: () -> string,
}

if not _G.UIView then
    local UIViewType_instance : UIViewType = {}
    _G.UIView = UIViewType_instance;
end
