--!AddComponentMenu("")

-- UITextFieldBase
type UITextFieldBase =
{
    cursorColor: Color,
    cursorPosition: Vector2,
    fontStyle: FontStyle,
    labelElement: Label,
    originalValue: string,
    selectionColor: Color,
    text: string,
    textEdition: ITextEdition,
    textElement: TextElement,
    textSelection: ITextSelection,
    autoCorrection: boolean,
    cursorIndex: number,
    doubleClickSelectsWord: boolean,
    hideMobileInput: boolean,
    inputPattern: string,
    isDelayed: boolean,
    isPasswordField: boolean,
    isReadOnly: boolean,
    isShiftReturnModeEnabled: boolean,
    label: string,
    maskChar: Char,
    maxLength: number,
    multiline: boolean,
    selectAllOnFocus: boolean,
    selectAllOnMouseUp: boolean,
    selectIndex: number,
    showMixedValue: boolean,
    textAlign: TextAnchor,
    tripleClickSelectsLine: boolean,
    value: string,
    ReplaceSelection: (value: string) -> (),
    SelectAll: () -> (),
    SelectNone: () -> (),
    SelectRange: (cursorIndex: number , selectionIndex: number) -> (),
    SelectTextEnd: () -> (),
    SetValueWithoutNotify: (newValue: string) -> (),
}

-- UITextFieldBaseType
type UITextFieldBaseType =
{
    emojiParser: IEmojiParser,
    inputUssClassName: string,
    labelUssClassName: string,
    ussClassName: string,
    new: () -> UITextFieldBase,
    new: (maxLength: number, multiline: boolean, isPasswordField: boolean, maskChar: Char) -> UITextFieldBase,
    new: (label: string) -> UITextFieldBase,
    new: (label: string, maxLength: number, multiline: boolean, isPasswordField: boolean, maskChar: Char) -> UITextFieldBase,
    __tostring: () -> string,
}

if not _G.UITextFieldBase then
    local UITextFieldBaseType_instance : UITextFieldBaseType = {}
    _G.UITextFieldBase = UITextFieldBaseType_instance;
end
