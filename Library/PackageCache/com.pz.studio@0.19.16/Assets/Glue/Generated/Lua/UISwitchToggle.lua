--!AddComponentMenu("")

-- UISwitchToggle
type UISwitchToggle =
{
    value: boolean,
    SetValueWithoutNotify: (newValue: boolean) -> (),
}

-- UISwitchToggleType
type UISwitchToggleType =
{
    new: () -> UISwitchToggle,
    __tostring: () -> string,
}

if not _G.UISwitchToggle then
    local UISwitchToggleType_instance : UISwitchToggleType = {}
    _G.UISwitchToggle = UISwitchToggleType_instance;
end
