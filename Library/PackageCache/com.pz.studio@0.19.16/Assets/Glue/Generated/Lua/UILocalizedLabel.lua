--!AddComponentMenu("")

-- UILocalizedLabel
type UILocalizedLabel =
{
    SetPluralText: (localizedString: LocalizedString , count: number , param2: string? , param3: string? , param4: string? , param5: string?) -> (),
    SetText: (localizedString: LocalizedString , param1: string? , param2: string? , param3: string? , param4: string? , param5: string?) -> (),
}

-- UILocalizedLabelType
type UILocalizedLabelType =
{
    new: () -> UILocalizedLabel,
    new: (localizedString: LocalizedString, param1: string?, param2: string?, param3: string?, param4: string?, param5: string?) -> UILocalizedLabel,
    __tostring: () -> string,
}

if not _G.UILocalizedLabel then
    local UILocalizedLabelType_instance : UILocalizedLabelType = {}
    _G.UILocalizedLabel = UILocalizedLabelType_instance;
end
