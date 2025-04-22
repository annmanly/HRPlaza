--!AddComponentMenu("")

-- AudioShader
type AudioShader =
{
    clips: {AudioClip},
    pitch: number,
    randomPitch: number,
    randomVolume: number,
    volume: number,
    spatialRange: number,
    isMuted: boolean,
    GetRandomClip: () -> AudioClip,
    Play: () -> (),
    PlayWithVolume: (v: number) -> (),
    PlayWithVolumeAndPitch: (volume: number , pitch: number) -> (),
}

-- AudioShaderType
type AudioShaderType =
{
    new: (clip: AudioClip) -> AudioShader,
    __tostring: () -> string,
}

if not _G.AudioShader then
    local AudioShaderType_instance : AudioShaderType = {}
    _G.AudioShader = AudioShaderType_instance;
end
