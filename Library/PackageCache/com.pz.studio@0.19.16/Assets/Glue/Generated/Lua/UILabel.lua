--!AddComponentMenu("")

-- UILabel
type UILabel =
{
    autoSizingFontSize: number,
    minFontSize: number,
    onLinkPress: (string) -> (),
    text: string,
    titlecase: boolean,
    uppercase: boolean,
    AdjustFontSize: () -> (),
    CancelPendingDecoratedLinksFetch: () -> (),
    Dispose: () -> (),
    SetEmojiPrelocalizedText: (value: string) -> (),
    SetEmojiPrelocalizedText: (value: string , skipValidation: boolean) -> (),
    SetPrelocalizedText: (value: string , skipRtlValidation: boolean?) -> (),
    SetSocialEmojiText: (value: string) -> (),
    SetSocialText: (value: string) -> (),
}

-- UILabelType
type UILabelType =
{
    new: () -> UILabel,
    EmojiPrelocalized: (text: string, skipValidation: boolean?, skipRtlValidation: boolean?) -> UILabel,
    PreLocalized: (text: string, skipValidation: boolean?, skipRtlValidation: boolean?) -> UILabel,
    __tostring: () -> string,
}

if not _G.UILabel then
    local UILabelType_instance : UILabelType = {}
    _G.UILabel = UILabelType_instance;
end
