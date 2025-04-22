--!AddComponentMenu("")

-- UICollection
type UICollection =
{
    contentContainer: VisualElement,
    isPerformingUpdates: boolean,
    isReversed: boolean,
    scrollView: IScrollView,
    recycleOnHide: boolean,
    InitializeSections: () -> (),
    PerformUpdates: (updates: () -> ()) -> (),
    Rebuild: () -> (),
    ScrollTo: (cells: UICollectionCells , cellIndex: number , padding: number?) -> (),
    ScrollToBeginning: () -> (),
    ScrollToBeginning: (animationDuration: number) -> (),
    ScrollToEnd: () -> (),
}

-- UICollectionType
type UICollectionType =
{
    new: () -> UICollection,
    new: (scrollView: IScrollView) -> UICollection,
    __tostring: () -> string,
}

if not _G.UICollection then
    local UICollectionType_instance : UICollectionType = {}
    _G.UICollection = UICollectionType_instance;
end
