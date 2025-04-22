--!AddComponentMenu("")

-- Focusable
type Focusable =
{
    canGrabFocus: boolean,
    delegatesFocus: boolean,
    focusable: boolean,
    tabIndex: number,
    Blur: () -> (),
    Focus: () -> (),
}

-- FocusableType
type FocusableType =
{
    __tostring: () -> string,
}

if not _G.Focusable then
    local FocusableType_instance : FocusableType = {}
    _G.Focusable = FocusableType_instance;
end
