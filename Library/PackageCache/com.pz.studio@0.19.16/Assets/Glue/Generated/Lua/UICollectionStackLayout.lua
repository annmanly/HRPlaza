--!AddComponentMenu("")

-- UICollectionStackLayout
type UICollectionStackLayout =
{
    count: number,
    estimatedItemSize: number,
    spacing: number,
    Dispose: () -> (),
    GetCellOffset: (index: number) -> number,
    GetVisibleCell: (index: number) -> UIView,
    Insert: (index: number , count: number) -> (),
    Rebuild: () -> (),
    RecycleAllItems: () -> (),
    Remove: (index: number , count: number) -> (),
    RemoveAll: () -> (),
    Update: (min: number , max: number) -> number,
    UpdateSize: (index: number , count: number) -> (),
}

-- UICollectionStackLayoutType
type UICollectionStackLayoutType =
{
    new: (estimatedItemSize: number?, spacing: number?, windowInset: number?) -> UICollectionStackLayout,
    __tostring: () -> string,
}

if not _G.UICollectionStackLayout then
    local UICollectionStackLayoutType_instance : UICollectionStackLayoutType = {}
    _G.UICollectionStackLayout = UICollectionStackLayoutType_instance;
end
