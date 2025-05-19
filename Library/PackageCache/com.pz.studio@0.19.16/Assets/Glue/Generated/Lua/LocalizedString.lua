--!AddComponentMenu("")

-- LocalizedString
type LocalizedString =
{
    index: number,
    Format: (param1: string? , param2: string? , param3: string? , param4: string? , param5: string?) -> string,
    FormatPlural: (count: number , param2: string? , param3: string? , param4: string? , param5: string?) -> string,
}

-- LocalizedStringType
type LocalizedStringType =
{
    none: LocalizedString,
    __tostring: () -> string,
}

if not _G.LocalizedString then
    local LocalizedStringType_instance : LocalizedStringType = {}
    _G.LocalizedString = LocalizedStringType_instance;
end
