--!AddComponentMenu("")

-- Screen
type Screen =
{
}

-- ScreenType
type ScreenType =
{
    brightness: number,
    cutouts: {Rect},
    dpi: number,
    fullScreen: boolean,
    height: number,
    safeArea: Rect,
    sleepTimeout: number,
    width: number,
}

if not _G.Screen then
    local ScreenType_instance : ScreenType = {}
    _G.Screen = ScreenType_instance;
end
