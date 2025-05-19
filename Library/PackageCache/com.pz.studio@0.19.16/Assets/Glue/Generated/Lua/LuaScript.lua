--!AddComponentMenu("")

-- LuaScript
type LuaScript =
{
    fullName: string,
    namespace: string,
    propertyCount: number,
    runsOnClient: boolean,
    runsOnClientAndServer: boolean,
    runsOnServer: boolean,
    typeCode: number,
}

-- LuaScriptType
type LuaScriptType =
{
    __tostring: () -> string,
}

if not _G.LuaScript then
    local LuaScriptType_instance : LuaScriptType = {}
    _G.LuaScript = LuaScriptType_instance;
end
