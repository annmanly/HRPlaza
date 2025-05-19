--!AddComponentMenu("")

-- Character
type Character =
{
    AnchorChanged: LuaEvent,
    AnimationEvent: LuaEvent,
    MoveFinished: LuaEvent,
    MoveStarted: LuaEvent,
    OutfitChanged: LuaEvent,
    StateChanged: LuaEvent,
    chatBubbleTransform: Transform,
    defaultOutfits: {CharacterOutfit},
    destination: Vector3,
    distanceToDestination: number,
    hasOutfit: boolean,
    isAnchored: boolean,
    isIdle: boolean,
    isMoving: boolean,
    outfits: {CharacterOutfit},
    anchor: Anchor,
    pet: Pet,
    player: Player,
    renderLayer: number,
    renderMaterial: Material,
    renderPosition: Vector3,
    renderRotation: Quaternion,
    renderScale: Vector3,
    renderShadow: boolean,
    speed: number,
    state: CharacterState,
    usePathfinding: boolean,
    AddOutfit: (outfit: CharacterOutfit) -> (),
    CopyOutfit: (character: Character) -> (),
    JumpTo: (position: Vector3 , taskCompleteCallback: any?) -> boolean,
    JumpTo: (position: Vector3 , jumpSpeedMultiplier: number , jumpHeightMultiplier: number , taskCompleteCallback: any?) -> boolean,
    MoveTo: (position: Vector3 , areaMask: number? , callback: any? , targetSearchDistance: number?) -> boolean,
    MoveToAnchor: (anchor: Anchor , areaMask: number? , callback: any?) -> boolean,
    MoveWithinRangeOf: (destination: Vector3 , stopDistance: number , areaMask: number? , callback: any? , targetSearchDistance: number?) -> boolean,
    PlayAnimation: (anim: CharacterAnimation , speed: number? , loop: boolean? , callback: any?) -> boolean,
    PlayEmote: (emoteName: string , loop: boolean? , callback: any?) -> boolean,
    PlayEmote: (emoteName: string , speed: number , loop: boolean? , callback: any?) -> boolean,
    PlaySpeakingAnimation: () -> (),
    RemoveOutfit: (outfit: CharacterOutfit) -> (),
    ResetOutfit: () -> (),
    SetIdle: () -> (),
    SetOutfit: (outfit: CharacterOutfit) -> (),
    StopEmote: () -> (),
    Teleport: (position: Vector3 , taskCompleteCallback: any?) -> boolean,
    TeleportToAnchor: (anchor: Anchor) -> boolean,
    TeleportToNearestNavMeshPosition: () -> (),
    TweenRenderPosition: (from: Vector3 , to: Vector3) -> Tween,
    TweenRenderPositionTo: (to: Vector3) -> Tween,
}

-- CharacterType
type CharacterType =
{
    __tostring: () -> string,
}

if not _G.Character then
    local CharacterType_instance : CharacterType = {}
    _G.Character = CharacterType_instance;
end
