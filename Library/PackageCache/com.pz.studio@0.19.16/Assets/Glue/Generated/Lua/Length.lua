--!AddComponentMenu("")

-- Length
type Length =
{
    value: number,
    Equals: (other: Length) -> boolean,
    IsAuto: () -> boolean,
    IsNone: () -> boolean,
}

-- LengthType
type LengthType =
{
    new: (value: number) -> Length,
    Auto: () -> Length,
    None: () -> Length,
    Percent: (value: number) -> Length,
    __eq: (lhs: Length, rhs: Length) -> boolean,
    __tostring: () -> string,
}

if not _G.Length then
    local LengthType_instance : LengthType = {}
    _G.Length = LengthType_instance;
end
