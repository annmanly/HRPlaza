--!AddComponentMenu("")

-- UIThumbstick
type UIThumbstick =
{
    isAnchored: boolean,
    preventDragging: boolean,
    container: VisualElement,
    knob: VisualElement,
    movementDirection: Vector2,
}

-- UIThumbstickType
type UIThumbstickType =
{
    new: () -> UIThumbstick,
    __tostring: () -> string,
}

if not _G.UIThumbstick then
    local UIThumbstickType_instance : UIThumbstickType = {}
    _G.UIThumbstick = UIThumbstickType_instance;
end
