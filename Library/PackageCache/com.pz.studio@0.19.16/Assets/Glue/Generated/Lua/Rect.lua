--!AddComponentMenu("")

-- Rect
type Rect =
{
    center: Vector2,
    height: number,
    max: Vector2,
    min: Vector2,
    position: Vector2,
    size: Vector2,
    width: number,
    x: number,
    xMax: number,
    xMin: number,
    y: number,
    yMax: number,
    yMin: number,
    Contains: (point: Vector2) -> boolean,
    Contains: (point: Vector3) -> boolean,
    Contains: (point: Vector3 , allowInverse: boolean) -> boolean,
    Equals: (other: Rect) -> boolean,
    Overlaps: (other: Rect) -> boolean,
    Overlaps: (other: Rect , allowInverse: boolean) -> boolean,
    Set: (x: number , y: number , width: number , height: number) -> (),
}

-- RectType
type RectType =
{
    zero: Rect,
    new: (source: Rect) -> Rect,
    new: (position: Vector2, size: Vector2) -> Rect,
    new: (x: number, y: number, width: number, height: number) -> Rect,
    MinMaxRect: (xmin: number, ymin: number, xmax: number, ymax: number) -> Rect,
    NormalizedToPoint: (rectangle: Rect, normalizedRectCoordinates: Vector2) -> Vector2,
    PointToNormalized: (rectangle: Rect, point: Vector2) -> Vector2,
    __eq: (lhs: Rect, rhs: Rect) -> boolean,
    __tostring: () -> string,
    __tostring: (format: string) -> string,
    __tostring: (format: string, formatProvider: IFormatProvider) -> string,
}

if not _G.Rect then
    local RectType_instance : RectType = {}
    _G.Rect = RectType_instance;
end
