--!AddComponentMenu("")

-- Object
type Object =
{
    name: string,
}

-- ObjectType
type ObjectType =
{
    Destroy: (obj: Object, t: number?) -> (),
    DestroyImmediate: (obj: Object, allowDestroyAssets: boolean?) -> (),
    FindAnyObjectByType: (type: Type) -> Object,
    FindFirstObjectByType: (type: Type) -> Object,
    FindObjectOfType: (type: Type) -> Object,
    FindObjectOfType: (type: Type, includeInactive: boolean) -> Object,
    FindObjectsOfType: (type: Type) -> {Object},
    FindObjectsOfType: (type: Type, includeInactive: boolean) -> {Object},
    Instantiate: (original: Object) -> Object,
    Instantiate: (original: Object, position: Vector3) -> Object,
    Instantiate: (original: Object, position: Vector3, rotation: Quaternion) -> Object,
    __eq: (x: Object, y: Object) -> boolean,
    __tostring: () -> string,
}

if not _G.Object then
    local ObjectType_instance : ObjectType = {}
    _G.Object = ObjectType_instance;
end
