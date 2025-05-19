--!AddComponentMenu("")

-- ColorUtility
type ColorUtility =
{
}

-- ColorUtilityType
type ColorUtilityType =
{
    ToHtmlStringRGB: (color: Color) -> string,
    ToHtmlStringRGBA: (color: Color) -> string,
    TryParseHtmlString: (htmlString: string) -> (boolean , Color),
    __tostring: () -> string,
}

if not _G.ColorUtility then
    local ColorUtilityType_instance : ColorUtilityType = {}
    _G.ColorUtility = ColorUtilityType_instance;
end
