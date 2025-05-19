--!AddComponentMenu("")

-- CharacterState
type CharacterState =
{
}

-- CharacterStateType
type CharacterStateType =
{
    Custom: CharacterState,
    Emote: CharacterState,
    Idle: CharacterState,
    Jumping: CharacterState,
    None: CharacterState,
    Running: CharacterState,
    Walking: CharacterState,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.CharacterState then
    local CharacterStateType_instance : CharacterStateType = {}
    _G.CharacterState = CharacterStateType_instance;
end
