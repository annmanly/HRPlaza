--!AddComponentMenu("")

-- InputActionReference
type InputActionReference =
{
    action: InputAction,
    Set: (action: InputAction) -> (),
    ToInputAction: () -> InputAction,
}

-- InputActionReferenceType
type InputActionReferenceType =
{
    new: () -> InputActionReference,
    Create: (action: InputAction) -> InputActionReference,
    __tostring: () -> string,
}

if not _G.InputActionReference then
    local InputActionReferenceType_instance : InputActionReferenceType = {}
    _G.InputActionReference = InputActionReferenceType_instance;
end
