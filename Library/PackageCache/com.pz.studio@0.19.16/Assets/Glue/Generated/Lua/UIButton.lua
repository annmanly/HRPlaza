--!AddComponentMenu("")

-- UIButton
type UIButton =
{
    contentContainer: VisualElement,
}

-- UIButtonType
type UIButtonType =
{
    new: () -> UIButton,
    __tostring: () -> string,
}

if not _G.UIButton then
    local UIButtonType_instance : UIButtonType = {}
    _G.UIButton = UIButtonType_instance;
end
