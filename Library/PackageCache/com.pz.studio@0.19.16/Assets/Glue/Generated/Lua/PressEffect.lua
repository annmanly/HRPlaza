--!AddComponentMenu("")

-- PressEffect
type PressEffect =
{
}

-- PressEffectType
type PressEffectType =
{
    Highlight: PressEffect,
    NONE: PressEffect,
    Press: PressEffect,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.PressEffect then
    local PressEffectType_instance : PressEffectType = {}
    _G.PressEffect = PressEffectType_instance;
end
