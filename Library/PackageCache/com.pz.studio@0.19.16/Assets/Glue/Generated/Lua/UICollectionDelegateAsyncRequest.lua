--!AddComponentMenu("")

-- UICollectionDelegateAsyncRequest
type UICollectionDelegateAsyncRequest =
{
    isCancelled: boolean,
    resultOffset: number,
    CompleteRequest: (results: {LuaObject}) -> (),
}

-- UICollectionDelegateAsyncRequestType
type UICollectionDelegateAsyncRequestType =
{
    __tostring: () -> string,
}

if not _G.UICollectionDelegateAsyncRequest then
    local UICollectionDelegateAsyncRequestType_instance : UICollectionDelegateAsyncRequestType = {}
    _G.UICollectionDelegateAsyncRequest = UICollectionDelegateAsyncRequestType_instance;
end
