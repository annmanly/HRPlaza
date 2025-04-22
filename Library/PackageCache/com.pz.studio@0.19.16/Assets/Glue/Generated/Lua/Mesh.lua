--!AddComponentMenu("")

-- Mesh
type Mesh =
{
    bindposeCount: number,
    bindposes: {Matrix4x4},
    blendShapeCount: number,
    bounds: Bounds,
    colors: {Color},
    isReadable: boolean,
    normals: {Vector3},
    triangles: {number},
    uv: {Vector2},
    uv2: {Vector2},
    uv3: {Vector2},
    uv4: {Vector2},
    uv5: {Vector2},
    uv6: {Vector2},
    uv7: {Vector2},
    uv8: {Vector2},
    vertexAttributeCount: number,
    vertexBufferCount: number,
    vertexCount: number,
    vertices: {Vector3},
    subMeshCount: number,
    Clear: () -> (),
    Clear: (keepVertexLayout: boolean) -> (),
    ClearBlendShapes: () -> (),
    GetBaseVertex: (submesh: number) -> number,
    GetBlendShapeFrameCount: (shapeIndex: number) -> number,
    GetBlendShapeFrameWeight: (shapeIndex: number , frameIndex: number) -> number,
    GetBlendShapeIndex: (blendShapeName: string) -> number,
    GetBlendShapeName: (shapeIndex: number) -> string,
    GetIndexCount: (submesh: number) -> number,
    GetIndexStart: (submesh: number) -> number,
    GetIndices: (submesh: number) -> {number},
    GetIndices: (submesh: number , applyBaseVertex: boolean) -> {number},
    GetTriangles: (submesh: number) -> {number},
    GetTriangles: (submesh: number , applyBaseVertex: boolean) -> {number},
    GetUVDistributionMetric: (uvSetIndex: number) -> number,
    GetVertexBufferStride: (stream: number) -> number,
    MarkDynamic: () -> (),
    MarkModified: () -> (),
    Optimize: () -> (),
    OptimizeIndexBuffers: () -> (),
    OptimizeReorderVertexBuffer: () -> (),
    RecalculateBounds: () -> (),
    RecalculateNormals: () -> (),
    RecalculateTangents: () -> (),
    RecalculateUVDistributionMetric: (uvSetIndex: number , uvAreaThreshold: number?) -> (),
    RecalculateUVDistributionMetrics: (uvAreaThreshold: number?) -> (),
    UploadMeshData: (markNoLongerReadable: boolean) -> (),
}

-- MeshType
type MeshType =
{
    new: () -> Mesh,
    __tostring: () -> string,
}

if not _G.Mesh then
    local MeshType_instance : MeshType = {}
    _G.Mesh = MeshType_instance;
end
