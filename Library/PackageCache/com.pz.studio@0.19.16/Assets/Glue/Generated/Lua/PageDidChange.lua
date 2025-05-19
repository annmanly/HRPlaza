--!AddComponentMenu("")

-- PageDidChange
type PageDidChange =
{
    eventTypeId: number,
}

-- PageDidChangeType
type PageDidChangeType =
{
    __tostring: () -> string,
}

if not _G.PageDidChange then
    local PageDidChangeType_instance : PageDidChangeType = {}
    _G.PageDidChange = PageDidChangeType_instance;
end
