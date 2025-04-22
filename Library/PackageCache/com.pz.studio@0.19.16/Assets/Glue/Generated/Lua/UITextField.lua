--!AddComponentMenu("")

-- UITextField
type UITextField =
{
    showPlaceholderOnEmptyFocus: boolean,
    cursorColor: Color,
    cursorPosition: Vector2,
    labelElement: Label,
    selectionColor: Color,
    text: string,
    textEdition: ITextEdition,
    textSelection: ITextSelection,
    autoCorrection: boolean,
    cursorIndex: number,
    disableAutocorrection: boolean,
    doubleClickSelectsWord: boolean,
    enableMarkup: boolean,
    hideMobileInput: boolean,
    inputLengthLimit: number,
    isDelayed: boolean,
    isPasswordField: boolean,
    isReadOnly: boolean,
    label: string,
    maskChar: Char,
    maxLength: number,
    selectAllOnFocus: boolean,
    selectAllOnMouseUp: boolean,
    selectIndex: number,
    showClearButton: boolean,
    showMixedValue: boolean,
    showSearchIcon: boolean,
    tripleClickSelectsLine: boolean,
    BlurOnReturn: () -> (),
    Dispose: () -> (),
    LeftTextMargin: () -> number,
    MeasureTextHeight: () -> number,
    SelectAll: () -> (),
    SelectNone: () -> (),
    SelectRange: (cursorIndex: number , selectionIndex: number) -> (),
    SetDecoratedValueWithoutNotify: (value: string) -> (),
    SetPlaceholderText: (str: string) -> (),
    SetValueWithoutNotify: (newValue: string) -> (),
}

-- UITextFieldType
type UITextFieldType =
{
    new: () -> UITextField,
    FocusedTextField: () -> UITextField,
    IsTextFieldFocused: () -> boolean,
    __tostring: () -> string,
}

if not _G.UITextField then
    local UITextFieldType_instance : UITextFieldType = {}
    _G.UITextField = UITextFieldType_instance;
end
