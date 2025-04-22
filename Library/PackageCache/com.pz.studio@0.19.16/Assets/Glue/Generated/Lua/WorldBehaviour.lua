--!AddComponentMenu("")

-- WorldBehaviour
type WorldBehaviour =
{
    scene: Scene,
}

-- WorldBehaviourType
type WorldBehaviourType =
{
    __tostring: () -> string,
}

if not _G.WorldBehaviour then
    local WorldBehaviourType_instance : WorldBehaviourType = {}
    _G.WorldBehaviour = WorldBehaviourType_instance;
end
