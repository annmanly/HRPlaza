--!AddComponentMenu("")

-- Audio
type Audio =
{
    isPlaying: boolean,
    musicIntensity: number,
    musicLength: number,
    musicTime: number,
    musicVolume: number,
    DuckMusic: (duration: number , duckOutDuration: number , duckInDuration: number) -> (),
    GetMusicIntensity: (low: number , high: number , normalizeVolume: boolean) -> number,
    PlayMusic: (shader: AudioShader , volume: number , fadeIn: boolean? , loop: boolean?) -> (),
    PlayMusicURL: (url: string , volume: number , fadeIn: boolean?) -> (),
    PlayShader: (shader: AudioShader) -> (),
    PlaySound: (shader: AudioShader , gameObject: GameObject , volume: number , pitch: number , spatialize: boolean , loop: boolean) -> AudioSource,
    PlaySoundGlobal: (shader: AudioShader , volume: number , pitch: number , loop: boolean) -> AudioSource,
    SetListenerPositionAndRotation: (position: Vector3 , rotation: Quaternion) -> (),
    StopAudioSource: (source: AudioSource) -> (),
    StopMusic: (fadeOut: boolean) -> (),
}

-- AudioType
type AudioType =
{
    __tostring: () -> string,
}

if not _G.Audio then
    local AudioType_instance : AudioType = {}
    _G.Audio = AudioType_instance;
end
