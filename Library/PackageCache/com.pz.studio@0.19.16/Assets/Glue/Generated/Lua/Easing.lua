--!AddComponentMenu("")

-- Easing
type Easing =
{
}

-- EasingType
type EasingType =
{
    Back: (t: number, p: number) -> number,
    Bounce: (t: number, bounces: number, bounciness: number) -> number,
    Circle: (t: number) -> number,
    Cubic: (t: number) -> number,
    CubicBezier: (t: number, x1: number, y1: number, x2: number, y2: number) -> number,
    Elastic: (t: number, oscillations: number, springiness: number) -> number,
    Exponential: (t: number, p: number) -> number,
    Quadratic: (t: number) -> number,
    Sine: (t: number) -> number,
}

if not _G.Easing then
    local EasingType_instance : EasingType = {}
    _G.Easing = EasingType_instance;
end
