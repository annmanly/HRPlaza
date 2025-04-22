--!AddComponentMenu("")

-- Color
type Color =
{
    a: number,
    b: number,
    g: number,
    r: number,
    gamma: Color,
    grayscale: number,
    linear: Color,
    maxColorComponent: number,
    Alpha: (a: number) -> Color,
    Equals: (other: Color) -> boolean,
    MultiplyAlpha: (a: number) -> Color,
    ToHex: () -> string,
    ToLuma: () -> number,
}

-- ColorType
type ColorType =
{
    black: Color,
    blue: Color,
    clear: Color,
    cyan: Color,
    gray: Color,
    green: Color,
    grey: Color,
    magenta: Color,
    red: Color,
    white: Color,
    yellow: Color,
    new: (r: number, g: number, b: number) -> Color,
    new: (r: number, g: number, b: number, a: number) -> Color,
    HSVToRGB: (H: number, S: number, V: number) -> Color,
    HSVToRGB: (H: number, S: number, V: number, hdr: boolean) -> Color,
    Lerp: (a: Color, b: Color, t: number) -> Color,
    LerpUnclamped: (a: Color, b: Color, t: number) -> Color,
    RGBToHSV: (rgbColor: Color) -> (number , number , number),
    __add: (a: Color, b: Color) -> Color,
    __div: (a: Color, b: number) -> Color,
    __eq: (lhs: Color, rhs: Color) -> boolean,
    __mul: (a: Color, b: Color) -> Color,
    __mul: (a: Color, b: number) -> Color,
    __mul: (b: number, a: Color) -> Color,
    __sub: (a: Color, b: Color) -> Color,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Color then
    local ColorType_instance : ColorType = {}
    _G.Color = ColorType_instance;
end
