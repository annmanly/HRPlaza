--!AddComponentMenu("")

-- AudioListener
type AudioListener =
{
}

-- AudioListenerType
type AudioListenerType =
{
    __tostring: () -> string,
}

if not _G.AudioListener then
    local AudioListenerType_instance : AudioListenerType = {}
    _G.AudioListener = AudioListenerType_instance;
end
