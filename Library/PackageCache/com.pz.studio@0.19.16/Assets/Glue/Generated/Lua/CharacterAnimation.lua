--!AddComponentMenu("")

-- CharacterAnimation
type CharacterAnimation =
{
    back: AnimationClip,
    front: AnimationClip,
}

-- CharacterAnimationType
type CharacterAnimationType =
{
}

if not _G.CharacterAnimation then
    local CharacterAnimationType_instance : CharacterAnimationType = {}
    _G.CharacterAnimation = CharacterAnimationType_instance;
end
