--!AddComponentMenu("")

-- Behaviour
type Behaviour =
{
    isActiveAndEnabled: boolean,
    enabled: boolean,
}

-- BehaviourType
type BehaviourType =
{
    __tostring: () -> string,
}

if not _G.Behaviour then
    local BehaviourType_instance : BehaviourType = {}
    _G.Behaviour = BehaviourType_instance;
end
