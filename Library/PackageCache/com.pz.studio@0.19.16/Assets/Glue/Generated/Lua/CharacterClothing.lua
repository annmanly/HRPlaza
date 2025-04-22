--!AddComponentMenu("")

-- CharacterClothing
type CharacterClothing =
{
    id: string,
    color: number,
}

-- CharacterClothingType
type CharacterClothingType =
{
    new: (descriptorId: string, paletteId: number?) -> CharacterClothing,
}

if not _G.CharacterClothing then
    local CharacterClothingType_instance : CharacterClothingType = {}
    _G.CharacterClothing = CharacterClothingType_instance;
end
