--!AddComponentMenu("")

-- InventoryManager
type InventoryManager =
{
    inventoryChanged: LuaEvent,
}

-- InventoryManagerType
type InventoryManagerType =
{
    __tostring: () -> string,
}

if not _G.InventoryManager then
    local InventoryManagerType_instance : InventoryManagerType = {}
    _G.InventoryManager = InventoryManagerType_instance;
end
