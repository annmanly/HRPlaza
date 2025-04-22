--!AddComponentMenu("")

-- TextElement
type TextElement =
{
    experimental: ITextElementExperimentalFeatures,
    isElided: boolean,
    selection: ITextSelection,
    displayTooltipWhenElided: boolean,
    enableRichText: boolean,
    parseEscapeSequences: boolean,
    text: string,
}

-- TextElementType
type TextElementType =
{
    ussClassName: string,
    new: () -> TextElement,
    __tostring: () -> string,
}

if not _G.TextElement then
    local TextElementType_instance : TextElementType = {}
    _G.TextElement = TextElementType_instance;
end
