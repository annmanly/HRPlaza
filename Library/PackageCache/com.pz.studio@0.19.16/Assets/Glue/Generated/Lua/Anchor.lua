--!AddComponentMenu("")

-- Anchor
type Anchor =
{
    Entered: LuaEvent,
    Exited: LuaEvent,
    enterFromPosition: Vector3,
    exitToPosition: Vector3,
    isOccupied: boolean,
    occupant: Character,
    enterFrom: Transform,
    exitTo: Transform,
    isTappable: boolean,
}

-- AnchorType
type AnchorType =
{
    __tostring: () -> string,
}

if not _G.Anchor then
    local AnchorType_instance : AnchorType = {}
    _G.Anchor = AnchorType_instance;
end
