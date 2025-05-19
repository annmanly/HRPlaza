--!AddComponentMenu("")

-- ClothingCollection
type ClothingCollection =
{
    clothing: {CharacterClothing},
}

-- ClothingCollectionType
type ClothingCollectionType =
{
}

if not _G.ClothingCollection then
    local ClothingCollectionType_instance : ClothingCollectionType = {}
    _G.ClothingCollection = ClothingCollectionType_instance;
end
