--!AddComponentMenu("")

-- LineRenderer
type LineRenderer =
{
    colorGradient: Gradient,
    endColor: Color,
    endWidth: number,
    generateLightingData: boolean,
    loop: boolean,
    numCapVertices: number,
    numCornerVertices: number,
    positionCount: number,
    shadowBias: number,
    startColor: Color,
    startWidth: number,
    textureScale: Vector2,
    useWorldSpace: boolean,
    widthCurve: AnimationCurve,
    widthMultiplier: number,
    BakeMesh: (mesh: Mesh , camera: Camera , useTransform: boolean?) -> (),
    BakeMesh: (mesh: Mesh , useTransform: boolean?) -> (),
    GetPosition: (index: number) -> Vector3,
    SetPosition: (index: number , position: Vector3) -> (),
    SetPositions: (positions: {Vector3}) -> (),
    Simplify: (tolerance: number) -> (),
}

-- LineRendererType
type LineRendererType =
{
    __tostring: () -> string,
}

if not _G.LineRenderer then
    local LineRendererType_instance : LineRendererType = {}
    _G.LineRenderer = LineRendererType_instance;
end
