--!AddComponentMenu("")

-- ScriptableObject
type ScriptableObject =
{
}

-- ScriptableObjectType
type ScriptableObjectType =
{
    CreateInstance: (type: Type) -> ScriptableObject,
    CreateInstance: (className: string) -> ScriptableObject,
    __tostring: () -> string,
}

if not _G.ScriptableObject then
    local ScriptableObjectType_instance : ScriptableObjectType = {}
    _G.ScriptableObject = ScriptableObjectType_instance;
end
