--!AddComponentMenu("")

-- Gesture
type Gesture =
{
    target: VisualElement,
}

-- GestureType
type GestureType =
{
}

if not _G.Gesture then
    local GestureType_instance : GestureType = {}
    _G.Gesture = GestureType_instance;
end
