--!AddComponentMenu("")

-- Localization
type Localization =
{
}

-- LocalizationType
type LocalizationType =
{
    TryGetString: (key: string) -> (boolean , LocalizedString),
    __tostring: () -> string,
}

if not _G.Localization then
    local LocalizationType_instance : LocalizationType = {}
    _G.Localization = LocalizationType_instance;
end
