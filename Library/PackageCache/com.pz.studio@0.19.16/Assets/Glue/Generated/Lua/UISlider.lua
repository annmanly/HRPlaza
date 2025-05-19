--!AddComponentMenu("")

-- UISlider
type UISlider =
{
    highValue: number,
    lowValue: number,
    value: number,
    SetValueWithoutNotify: (newValue: number) -> (),
}

-- UISliderType
type UISliderType =
{
    Instantiate: () -> UISlider,
    new: () -> UISlider,
    __tostring: () -> string,
}

if not _G.UISlider then
    local UISliderType_instance : UISliderType = {}
    _G.UISlider = UISliderType_instance;
end
