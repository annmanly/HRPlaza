--!AddComponentMenu("")

-- Shader
type Shader =
{
    isSupported: boolean,
    passCount: number,
    renderQueue: number,
    subshaderCount: number,
    maximumLOD: number,
    FindPropertyIndex: (propertyName: string) -> number,
    FindTextureStack: (propertyIndex: number) -> (boolean , string , number),
    GetDependency: (name: string) -> Shader,
    GetPassCountInSubshader: (subshaderIndex: number) -> number,
    GetPropertyAttributes: (propertyIndex: number) -> {string},
    GetPropertyCount: () -> number,
    GetPropertyDefaultFloatValue: (propertyIndex: number) -> number,
    GetPropertyDefaultIntValue: (propertyIndex: number) -> number,
    GetPropertyDefaultVectorValue: (propertyIndex: number) -> Vector4,
    GetPropertyDescription: (propertyIndex: number) -> string,
    GetPropertyName: (propertyIndex: number) -> string,
    GetPropertyNameId: (propertyIndex: number) -> number,
    GetPropertyRangeLimits: (propertyIndex: number) -> Vector2,
    GetPropertyTextureDefaultName: (propertyIndex: number) -> string,
}

-- ShaderType
type ShaderType =
{
    PropertyToID: (name: string) -> number,
    __tostring: () -> string,
}

if not _G.Shader then
    local ShaderType_instance : ShaderType = {}
    _G.Shader = ShaderType_instance;
end
