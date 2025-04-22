--!AddComponentMenu("")

-- AbstractProgressBar
type AbstractProgressBar =
{
    highValue: number,
    lowValue: number,
    title: string,
    value: number,
    SetValueWithoutNotify: (newValue: number) -> (),
}

-- AbstractProgressBarType
type AbstractProgressBarType =
{
    backgroundUssClassName: string,
    containerUssClassName: string,
    progressUssClassName: string,
    titleContainerUssClassName: string,
    titleUssClassName: string,
    ussClassName: string,
    __tostring: () -> string,
}

if not _G.AbstractProgressBar then
    local AbstractProgressBarType_instance : AbstractProgressBarType = {}
    _G.AbstractProgressBar = AbstractProgressBarType_instance;
end
