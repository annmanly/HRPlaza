--!AddComponentMenu("")

-- InputAction
type InputAction =
{
    actionMap: InputActionMap,
    enabled: boolean,
    inProgress: boolean,
    interactions: string,
    name: string,
    processors: string,
    triggered: boolean,
    expectedControlType: string,
    wantsInitialStateCheck: boolean,
    Clone: () -> InputAction,
    Disable: () -> (),
    Enable: () -> (),
    GetTimeoutCompletionPercentage: () -> number,
    IsInProgress: () -> boolean,
    IsPressed: () -> boolean,
    ReadVector2: () -> Vector2,
    Reset: () -> (),
    WasPerformedThisFrame: () -> boolean,
    WasPressedThisFrame: () -> boolean,
    WasReleasedThisFrame: () -> boolean,
}

-- InputActionType
type InputActionType =
{
    new: () -> InputAction,
    __tostring: () -> string,
}

if not _G.InputAction then
    local InputActionType_instance : InputActionType = {}
    _G.InputAction = InputActionType_instance;
end
