--!AddComponentMenu("")

-- UILocalizedOutlinedLabel
type UILocalizedOutlinedLabel =
{
    SetPluralText: (localizedString: LocalizedString , count: number , param2: string? , param3: string? , param4: string? , param5: string?) -> (),
    SetText: (localizedString: LocalizedString , param1: string? , param2: string? , param3: string? , param4: string? , param5: string?) -> (),
}

-- UILocalizedOutlinedLabelType
type UILocalizedOutlinedLabelType =
{
    new: () -> UILocalizedOutlinedLabel,
    new: (localizedString: LocalizedString, param1: string?, param2: string?, param3: string?, param4: string?, param5: string?) -> UILocalizedOutlinedLabel,
    __tostring: () -> string,
}

if not _G.UILocalizedOutlinedLabel then
    local UILocalizedOutlinedLabelType_instance : UILocalizedOutlinedLabelType = {}
    _G.UILocalizedOutlinedLabel = UILocalizedOutlinedLabelType_instance;
end
