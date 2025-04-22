--!AddComponentMenu("")

-- ProgressBar
type ProgressBar =
{
}

-- ProgressBarType
type ProgressBarType =
{
    new: () -> ProgressBar,
    __tostring: () -> string,
}

if not _G.ProgressBar then
    local ProgressBarType_instance : ProgressBarType = {}
    _G.ProgressBar = ProgressBarType_instance;
end
