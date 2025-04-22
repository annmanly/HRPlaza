--!AddComponentMenu("")

-- AudioBehaviour
type AudioBehaviour =
{
}

-- AudioBehaviourType
type AudioBehaviourType =
{
    __tostring: () -> string,
}

if not _G.AudioBehaviour then
    local AudioBehaviourType_instance : AudioBehaviourType = {}
    _G.AudioBehaviour = AudioBehaviourType_instance;
end
