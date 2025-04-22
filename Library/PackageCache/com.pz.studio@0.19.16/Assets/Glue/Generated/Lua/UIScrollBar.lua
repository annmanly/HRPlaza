--!AddComponentMenu("")

-- UIScrollBar
type UIScrollBar =
{
    isReversed: boolean,
    max: number,
    min: number,
    value: number,
    SetValueWithoutNotify: (newValue: number) -> (),
}

-- UIScrollBarType
type UIScrollBarType =
{
    new: () -> UIScrollBar,
    __tostring: () -> string,
}

if not _G.UIScrollBar then
    local UIScrollBarType_instance : UIScrollBarType = {}
    _G.UIScrollBar = UIScrollBarType_instance;
end
