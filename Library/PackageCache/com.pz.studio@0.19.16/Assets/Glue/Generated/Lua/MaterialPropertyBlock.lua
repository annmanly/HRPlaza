--!AddComponentMenu("")

-- MaterialPropertyBlock
type MaterialPropertyBlock =
{
    isEmpty: boolean,
    Clear: () -> (),
    GetColor: (nameID: number) -> Color,
    GetColor: (name: string) -> Color,
    GetFloat: (nameID: number) -> number,
    GetFloat: (name: string) -> number,
    GetFloatArray: (nameID: number) -> {number},
    GetFloatArray: (name: string) -> {number},
    GetInt: (nameID: number) -> number,
    GetInt: (name: string) -> number,
    GetInteger: (nameID: number) -> number,
    GetInteger: (name: string) -> number,
    GetMatrix: (nameID: number) -> Matrix4x4,
    GetMatrix: (name: string) -> Matrix4x4,
    GetMatrixArray: (nameID: number) -> {Matrix4x4},
    GetMatrixArray: (name: string) -> {Matrix4x4},
    GetTexture: (nameID: number) -> Texture,
    GetTexture: (name: string) -> Texture,
    GetVector: (nameID: number) -> Vector4,
    GetVector: (name: string) -> Vector4,
    GetVectorArray: (nameID: number) -> {Vector4},
    GetVectorArray: (name: string) -> {Vector4},
    HasBuffer: (nameID: number) -> boolean,
    HasBuffer: (name: string) -> boolean,
    HasColor: (nameID: number) -> boolean,
    HasColor: (name: string) -> boolean,
    HasConstantBuffer: (nameID: number) -> boolean,
    HasConstantBuffer: (name: string) -> boolean,
    HasFloat: (nameID: number) -> boolean,
    HasFloat: (name: string) -> boolean,
    HasInt: (nameID: number) -> boolean,
    HasInt: (name: string) -> boolean,
    HasInteger: (nameID: number) -> boolean,
    HasInteger: (name: string) -> boolean,
    HasMatrix: (nameID: number) -> boolean,
    HasMatrix: (name: string) -> boolean,
    HasProperty: (nameID: number) -> boolean,
    HasProperty: (name: string) -> boolean,
    HasTexture: (nameID: number) -> boolean,
    HasTexture: (name: string) -> boolean,
    HasVector: (nameID: number) -> boolean,
    HasVector: (name: string) -> boolean,
    SetColor: (nameID: number , value: Color) -> (),
    SetColor: (name: string , value: Color) -> (),
    SetFloat: (nameID: number , value: number) -> (),
    SetFloat: (name: string , value: number) -> (),
    SetFloatArray: (nameID: number , values: {number}) -> (),
    SetFloatArray: (name: string , values: {number}) -> (),
    SetInt: (nameID: number , value: number) -> (),
    SetInt: (name: string , value: number) -> (),
    SetInteger: (nameID: number , value: number) -> (),
    SetInteger: (name: string , value: number) -> (),
    SetMatrix: (nameID: number , value: Matrix4x4) -> (),
    SetMatrix: (name: string , value: Matrix4x4) -> (),
    SetMatrixArray: (nameID: number , values: {Matrix4x4}) -> (),
    SetMatrixArray: (name: string , values: {Matrix4x4}) -> (),
    SetTexture: (nameID: number , value: Texture) -> (),
    SetTexture: (name: string , value: Texture) -> (),
    SetVector: (nameID: number , value: Vector4) -> (),
    SetVector: (name: string , value: Vector4) -> (),
    SetVectorArray: (nameID: number , values: {Vector4}) -> (),
    SetVectorArray: (name: string , values: {Vector4}) -> (),
}

-- MaterialPropertyBlockType
type MaterialPropertyBlockType =
{
    new: () -> MaterialPropertyBlock,
    __tostring: () -> string,
}

if not _G.MaterialPropertyBlock then
    local MaterialPropertyBlockType_instance : MaterialPropertyBlockType = {}
    _G.MaterialPropertyBlock = MaterialPropertyBlockType_instance;
end
