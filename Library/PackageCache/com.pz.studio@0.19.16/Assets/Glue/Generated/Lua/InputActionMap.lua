--!AddComponentMenu("")

-- InputActionMap
type InputActionMap =
{
    enabled: boolean,
    name: string,
    Clone: () -> InputActionMap,
    Contains: (action: InputAction) -> boolean,
    Disable: () -> (),
    Enable: () -> (),
    FindAction: (actionNameOrId: string , throwIfNotFound: boolean?) -> InputAction,
    OnAfterDeserialize: () -> (),
    OnBeforeSerialize: () -> (),
    ToJson: () -> string,
}

-- InputActionMapType
type InputActionMapType =
{
    new: () -> InputActionMap,
    new: (name: string) -> InputActionMap,
    FromJson: (json: string) -> {InputActionMap},
    __tostring: () -> string,
}

if not _G.InputActionMap then
    local InputActionMapType_instance : InputActionMapType = {}
    _G.InputActionMap = InputActionMapType_instance;
end
