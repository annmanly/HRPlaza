--!AddComponentMenu("")

-- Player
type Player =
{
    PetOutfitChanged: LuaEvent,
    activeChannel: ChannelInfo,
    chatBubbleTransform: Transform,
    hasPet: boolean,
    pet: Pet,
    voicePosition: Vector3,
    IsUsingPetType: (petId: string) -> boolean,
}

-- PlayerType
type PlayerType =
{
}

if not _G.Player then
    local PlayerType_instance : PlayerType = {}
    _G.Player = PlayerType_instance;
end
