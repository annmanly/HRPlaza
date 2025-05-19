--!AddComponentMenu("")

-- MonoBehaviour
type MonoBehaviour =
{
}

-- MonoBehaviourType
type MonoBehaviourType =
{
    __tostring: () -> string,
}

if not _G.MonoBehaviour then
    local MonoBehaviourType_instance : MonoBehaviourType = {}
    _G.MonoBehaviour = MonoBehaviourType_instance;
end
