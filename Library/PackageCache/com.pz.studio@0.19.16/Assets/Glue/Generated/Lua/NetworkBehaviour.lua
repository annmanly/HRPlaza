--!AddComponentMenu("")

-- NetworkBehaviour
type NetworkBehaviour =
{
}

-- NetworkBehaviourType
type NetworkBehaviourType =
{
    __tostring: () -> string,
}

if not _G.NetworkBehaviour then
    local NetworkBehaviourType_instance : NetworkBehaviourType = {}
    _G.NetworkBehaviour = NetworkBehaviourType_instance;
end
