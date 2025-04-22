--!AddComponentMenu("")

-- PageChanged
type PageChanged =
{
    newPage: number,
    oldPage: number,
    eventTypeId: number,
}

-- PageChangedType
type PageChangedType =
{
    __tostring: () -> string,
}

if not _G.PageChanged then
    local PageChangedType_instance : PageChangedType = {}
    _G.PageChanged = PageChangedType_instance;
end
