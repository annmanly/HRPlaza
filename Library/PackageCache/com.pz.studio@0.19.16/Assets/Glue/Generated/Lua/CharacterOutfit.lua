--!AddComponentMenu("")

-- CharacterOutfit
type CharacterOutfit =
{
    clothing: {CharacterClothing},
}

-- CharacterOutfitType
type CharacterOutfitType =
{
    CreateInstance: (clothing: {CharacterClothing}) -> CharacterOutfit,
    CreateInstance: (ids: {string}, skeletonId: string) -> CharacterOutfit,
}

if not _G.CharacterOutfit then
    local CharacterOutfitType_instance : CharacterOutfitType = {}
    _G.CharacterOutfit = CharacterOutfitType_instance;
end
