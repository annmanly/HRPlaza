--!AddComponentMenu("")

-- Component
type Component =
{
    gameObject: GameObject,
    transform: Transform,
    tag: string,
    CompareTag: (tag: string) -> boolean,
    GetComponent: (type: Type) -> Component,
    GetComponentInChildren: (t: Type , includeInactive: boolean?) -> Component,
    GetComponentInParent: (t: Type , includeInactive: boolean?) -> Component,
    GetComponentIndex: () -> number,
    GetComponents: (type: Type) -> {Component},
    GetComponentsInChildren: (t: Type , includeInactive: boolean?) -> {Component},
    GetComponentsInParent: (t: Type , includeInactive: boolean?) -> {Component},
    SendMessage: (methodName: string) -> (),
    SendMessageUpwards: (methodName: string) -> (),
}

-- ComponentType
type ComponentType =
{
    __tostring: () -> string,
}

if not _G.Component then
    local ComponentType_instance : ComponentType = {}
    _G.Component = ComponentType_instance;
end
