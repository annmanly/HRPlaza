--!AddComponentMenu("")

-- UILocalizedButton
type UILocalizedButton =
{
}

-- UILocalizedButtonType
type UILocalizedButtonType =
{
    new: () -> UILocalizedButton,
    new: (text: LocalizedString) -> UILocalizedButton,
    __tostring: () -> string,
}

if not _G.UILocalizedButton then
    local UILocalizedButtonType_instance : UILocalizedButtonType = {}
    _G.UILocalizedButton = UILocalizedButtonType_instance;
end
