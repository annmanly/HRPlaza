--!AddComponentMenu("")

-- BindableElement
type BindableElement =
{
    binding: IBinding,
    bindingPath: string,
}

-- BindableElementType
type BindableElementType =
{
    new: () -> BindableElement,
    __tostring: () -> string,
}

if not _G.BindableElement then
    local BindableElementType_instance : BindableElementType = {}
    _G.BindableElement = BindableElementType_instance;
end
