--!AddComponentMenu("")

-- UICollectionCells
type UICollectionCells =
{
    cellCount: number,
    collection: UICollection,
    hasLayout: boolean,
    section: UICollectionSection,
    selection: {number},
    selectionCount: number,
    visibleCells: {UIView},
    loading: boolean,
    provider: UICollectionProvider,
    AddCell: () -> (),
    AddCells: (count: number) -> (),
    Deselect: (cell: UIView) -> (),
    Deselect: (cellIndex: number) -> (),
    DeselectAll: () -> (),
    Dispose: () -> (),
    EnumerateVisibleCells: (enumerate: (UIView, number, boolean) -> (boolean)) -> (),
    GetVisibleCell: (cellIndex: number) -> UIView,
    IndexOf: (cell: UIView) -> number,
    InsertCell: (index: number) -> (),
    InsertCells: (index: number , count: number) -> (),
    InstantiateCell: (cellIndex: number) -> UIView,
    IsSelected: (cell: UIView) -> boolean,
    IsSelected: (cellIndex: number) -> boolean,
    ItemSizeChanged: (itemIndex: number , itemPosition: number , delta: number) -> (),
    RecycleAllCells: () -> (),
    RecycleCell: (index: number , cell: UIView) -> (),
    RemoveAllCells: () -> (),
    RemoveCell: (index: number) -> (),
    RemoveCells: (index: number , count: number) -> (),
    ScrollTo: (cellIndex: number , additionalOffset: number?) -> (),
    Select: (cell: UIView , add: boolean?) -> (),
    Select: (cellIndex: number , add: boolean?) -> (),
    SelectionIndexOf: (cellIndex: number) -> number,
    SetLayout: (layout: UICollectionGridLayout) -> (),
    SetLayout: (layout: UICollectionStackLayout) -> (),
    Toggle: (cell: UIView , add: boolean?) -> (),
    Toggle: (cellIndex: number , add: boolean?) -> (),
    UpdateCell: (index: number) -> (),
    UpdateCells: (index: number , count: number) -> (),
    UpdateLayout: (min: number , max: number) -> number,
}

-- UICollectionCellsType
type UICollectionCellsType =
{
    new: () -> UICollectionCells,
    __tostring: () -> string,
}

if not _G.UICollectionCells then
    local UICollectionCellsType_instance : UICollectionCellsType = {}
    _G.UICollectionCells = UICollectionCellsType_instance;
end
