--!AddComponentMenu("")

-- PageReset
type PageReset =
{
    page: number,
    eventTypeId: number,
}

-- PageResetType
type PageResetType =
{
    __tostring: () -> string,
}

if not _G.PageReset then
    local PageResetType_instance : PageResetType = {}
    _G.PageReset = PageResetType_instance;
end
