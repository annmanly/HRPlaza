--!AddComponentMenu("")

-- AudioSource
type AudioSource =
{
    isPlaying: boolean,
    isVirtual: boolean,
    bypassEffects: boolean,
    bypassListenerEffects: boolean,
    bypassReverbZones: boolean,
    clip: AudioClip,
    dopplerLevel: number,
    ignoreListenerPause: boolean,
    ignoreListenerVolume: boolean,
    loop: boolean,
    maxDistance: number,
    minDistance: number,
    mute: boolean,
    panStereo: number,
    pitch: number,
    playOnAwake: boolean,
    priority: number,
    reverbZoneMix: number,
    spatialBlend: number,
    spatialize: boolean,
    spatializePostEffects: boolean,
    spread: number,
    time: number,
    timeSamples: number,
    volume: number,
    GetSpatializerFloat: (index: number) -> (boolean , number),
    Pause: () -> (),
    Play: () -> (),
    Play: (delay: number) -> (),
    PlayDelayed: (delay: number) -> (),
    PlayOneShot: (clip: AudioClip) -> (),
    PlayOneShot: (clip: AudioClip , volumeScale: number) -> (),
    PlayScheduled: (time: number) -> (),
    SetScheduledEndTime: (time: number) -> (),
    SetScheduledStartTime: (time: number) -> (),
    SetSpatializerFloat: (index: number , value: number) -> boolean,
    Stop: () -> (),
    UnPause: () -> (),
}

-- AudioSourceType
type AudioSourceType =
{
    PlayClipAtPoint: (clip: AudioClip, position: Vector3) -> (),
    PlayClipAtPoint: (clip: AudioClip, position: Vector3, volume: number) -> (),
    __tostring: () -> string,
}

if not _G.AudioSource then
    local AudioSourceType_instance : AudioSourceType = {}
    _G.AudioSource = AudioSourceType_instance;
end
