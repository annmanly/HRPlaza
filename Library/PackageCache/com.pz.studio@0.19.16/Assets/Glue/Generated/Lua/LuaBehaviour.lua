--!AddComponentMenu("")

-- LuaBehaviour
type LuaBehaviour =
{
}

-- LuaBehaviourType
type LuaBehaviourType =
{
}

if not _G.LuaBehaviour then
    local LuaBehaviourType_instance : LuaBehaviourType = {}
    _G.LuaBehaviour = LuaBehaviourType_instance;
end
