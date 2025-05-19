--!AddComponentMenu("")

-- UI
type UI =
{
    EmoteSelected: LuaEvent,
    EmotesClosed: LuaEvent,
    EmotesOpened: LuaEvent,
    aboveChat: VisualElement,
    hud: VisualElement,
    popupRoot: VisualElement,
    CloseCloset: () -> (),
    ExecuteDeepLink: (url: string) -> (),
    OpenCloset: (player: Player , outfitSaved: (CharacterOutfit) -> ()? , title: string? , contents: ClothingCollection? , showPlayerInventory: boolean? , defaultOutfit: CharacterOutfit? , saveButtonText: string?) -> (),
    OpenCloset: (player: Player , title: string , outfitSaved: (CharacterOutfit) -> () , contents: {CharacterClothing}? , showPlayerInventory: boolean? , defaultOutfit: CharacterOutfit? , saveButtonText: string? , defaultToFirstTab: boolean? , closedWithoutSaving: () -> ()?) -> (),
    OpenMiniProfile: (player: Player) -> (),
    OpenMiniProfile: (userId: string) -> (),
    OpenPopup: (ve: UIView) -> number,
    TakeRoomSnapshot: (snapshotClosed: () -> ()?) -> (),
}

-- UIType
type UIType =
{
    __tostring: () -> string,
}

if not _G.UI then
    local UIType_instance : UIType = {}
    _G.UI = UIType_instance;
end
