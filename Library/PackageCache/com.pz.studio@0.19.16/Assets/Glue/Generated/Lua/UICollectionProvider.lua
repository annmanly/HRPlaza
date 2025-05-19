--!AddComponentMenu("")

-- UICollectionProvider
type UICollectionProvider =
{
    cells: UICollectionCells,
    BindCell: (cell: UIView , index: number) -> (),
    CellForIndex: (index: number) -> UIView,
    Dispose: () -> (),
    EstimatedSizeForIndex: (index: number) -> number,
    TypeForIndex: (index: number) -> number,
}

-- UICollectionProviderType
type UICollectionProviderType =
{
    __tostring: () -> string,
}

if not _G.UICollectionProvider then
    local UICollectionProviderType_instance : UICollectionProviderType = {}
    _G.UICollectionProvider = UICollectionProviderType_instance;
end
