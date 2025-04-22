--!AddComponentMenu("")

-- CustomStyleResolvedEvent
type CustomStyleResolvedEvent =
{
    customStyle: ICustomStyle,
    eventTypeId: number,
}

-- CustomStyleResolvedEventType
type CustomStyleResolvedEventType =
{
    __tostring: () -> string,
}

if not _G.CustomStyleResolvedEvent then
    local CustomStyleResolvedEventType_instance : CustomStyleResolvedEventType = {}
    _G.CustomStyleResolvedEvent = CustomStyleResolvedEventType_instance;
end
