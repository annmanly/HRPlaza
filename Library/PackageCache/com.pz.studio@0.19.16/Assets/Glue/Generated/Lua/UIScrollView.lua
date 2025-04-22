--!AddComponentMenu("")

-- UIScrollView
type UIScrollView =
{
    contentContainer: VisualElement,
    contentSize: number,
    contentViewport: VisualElement,
    hasInertia: boolean,
    isAtEnd: boolean,
    isScrolling: boolean,
    scrollableSize: number,
    viewportSize: number,
    worldBound: Rect,
    isInertiaEnabled: boolean,
    onScrollEnd: () -> (),
    value: number,
    AdjustScrollOffset: (delta: number) -> (),
    AdjustScrollOffsetForNewContent: () -> (),
    CancelAnimation: () -> (),
    Dispose: () -> (),
    ScrollTo: (child: VisualElement) -> (),
    ScrollToBeginning: (animationDuration: number?) -> (),
    ScrollToElement: (element: VisualElement , animationDuration: number?) -> (),
    ScrollToEnd: (animationDuration: number?) -> (),
    ScrollToOffset: (offset: number , animationDuration: number? , propagateAnimation: boolean?) -> (),
    SetValueWithoutNotify: (newValue: number) -> (),
}

-- UIScrollViewType
type UIScrollViewType =
{
    defaultScrollDecelerationRate: number,
    fastScrollDecelerationRate: number,
    minInertiaVelocity: number,
    ussScrollView: string,
    ussScrollViewContent: string,
    ussScrollViewFadeEdges: string,
    ussScrollViewGradients: string,
    ussScrollViewGradientsBottom: string,
    ussScrollViewGradientsTop: string,
    ussScrollViewHorizontal: string,
    ussScrollViewVertical: string,
    ussScrollViewViewport: string,
    isClamped: boolean,
    isElastic: boolean,
    scrollDecelerationRate: number,
    scrollWheelRate: number,
    new: () -> UIScrollView,
    __tostring: () -> string,
}

if not _G.UIScrollView then
    local UIScrollViewType_instance : UIScrollViewType = {}
    _G.UIScrollView = UIScrollViewType_instance;
end
