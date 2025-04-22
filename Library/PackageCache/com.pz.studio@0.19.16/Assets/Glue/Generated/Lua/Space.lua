--!AddComponentMenu("")

-- Space
type Space =
{
}

-- SpaceType
type SpaceType =
{
    Self: Space,
    World: Space,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.Space then
    local SpaceType_instance : SpaceType = {}
    _G.Space = SpaceType_instance;
end
