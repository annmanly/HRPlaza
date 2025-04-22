--!AddComponentMenu("")

-- Repeat
type Repeat =
{
}

-- RepeatType
type RepeatType =
{
    NoRepeat: Repeat,
    Repeat: Repeat,
    Round: Repeat,
    Space: Repeat,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Repeat then
    local RepeatType_instance : RepeatType = {}
    _G.Repeat = RepeatType_instance;
end
