--!AddComponentMenu("")

-- UICollectionGridLayout
type UICollectionGridLayout =
{
    count: number,
    Dispose: () -> (),
    EnforceColumnCount: (count: number) -> (),
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

-- UICollectionGridLayoutType
type UICollectionGridLayoutType =
{
    new: (spacing: number?, columnCount: number?, fixedHeight: boolean?, centerContent: boolean?, cellAspectRatio: number?) -> UICollectionGridLayout,
    __tostring: () -> string,
}

if not _G.UICollectionGridLayout then
    local UICollectionGridLayoutType_instance : UICollectionGridLayoutType = {}
    _G.UICollectionGridLayout = UICollectionGridLayoutType_instance;
end
