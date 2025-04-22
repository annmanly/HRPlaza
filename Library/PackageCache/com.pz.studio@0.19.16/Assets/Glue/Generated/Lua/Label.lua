--!AddComponentMenu("")

-- Label
type Label =
{
}

-- LabelType
type LabelType =
{
    ussClassName: string,
    new: () -> Label,
    new: (text: string) -> Label,
    __tostring: () -> string,
}

if not _G.Label then
    local LabelType_instance : LabelType = {}
    _G.Label = LabelType_instance;
end
