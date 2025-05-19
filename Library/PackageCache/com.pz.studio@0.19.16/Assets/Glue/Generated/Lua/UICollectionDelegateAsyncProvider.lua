--!AddComponentMenu("")

-- UICollectionDelegateAsyncProvider
type UICollectionDelegateAsyncProvider =
{
    Fetch: (forceReload: boolean?) -> (),
    Refresh: () -> (),
}

-- UICollectionDelegateAsyncProviderType
type UICollectionDelegateAsyncProviderType =
{
    new: (cellInstantiate: (number, any) -> (UIView), asyncFetch: (UICollectionDelegateAsyncRequest) -> ()) -> UICollectionDelegateAsyncProvider,
    __tostring: () -> string,
}

if not _G.UICollectionDelegateAsyncProvider then
    local UICollectionDelegateAsyncProviderType_instance : UICollectionDelegateAsyncProviderType = {}
    _G.UICollectionDelegateAsyncProvider = UICollectionDelegateAsyncProviderType_instance;
end
