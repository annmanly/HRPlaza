--!AddComponentMenu("")

-- WhiteSpace
type WhiteSpace =
{
}

-- WhiteSpaceType
type WhiteSpaceType =
{
    NoWrap: WhiteSpace,
    Normal: WhiteSpace,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.WhiteSpace then
    local WhiteSpaceType_instance : WhiteSpaceType = {}
    _G.WhiteSpace = WhiteSpaceType_instance;
end
