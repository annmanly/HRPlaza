--!AddComponentMenu("")

-- Pet
type Pet =
{
    id: string,
    name: string,
    owner: Player,
    skeletonId: string,
    character: Character,
}

-- PetType
type PetType =
{
    __tostring: () -> string,
}

if not _G.Pet then
    local PetType_instance : PetType = {}
    _G.Pet = PetType_instance;
end
