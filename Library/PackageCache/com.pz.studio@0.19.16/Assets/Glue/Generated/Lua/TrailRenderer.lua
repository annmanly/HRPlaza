--!AddComponentMenu("")

-- TrailRenderer
type TrailRenderer =
{
    positionCount: number,
    autodestruct: boolean,
    colorGradient: Gradient,
    emitting: boolean,
    endColor: Color,
    endWidth: number,
    generateLightingData: boolean,
    minVertexDistance: number,
    numCapVertices: number,
    numCornerVertices: number,
    shadowBias: number,
    startColor: Color,
    startWidth: number,
    textureScale: Vector2,
    time: number,
    widthCurve: AnimationCurve,
    widthMultiplier: number,
    AddPosition: (position: Vector3) -> (),
    AddPositions: (positions: {Vector3}) -> (),
    BakeMesh: (mesh: Mesh , camera: Camera , useTransform: boolean?) -> (),
    BakeMesh: (mesh: Mesh , useTransform: boolean?) -> (),
    Clear: () -> (),
    GetPosition: (index: number) -> Vector3,
    SetPosition: (index: number , position: Vector3) -> (),
    SetPositions: (positions: {Vector3}) -> (),
}

-- TrailRendererType
type TrailRendererType =
{
    __tostring: () -> string,
}

if not _G.TrailRenderer then
    local TrailRendererType_instance : TrailRendererType = {}
    _G.TrailRenderer = TrailRendererType_instance;
end
