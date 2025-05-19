--!AddComponentMenu("")

-- UICollectionDelegateProvider
type UICollectionDelegateProvider =
{
    BindCell: (cell: UIView , index: number) -> (),
    CellForIndex: (index: number) -> UIView,
    Dispose: () -> (),
}

-- UICollectionDelegateProviderType
type UICollectionDelegateProviderType =
{
    new: (cellFromIndex: (number) -> (UIView), bindCell: (UIView, number) -> ()?) -> UICollectionDelegateProvider,
    __tostring: () -> string,
}

if not _G.UICollectionDelegateProvider then
    local UICollectionDelegateProviderType_instance : UICollectionDelegateProviderType = {}
    _G.UICollectionDelegateProvider = UICollectionDelegateProviderType_instance;
end
