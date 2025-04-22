--!AddComponentMenu("")

-- BackgroundRepeat
type BackgroundRepeat =
{
    x: Repeat,
    y: Repeat,
    Equals: (other: BackgroundRepeat) -> boolean,
}

-- BackgroundRepeatType
type BackgroundRepeatType =
{
    new: (repeatX: Repeat, repeatY: Repeat) -> BackgroundRepeat,
    __eq: (style1: BackgroundRepeat, style2: BackgroundRepeat) -> boolean,
    __tostring: () -> string,
}

if not _G.BackgroundRepeat then
    local BackgroundRepeatType_instance : BackgroundRepeatType = {}
    _G.BackgroundRepeat = BackgroundRepeatType_instance;
end
