--!AddComponentMenu("")

-- UIOutlinedLabel
type UIOutlinedLabel =
{
    hasShadow: boolean,
    text: string,
    uppercase: boolean,
    AdjustFontSize: () -> (),
    Dispose: () -> (),
    SetPrelocalizedText: (value: string , skipRtlValidation: boolean?) -> (),
}

-- UIOutlinedLabelType
type UIOutlinedLabelType =
{
    ussOutlinedLabel: string,
    new: () -> UIOutlinedLabel,
    __tostring: () -> string,
}

if not _G.UIOutlinedLabel then
    local UIOutlinedLabelType_instance : UIOutlinedLabelType = {}
    _G.UIOutlinedLabel = UIOutlinedLabelType_instance;
end
