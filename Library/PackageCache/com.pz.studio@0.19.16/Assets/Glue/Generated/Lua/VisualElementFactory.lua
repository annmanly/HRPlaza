--!AddComponentMenu("")

-- VisualElementFactory
type VisualElementFactory =
{
}

-- VisualElementFactoryType
type VisualElementFactoryType =
{
    new: () -> VisualElementFactory,
}

if not _G.VisualElementFactory then
    local VisualElementFactoryType_instance : VisualElementFactoryType = {}
    _G.VisualElementFactory = VisualElementFactoryType_instance;
end
