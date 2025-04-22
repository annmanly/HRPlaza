--!AddComponentMenu("")

-- UIProgressBar
type UIProgressBar =
{
    value: number,
}

-- UIProgressBarType
type UIProgressBarType =
{
    new: () -> UIProgressBar,
    __tostring: () -> string,
}

if not _G.UIProgressBar then
    local UIProgressBarType_instance : UIProgressBarType = {}
    _G.UIProgressBar = UIProgressBarType_instance;
end
