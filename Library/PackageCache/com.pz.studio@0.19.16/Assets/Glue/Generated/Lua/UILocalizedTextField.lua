--!AddComponentMenu("")

-- UILocalizedTextField
type UILocalizedTextField =
{
    cursorColor: Color,
    cursorPosition: Vector2,
    labelElement: Label,
    selectionColor: Color,
    text: string,
    textEdition: ITextEdition,
    textSelection: ITextSelection,
    autoCorrection: boolean,
    cursorIndex: number,
    doubleClickSelectsWord: boolean,
    hideMobileInput: boolean,
    isDelayed: boolean,
    isPasswordField: boolean,
    isReadOnly: boolean,
    label: string,
    maskChar: Char,
    maxLength: number,
    selectAllOnFocus: boolean,
    selectAllOnMouseUp: boolean,
    selectIndex: number,
    showMixedValue: boolean,
    tripleClickSelectsLine: boolean,
    SelectAll: () -> (),
    SelectNone: () -> (),
    SelectRange: (cursorIndex: number , selectionIndex: number) -> (),
    SetPlaceholderText: (localizedString: LocalizedString) -> (),
}

-- UILocalizedTextFieldType
type UILocalizedTextFieldType =
{
    new: () -> UILocalizedTextField,
    __tostring: () -> string,
}

if not _G.UILocalizedTextField then
    local UILocalizedTextFieldType_instance : UILocalizedTextFieldType = {}
    _G.UILocalizedTextField = UILocalizedTextFieldType_instance;
end
