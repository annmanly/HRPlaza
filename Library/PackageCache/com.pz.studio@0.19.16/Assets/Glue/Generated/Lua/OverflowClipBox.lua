--!AddComponentMenu("")

-- OverflowClipBox
type OverflowClipBox =
{
}

-- OverflowClipBoxType
type OverflowClipBoxType =
{
    ContentBox: OverflowClipBox,
    PaddingBox: OverflowClipBox,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
}

if not _G.OverflowClipBox then
    local OverflowClipBoxType_instance : OverflowClipBoxType = {}
    _G.OverflowClipBox = OverflowClipBoxType_instance;
end
