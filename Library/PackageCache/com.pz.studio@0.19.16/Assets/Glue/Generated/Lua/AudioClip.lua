--!AddComponentMenu("")

-- AudioClip
type AudioClip =
{
    channels: number,
    frequency: number,
    length: number,
    loadInBackground: boolean,
    preloadAudioData: boolean,
    samples: number,
    LoadAudioData: () -> boolean,
    UnloadAudioData: () -> boolean,
}

-- AudioClipType
type AudioClipType =
{
    __tostring: () -> string,
}

if not _G.AudioClip then
    local AudioClipType_instance : AudioClipType = {}
    _G.AudioClip = AudioClipType_instance;
end
