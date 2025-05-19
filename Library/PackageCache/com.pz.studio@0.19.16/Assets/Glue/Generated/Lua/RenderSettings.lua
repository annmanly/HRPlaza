--!AddComponentMenu("")

-- RenderSettings
type RenderSettings =
{
    ambientEquatorColor: Color,
    ambientGroundColor: Color,
    ambientIntensity: number,
    ambientLight: Color,
    ambientSkyColor: Color,
    defaultReflectionResolution: number,
    flareFadeSpeed: number,
    flareStrength: number,
    fog: boolean,
    fogColor: Color,
    fogDensity: number,
    fogEndDistance: number,
    fogStartDistance: number,
    haloStrength: number,
    reflectionBounces: number,
    reflectionIntensity: number,
    skybox: Material,
    subtractiveShadowColor: Color,
}

-- RenderSettingsType
type RenderSettingsType =
{
    __tostring: () -> string,
}

if not _G.RenderSettings then
    local RenderSettingsType_instance : RenderSettingsType = {}
    _G.RenderSettings = RenderSettingsType_instance;
end
