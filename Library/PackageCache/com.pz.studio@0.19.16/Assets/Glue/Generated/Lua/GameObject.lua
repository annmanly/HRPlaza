--!AddComponentMenu("")

-- GameObject
type GameObject =
{
    activeInHierarchy: boolean,
    activeSelf: boolean,
    gameObject: GameObject,
    sceneCullingMask: number,
    transform: Transform,
    isStatic: boolean,
    layer: number,
    tag: string,
    AddComponent: (type: Type) -> Component,
    AddScript: (script: LuaScript) -> LuaBehaviour,
    CompareTag: (tag: string) -> boolean,
    GetComponent: (type: Type) -> Component,
    GetComponentAtIndex: (index: number) -> Component,
    GetComponentCount: () -> number,
    GetComponentInChildren: (type: Type , includeInactive: boolean) -> Component,
    GetComponentInParent: (type: Type , includeInactive: boolean) -> Component,
    GetComponentIndex: (component: Component) -> number,
    GetComponents: (type: Type) -> {Component},
    GetComponentsInChildren: (type: Type , includeInactive: boolean) -> {Component},
    GetComponentsInParent: (type: Type , includeInactive: boolean) -> {Component},
    SetActive: (value: boolean) -> (),
}

-- GameObjectType
type GameObjectType =
{
    new: () -> GameObject,
    new: (name: string) -> GameObject,
    new: (name: string, components: {Type}) -> GameObject,
    Find: (name: string) -> GameObject,
    FindGameObjectWithTag: (tag: string) -> GameObject,
    FindGameObjectsWithTag: (tag: string) -> {GameObject},
    FindWithTag: (tag: string) -> GameObject,
    __tostring: () -> string,
}

if not _G.GameObject then
    local GameObjectType_instance : GameObjectType = {}
    _G.GameObject = GameObjectType_instance;
end
