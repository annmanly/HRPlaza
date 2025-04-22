--!AddComponentMenu("")

-- UICollectionSection
type UICollectionSection =
{
    cells: UICollectionCells,
    collection: UICollection,
    Rebuild: () -> (),
    UpdateLayout: (min: number , max: number) -> number,
}

-- UICollectionSectionType
type UICollectionSectionType =
{
    new: () -> UICollectionSection,
    new: (cells: UICollectionCells) -> UICollectionSection,
    __tostring: () -> string,
}

if not _G.UICollectionSection then
    local UICollectionSectionType_instance : UICollectionSectionType = {}
    _G.UICollectionSection = UICollectionSectionType_instance;
end
