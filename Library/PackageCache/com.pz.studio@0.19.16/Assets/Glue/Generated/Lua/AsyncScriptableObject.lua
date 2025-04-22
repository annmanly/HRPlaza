--!AddComponentMenu("")

-- AsyncScriptableObject
type AsyncScriptableObject =
{
}

-- AsyncScriptableObjectType
type AsyncScriptableObjectType =
{
}

if not _G.AsyncScriptableObject then
    local AsyncScriptableObjectType_instance : AsyncScriptableObjectType = {}
    _G.AsyncScriptableObject = AsyncScriptableObjectType_instance;
end
