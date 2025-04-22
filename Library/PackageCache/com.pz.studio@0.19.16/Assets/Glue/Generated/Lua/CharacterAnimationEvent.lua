--!AddComponentMenu("")

-- CharacterAnimationEvent
type CharacterAnimationEvent =
{
    functionName: string,
    name: string,
}

-- CharacterAnimationEventType
type CharacterAnimationEventType =
{
}

if not _G.CharacterAnimationEvent then
    local CharacterAnimationEventType_instance : CharacterAnimationEventType = {}
    _G.CharacterAnimationEvent = CharacterAnimationEventType_instance;
end
