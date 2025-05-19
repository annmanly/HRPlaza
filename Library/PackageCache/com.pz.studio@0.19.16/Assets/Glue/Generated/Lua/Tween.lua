--!AddComponentMenu("")

-- Tween
type Tween =
{
    duration: number,
    isPaused: boolean,
    isPlaying: boolean,
    isValid: boolean,
    normalizedTime: number,
    time: number,
    AddDelay: (seconds: number) -> Tween,
    AutoStop: (value: boolean?) -> Tween,
    DeactivateOnStop: (value: boolean?) -> Tween,
    Delay: (seconds: number) -> Tween,
    DestroyOnStop: (value: boolean?) -> Tween,
    DisableOnStop: (value: boolean?) -> Tween,
    Duration: (seconds: number) -> Tween,
    EaseIn: (easeDelegate: (number, Vector4) -> (number)) -> Tween,
    EaseIn: (easeDelegate: (number, Vector4) -> (number) , param: Vector4) -> Tween,
    EaseInBack: (amplitude: number?) -> Tween,
    EaseInBounce: (oscillations: number? , springiness: number?) -> Tween,
    EaseInCircle: () -> Tween,
    EaseInCubic: () -> Tween,
    EaseInCubicBezier: (p0: number , p1: number , p2: number , p3: number) -> Tween,
    EaseInElastic: (oscillations: number? , springiness: number?) -> Tween,
    EaseInExponential: (exponent: number?) -> Tween,
    EaseInOutBack: (amplitude: number?) -> Tween,
    EaseInOutBounce: (oscillations: number? , springiness: number?) -> Tween,
    EaseInOutCircle: () -> Tween,
    EaseInOutCubic: () -> Tween,
    EaseInOutCubicBezier: (p0: number , p1: number , p2: number , p3: number) -> Tween,
    EaseInOutElastic: (oscillations: number? , springiness: number?) -> Tween,
    EaseInOutExponential: (exponent: number?) -> Tween,
    EaseInOutQuadratic: () -> Tween,
    EaseInOutSine: () -> Tween,
    EaseInQuadratic: () -> Tween,
    EaseInSine: () -> Tween,
    EaseOut: (easeDelegate: (number, Vector4) -> (number)) -> Tween,
    EaseOut: (easeDelegate: (number, Vector4) -> (number) , easeParams: Vector4) -> Tween,
    EaseOutBack: (amplitude: number?) -> Tween,
    EaseOutBounce: (oscillations: number? , springiness: number?) -> Tween,
    EaseOutCircle: () -> Tween,
    EaseOutCubic: () -> Tween,
    EaseOutCubicBezier: (p0: number , p1: number , p2: number , p3: number) -> Tween,
    EaseOutElastic: (oscillations: number? , springiness: number?) -> Tween,
    EaseOutExponential: (exponent: number?) -> Tween,
    EaseOutQuadratic: () -> Tween,
    EaseOutSine: () -> Tween,
    Element: (element: Tween) -> Tween,
    From: () -> Tween,
    Id: (id: number) -> Tween,
    Loop: (count: number?) -> Tween,
    OnPlay: (callback: () -> ()) -> Tween,
    OnStop: (callback: () -> ()) -> Tween,
    Pause: () -> (),
    PingPong: () -> Tween,
    PingPong: (value: boolean) -> Tween,
    Play: () -> Tween,
    Priority: (priority: number) -> Tween,
    Stop: (executeCallbacks: boolean?) -> (),
    UnscaledTime: (unscaled: boolean?) -> Tween,
    Update: (deltaTime: number) -> boolean,
}

-- TweenType
type TweenType =
{
    isAnyTweenAnimating: boolean,
    Reset: () -> (),
    Stop: (id: number, executeCallbacks: boolean?) -> (),
    StopAll: (executeCallbacks: boolean?) -> (),
    __tostring: () -> string,
}

if not _G.Tween then
    local TweenType_instance : TweenType = {}
    _G.Tween = TweenType_instance;
end
