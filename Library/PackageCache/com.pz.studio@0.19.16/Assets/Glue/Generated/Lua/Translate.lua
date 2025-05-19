--!AddComponentMenu("")

-- Translate
type Translate =
{
    x: Length,
    y: Length,
    z: number,
    Equals: (other: Translate) -> boolean,
}

-- TranslateType
type TranslateType =
{
    new: (x: Length, y: Length) -> Translate,
    new: (x: Length, y: Length, z: number) -> Translate,
    None: () -> Translate,
    __eq: (lhs: Translate, rhs: Translate) -> boolean,
    __tostring: () -> string,
}

if not _G.Translate then
    local TranslateType_instance : TranslateType = {}
    _G.Translate = TranslateType_instance;
end
