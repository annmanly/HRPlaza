--!AddComponentMenu("")

-- Enum
type Enum =
{
    HasFlag: (flag: Enum) -> boolean,
}

-- EnumType
type EnumType =
{
    GetNames: (enumType: Type) -> {string},
    GetUnderlyingType: (enumType: Type) -> Type,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Enum then
    local EnumType_instance : EnumType = {}
    _G.Enum = EnumType_instance;
end
