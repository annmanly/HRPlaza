--!AddComponentMenu("")

-- Gradient
type Gradient =
{
    Equals: (other: Gradient) -> boolean,
    Evaluate: (time: number) -> Color,
}

-- GradientType
type GradientType =
{
    __tostring: () -> string,
}

if not _G.Gradient then
    local GradientType_instance : GradientType = {}
    _G.Gradient = GradientType_instance;
end
