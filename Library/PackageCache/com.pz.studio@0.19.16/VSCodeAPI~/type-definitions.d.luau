declare class Type
end
declare class TypeType extends Type
end
declare Type: TypeType

declare class Action
end
declare class ActionType extends Type
end
declare Action: ActionType

declare class BoolValue
    Changed: Event
    value: boolean
end
declare class BoolValueType extends Type
    new: (name: string) -> BoolValue
    new: (name: string, initialValue: boolean) -> BoolValue
    new: (name: string, initialValue: boolean, player: Player) -> BoolValue
end
declare BoolValue: BoolValueType

declare class Byte
end
declare class ByteType extends Type
end
declare Byte: ByteType

declare class Char
end
declare class CharType extends Type
end
declare Char: CharType

declare class EmitWorldEventError
end
declare class EmitWorldEventErrorType extends Type
    Count: EmitWorldEventError
    InternalError: EmitWorldEventError
    InvalidEventError: EmitWorldEventError
    InvalidPayloadError: EmitWorldEventError
    None: EmitWorldEventError
    RequestThrottled: EmitWorldEventError
end
declare EmitWorldEventError: EmitWorldEventErrorType

declare class Event
    name: string
    function Connect(self, callback: (...any) -> ...any): EventConnection
    function Fire(self, ...: any)
    function FireAllClients(self, ...: any)
    function FireAllOtherClients(self, player: Player, ...: any)
    function FireClient(self, player: Player, ...: any)
    function FireClients(self, players: {Player}, ...: any)
    function FireServer(self, ...: any)
end
declare class EventType extends Type
    new: (name: string) -> Event
end
declare Event: EventType

declare class EventConnection
    function Disconnect(self)
end
declare class EventConnectionType extends Type
end
declare EventConnection: EventConnectionType

declare class Game
    info: WorldInstanceInfo
    PlayerConnected: Event
    playerCount: number
    PlayerDisconnected: Event
    players: {Player}
end
declare game: Game

declare class GameServer
    info: WorldInstanceInfo
    isEditor: boolean
    isLoading: boolean
    PlayerConnected: Event
    playerCount: number
    PlayerDisconnected: Event
    players: {Player}
    sceneCount: number
    scenes: {Scene}
    spectatorCount: number
    spectatorScene: Scene
    function GetNetworkObject(self, networkId: number)
    GetMatchMakingPriority: () -> number
    LoadScene: (sceneNameOrId: string | number, additive: boolean) -> Scene
    LoadSceneAdditive: (sceneNameOrId: string | number) -> Scene
    MovePlayerToScene: (player: Player, scene: Scene) -> boolean
    OnWorldEvent: (callback: (eventName: string, isLocal: boolean, payload: any) -> ()?) -> ()
    SendWorldEvent: (eventName: string, eventPayload: any, callback: (error: EmitWorldEventError) -> ()?) -> ()
    SetMatchMakingPriority: (priority: number) -> ()
end
declare server: GameServer

declare class GateFitParameters
end
declare class GateFitParametersType extends Type
end
declare GateFitParameters: GateFitParametersType

declare class IBinding
end
declare class IBindingType extends Type
end
declare IBinding: IBindingType

declare class ICustomStyle
end
declare class ICustomStyleType extends Type
end
declare ICustomStyle: ICustomStyleType

declare class IDragGestureHelper
end
declare class IDragGestureHelperType extends Type
end
declare IDragGestureHelper: IDragGestureHelperType

declare class IEmojiParser
end
declare class IEmojiParserType extends Type
end
declare IEmojiParser: IEmojiParserType

declare class IEventHandler
end
declare class IEventHandlerType extends Type
end
declare IEventHandler: IEventHandlerType

declare class IExperimentalFeatures
end
declare class IExperimentalFeaturesType extends Type
end
declare IExperimentalFeatures: IExperimentalFeaturesType

declare class IFormatProvider
end
declare class IFormatProviderType extends Type
end
declare IFormatProvider: IFormatProviderType

declare class IPanel
    isDirty: boolean
    visualTree: VisualElement
    function GetScaledDisplayHeight(self): number
    function GetScaledDisplayWidth(self): number
    function LocalToWorld(self, point: Vector2): Vector2
    function Pick(self, point: Vector2): VisualElement
    function PickAll(self, point: Vector2, picked: {VisualElement}): VisualElement
    function WorldToLocal(self, point: Vector2): Vector2
end
declare class IPanelType extends Type
end
declare IPanel: IPanelType

declare class IResolvedStyle
end
declare class IResolvedStyleType extends Type
end
declare IResolvedStyle: IResolvedStyleType

declare class IScrollView
end
declare class IScrollViewType extends Type
end
declare IScrollView: IScrollViewType

declare class IStyle
    alignContent: Align
    alignItems: Align
    alignSelf: Align
    backgroundColor: StyleColor
    backgroundImage: Texture2D
    backgroundPositionX: StyleBackgroundPosition
    backgroundPositionY: StyleBackgroundPosition
    backgroundRepeat: StyleBackgroundRepeat
    backgroundSize: StyleBackgroundSize
    borderBottomColor: StyleColor
    borderBottomLeftRadius: StyleLength
    borderBottomRightRadius: StyleLength
    borderBottomWidth: StyleFloat
    borderLeftColor: StyleColor
    borderLeftWidth: StyleFloat
    borderRightColor: StyleColor
    borderRightWidth: StyleFloat
    borderTopColor: StyleColor
    borderTopLeftRadius: StyleLength
    borderTopRightRadius: StyleLength
    borderTopWidth: StyleFloat
    bottom: StyleLength
    color: StyleColor
    display: DisplayStyle
    flexBasis: StyleLength
    flexDirection: FlexDirection
    flexGrow: StyleFloat
    flexShrink: StyleFloat
    flexWrap: Wrap
    fontSize: StyleLength
    height: StyleLength
    justifyContent: Justify
    left: StyleLength
    letterSpacing: StyleLength
    marginBottom: StyleLength
    marginLeft: StyleLength
    marginRight: StyleLength
    marginTop: StyleLength
    maxHeight: StyleLength
    maxWidth: StyleLength
    minHeight: StyleLength
    minWidth: StyleLength
    opacity: StyleFloat
    overflow: Overflow
    paddingBottom: StyleLength
    paddingLeft: StyleLength
    paddingRight: StyleLength
    paddingTop: StyleLength
    position: Position
    right: StyleLength
    rotate: StyleRotate
    scale: StyleScale
    textOverflow: TextOverflow
    textShadow: StyleTextShadow
    top: StyleLength
    transformOrigin: StyleTransformOrigin
    translate: StyleTranslate
    unityBackgroundImageTintColor: StyleColor
    unityFontStyleAndWeight: FontStyle
    unityOverflowClipBox: OverflowClipBox
    unityParagraphSpacing: StyleLength
    unitySliceBottom: StyleInt
    unitySliceLeft: StyleInt
    unitySliceRight: StyleInt
    unitySliceScale: StyleFloat
    unitySliceTop: StyleInt
    unityTextAlign: TextAnchor
    unityTextOutlineColor: StyleColor
    unityTextOutlineWidth: StyleFloat
    unityTextOverflowPosition: TextOverflowPosition
    visibility: Visibility
    whiteSpace: WhiteSpace
    width: StyleLength
    wordSpacing: StyleLength
end
declare class IStyleType extends Type
end
declare IStyle: IStyleType

declare class ITextEdition
end
declare class ITextEditionType extends Type
end
declare ITextEdition: ITextEditionType

declare class ITextElementExperimentalFeatures
end
declare class ITextElementExperimentalFeaturesType extends Type
end
declare ITextElementExperimentalFeatures: ITextElementExperimentalFeaturesType

declare class ITextSelection
end
declare class ITextSelectionType extends Type
end
declare ITextSelection: ITextSelectionType

declare class ITransform
end
declare class ITransformType extends Type
end
declare ITransform: ITransformType

declare class IVisualElementScheduler
end
declare class IVisualElementSchedulerType extends Type
end
declare IVisualElementScheduler: IVisualElementSchedulerType

declare class IntPtr
end
declare class IntPtrType extends Type
end
declare IntPtr: IntPtrType

declare class IntValue
    Changed: Event
    value: number
end
declare class IntValueType extends Type
    new: (name: string) -> IntValue
    new: (name: string, initialValue: number) -> IntValue
    new: (name: string, initialValue: number, player: Player) -> IntValue
end
declare IntValue: IntValueType

declare class Inventory
    CommitTransaction: (transaction: InventoryTransaction) -> ()
    CommitTransaction: (transaction: InventoryTransaction, callback: (transactionId: string, error: InventoryError) -> ()) -> ()
    GetItem: (holderId: string, itemId: string, callback: (item: InventoryItem, error: InventoryError) -> ()) -> ()
    GetItems: (holderId: string, limit: number, cursorId: string?, callback: (items: {InventoryItem}, cursorId: string, error: InventoryError) -> ()) -> ()
    GetPlayerItem: (player: Player, itemId: string, callback: (item: InventoryItem, error: InventoryError) -> ()) -> ()
    GetPlayerItems: (player: Player, limit: number, cursorId: string?, callback: (items: {InventoryItem}, cursorId: string, error: InventoryError) -> ()) -> ()
    RollbackTransaction: (transactionId: string) -> ()
    RollbackTransaction: (transactionId: string, callback: (error: InventoryError) -> ()) -> ()
end
declare Inventory: Inventory

declare class InventoryError
end
declare class InventoryErrorType extends Type
    Count: InventoryError
    CursorInvalid: InventoryError
    CursorInvalidLimit: InventoryError
    CursorNoMoreValues: InventoryError
    InternalError: InventoryError
    InvalidHolderId: InventoryError
    InvalidItemId: InventoryError
    InvalidReservationId: InventoryError
    NoActions: InventoryError
    None: InventoryError
    RequestThrottled: InventoryError
    Timeout: InventoryError
    TooManyActions: InventoryError
    TransactionError: InventoryError
    UnknownError: InventoryError
    UnknownTransaction: InventoryError
end
declare InventoryError: InventoryErrorType

declare class InventoryItem
    amount: number
    available: number
    createdAt: number
    holderId: string
    id: string
    reservations: {InventoryReservation}
    updatedAt: number
end
declare class InventoryItemType extends Type
end
declare InventoryItem: InventoryItemType

declare class InventoryReservation
    amount: number
    reservedFor: string
end
declare class InventoryReservationType extends Type
end
declare InventoryReservation: InventoryReservationType

declare class InventoryTransaction
    function Give(self, holderId: string, itemId: string, quantity: number): InventoryTransaction
    function GivePlayer(self, player: Player, itemId: string, quantity: number): InventoryTransaction
    function Move(self, fromHolderId: string, toHolderId: string, itemId: string, quantity: number): InventoryTransaction
    function MovePlayers(self, fromPlayer: Player, toPlayer: Player, itemId: string, quantity: number): InventoryTransaction
    function Release(self, holderId: string, itemId: string, reservedFor: string, quantity: number): InventoryTransaction
    function ReleasePlayer(self, player: Player, itemId: string, reservedFor: string, quantity: number): InventoryTransaction
    function Reserve(self, holderId: string, itemId: string, reservedFor: string, quantity: number): InventoryTransaction
    function ReservePlayer(self, player: Player, itemId: string, reservedFor: string, quantity: number): InventoryTransaction
    function Take(self, holderId: string, itemId: string, quantity: number): InventoryTransaction
    function TakePlayer(self, player: Player, itemId: string, quantity: number): InventoryTransaction
end
declare class InventoryTransactionType extends Type
    new: () -> InventoryTransaction
end
declare InventoryTransaction: InventoryTransactionType

declare class Leaderboard
    DeleteEntry: (leaderboardId: string, entryId: string, callback: (error: LeaderboardError) -> ()) -> ()
    DeleteEntryForPlayer: (leaderboardId: string, player: Player, callback: (error: LeaderboardError) -> ()) -> ()
    GetEntries: (leaderboardId: string, fromRank: number, limit: number, callback: (entries: {LeaderboardEntry}, error: LeaderboardError) -> ()) -> ()
    GetEntry: (leaderboardId: string, entryId: string, callback: (entry: LeaderboardEntry, error: LeaderboardError) -> ()) -> ()
    GetEntryForPlayer: (leaderboardId: string, player: Player, callback: (entry: LeaderboardEntry, error: LeaderboardError) -> ()) -> ()
    IncrementScore: (leaderboardId: string, entryId: string, name: string, score: number, callback : (entry: LeaderboardEntry, error: LeaderboardError) -> ()) -> ()
    IncrementScoreForPlayer: (leaderboardId: string, player: Player, score: number, callback: (entry: LeaderboardEntry, error: LeaderboardError) -> ()) -> ()
    Reset: (leaderboardId: string, callback : (error: LeaderboardError) -> ()) -> ()
    SetScore: (leaderboardId: string, entryId: string, name: string, score: number, callback : (entry: LeaderboardEntry, error: LeaderboardError) -> ()) -> ()
    SetScoreForPlayer: (leaderboardId: string, player: Player, score: number, callback: (entry: LeaderboardEntry, error: LeaderboardError) -> ()) -> ()
end
declare Leaderboard: Leaderboard

declare class LeaderboardEntry
    id: string
    name: string
    rank: number
    score: number
end
declare class LeaderboardEntryType extends Type
end
declare LeaderboardEntry: LeaderboardEntryType

declare class LeaderboardError
end
declare class LeaderboardErrorType extends Type
    Count: LeaderboardError
    InternalError: LeaderboardError
    InvalidEntryID: LeaderboardError
    InvalidEntryName: LeaderboardError
    InvalidID: LeaderboardError
    None: LeaderboardError
    RequestThrottled: LeaderboardError
    Timeout: LeaderboardError
end
declare LeaderboardError: LeaderboardErrorType

declare class LuaObject
end
declare class LuaObjectType extends Type
end
declare LuaObject: LuaObjectType

declare class Mathf
    Abs: (value: number) -> number
    Acos: (f: number) -> number
    Approximately: (a: number, b: number) -> boolean
    Asin: (f: number) -> number
    Atan: (f: number) -> number
    Atan2: (y: number, x: number) -> number
    Ceil: (f: number) -> number
    CeilToInt: (f: number) -> number
    Clamp: (value: number, min: number, max: number) -> number
    Clamp01: (value: number) -> number
    ClosestPowerOfTwo: (value: number) -> number
    Cos: (a: number) -> number
    Deg2Rad: number
    DeltaAngle: (current: number, target: number) -> number
    Epsilon: number
    Exp: (power: number) -> number
    Floor: (f: number) -> number
    Infinity: number
    InverseLerp: (a: number, b: number, value: number) -> number
    IsPowerOfTwo: (value: number) -> boolean
    Lerp: (a: number, b: number, t: number) -> number
    LerpAngle: (a: number, b: number, t: number) -> number
    LerpUnclamped: (a: number, b: number, t: number) -> number
    Log: (f: number) -> number
    Log10: (f: number) -> number
    Max: (a: number, b: number) -> number
    Min: (a: number, b: number) -> number
    MoveTowards: (current: number, target: number, maxDelta: number) -> number
    MoveTowardsAngle: (current: number, target: number, maxDelta: number) -> number
    NegativeInfinity: number
    NextPowerOfTwo: (value: number) -> number
    PI: number
    PingPong: (t: number, length: number) -> number
    Pow: (f: number, p: number) -> number
    Rad2Deg: number
    Repeat: (t: number, length: number) -> number
    Round: (f: number) -> number
    Sign: (a: number) -> number
    Sin: (a: number) -> number
    SmoothDamp: (current: number, target: number, currentV: number, smoothTime: number, maxS: number, deltaTime: number) -> (number, number)
    SmoothDampAngle: (current: number, target: number, currentV: number, smoothTime: number, maxS: number, deltaTime: number) -> (number, number)
    SmoothStep: (from: number, to: number, t: number) -> number
    Sqrt: (f: number) -> number
    Tan: (a: number) -> number
end
declare Mathf: Mathf

declare class Moderation
    infiniteDuration: number
    OnBan: Event
    OnKick: Event
    OnMute: Event
    OnUnban: Event
    OnUnmute: Event
    Ban: (userId: string, durationSeconds: number, message: string?, callback: (error: ModerationError) -> ()?) -> ()
    BanPlayer: (player: Player, durationSeconds: number, message: string?, callback: (error: ModerationError) -> ()?) -> ()
    GetBannedUsers: (limit: number, cursorId: string?, callback: (userBans: {UserBan}, cursorId: string, error: ModerationError) -> ()) -> ()
    Kick: (userId: string, callback: (error: ModerationError) -> ()?) -> ()
    KickPlayer: (player: Player, callback: (error: ModerationError) -> ()?) -> ()
    Mute: (userId: string, durationSeconds: number, callback: (error: ModerationError) -> ()?) -> ()
    MutePlayer: (player: Player, durationSeconds: number, callback: (error: ModerationError) -> ()?) -> ()
    Unban: (userId: string, callback: (error: ModerationError) -> ()?) -> ()
    Unmute: (userId: string, callback: (error: ModerationError) -> ()?) -> ()
    UnmutePlayer: (player: Player, callback: (error: ModerationError) -> ()?) -> ()
end
declare Moderation: Moderation

declare class ModerationError
end
declare class ModerationErrorType extends Type
    Count: ModerationError
    CursorInvalid: ModerationError
    CursorInvalidLimit: ModerationError
    InsufficientPermissions: ModerationError
    InternalError: ModerationError
    InvalidUserId: ModerationError
    None: ModerationError
    RequestThrottled: ModerationError
    Timeout: ModerationError
    UnknownError: ModerationError
end
declare ModerationError: ModerationErrorType

declare class NumberValue
    Changed: Event
    value: number
end
declare class NumberValueType extends Type
    new: (name: string) -> NumberValue
    new: (name: string, initialValue: number) -> NumberValue
    new: (name: string, initialValue: number, player: Player) -> NumberValue
end
declare NumberValue: NumberValueType

declare class Object
    name: string
    function __eq(self, y: Object): boolean
    function __tostring(self): string
end
declare class ObjectType extends Type
    Destroy: ((obj: Object) -> ())
    Destroy: ((obj: Object, t: number) -> ())
    Destroy: (obj: Object) -> ()
    DestroyImmediate: ((obj: Object) -> ())
    DestroyImmediate: ((obj: Object, allowDestroyAssets: boolean) -> ())
    FindAnyObjectByType: ((type: Type) -> Object)
    FindFirstObjectByType: ((type: Type) -> Object)
    FindObjectOfType: ((type: Type) -> Object)
    FindObjectOfType: ((type: Type, includeInactive: boolean) -> Object)
    FindObjectsOfType: ((type: Type) -> {Object})
    FindObjectsOfType: ((type: Type, includeInactive: boolean) -> {Object})
    Instantiate: <T>(original: T) -> T
    Instantiate: <T>(original: T, position: Vector3) -> T
    Instantiate: <T>(original: T, position: Vector3, rotation: Quaternion) -> T
end
declare Object: ObjectType

declare class PanGestureEvent
end
declare class PanGestureEventType extends Type
end
declare PanGestureEvent: PanGestureEventType

declare class PaymentsError
end
declare class PaymentsErrorType extends Type
    CursorInvalid: PaymentsError
    CursorInvalidLimit: PaymentsError
    CursorNoMoreValues: PaymentsError
    InternalError: PaymentsError
    InvalidProductId: PaymentsError
    InvalidPurchaseId: PaymentsError
    InvalidUserId: PaymentsError
    None: PaymentsError
    PurchaseAlreadyAcknowledged: PaymentsError
    RequestThrottled: PaymentsError
    UnknownPayment: PaymentsError
end
declare PaymentsError: PaymentsErrorType

declare class QuaternionValue
    Changed: Event
    value: Quaternion
end
declare class QuaternionValueType extends Type
    new: (name: string) -> QuaternionValue
    new: (name: string, initialValue: Quaternion) -> QuaternionValue
    new: (name: string, initialValue: Quaternion, player: Player) -> QuaternionValue
end
declare QuaternionValue: QuaternionValueType

declare class RemoteFunction
    name: string
    OnInvokeClient: (...any) -> any
    OnInvokeServer: ((player: Player, ...any) -> any)
    function InvokeClient(self, player: Player, ...: any)
    function InvokeServer(self, ...: any)
end
declare class RemoteFunctionType extends Type
    new: (string) -> RemoteFunction
end
declare RemoteFunction: RemoteFunctionType

declare class Single
end
declare class SingleType extends Type
end
declare Single: SingleType

declare class StorageError
end
declare class StorageErrorType extends Type
    AttributesTooLarge: StorageError
    ConcurrentModification: StorageError
    Count: StorageError
    CursorInvalid: StorageError
    CursorInvalidLimit: StorageError
    CursorNoMoreValues: StorageError
    InternalError: StorageError
    InvalidAttributes: StorageError
    InvalidKey: StorageError
    InvalidValue: StorageError
    None: StorageError
    RequestThrottled: StorageError
    Timeout: StorageError
    TooManyQueuedUpdates: StorageError
    UnknownError: StorageError
    ValueTooLarge: StorageError
end
declare StorageError: StorageErrorType

declare class StringValue
    Changed: Event
    value: string
end
declare class StringValueType extends Type
    new: (name: string) -> StringValue
    new: (name: string, initialValue: string) -> StringValue
    new: (name: string, initialValue: string, player: Player) -> StringValue
end
declare StringValue: StringValueType

declare class StyleEnum
end
declare class StyleEnumType extends Type
end
declare StyleEnum: StyleEnumType

declare class TableValue
    Changed: Event
    value: {any}
end
declare class TableValueType extends Type
    new: (name: string) -> TableValue
    new: (name: string, initialValue: {any}) -> TableValue
    new: (name: string, initialValue: {any}, player: Player) -> TableValue
end
declare TableValue: TableValueType

declare class Time
    deltaTime: number
    fixedDeltaTime: number
    serverTime: number
    time: number
end
declare Time: Time

declare class Timer
    enabled: boolean
    interval: number
    function Restart(self)
    function SetEnabled(self, enabled: boolean)
    function Start(self)
    function Stop(self)
end
declare class TimerType extends Type
    After: ((interval: number, callback: () -> ()) -> Timer)
    Every: ((interval: number, callback: () -> ()) -> Timer)
    new: ((interval: number, callback: () -> (), repeats: boolean) -> Timer)
end
declare Timer: TimerType

declare class UICollectionLayout
end
declare class UICollectionLayoutType extends Type
end
declare UICollectionLayout: UICollectionLayoutType

declare class User
    id: string
    isAgeVerifiedAbove18: boolean
    isSubscriber: boolean
    name: string
end
declare class UserType extends Type
end
declare User: UserType

declare class UserBan
    bannedBy: User
    createdAt: number
    expiresAt: number
    message: string
    user: User
end
declare class UserBanType extends Type
end
declare UserBan: UserBanType

declare class ValueType
end
declare class ValueTypeType extends Type
end
declare ValueType: ValueTypeType

declare class Vector2Value
    Changed: Event
    value: Vector2
end
declare class Vector2ValueType extends Type
    new: (name: string) -> Vector2Value
    new: (name: string, initialValue: Vector2) -> Vector2Value
    new: (name: string, initialValue: Vector2, player: Player) -> Vector2Value
end
declare Vector2Value: Vector2ValueType

declare class Vector3Value
    Changed: Event
    value: Vector3
end
declare class Vector3ValueType extends Type
    new: (name: string) -> Vector3Value
    new: (name: string, initialValue: Vector3) -> Vector3Value
    new: (name: string, initialValue: Vector3, player: Player) -> Vector3Value
end
declare Vector3Value: Vector3ValueType

declare class Wallet
    GetWallet: (callback: (wallet: WalletState, error: WalletError) -> ()) -> ()
    TransferGold: (userId: string, amount: number, callback: (wallet: WalletState, error: WalletError) -> ()) -> ()
    TransferGoldToPlayer: (player: Player, amount: number, callback: (wallet: WalletState, error: WalletError) -> ()) -> ()
end
declare Wallet: Wallet

declare class WalletError
end
declare class WalletErrorType extends Type
    InsufficientResources: InventoryError
    InternalError: InventoryError
    None: InventoryError
    RequestThrottled: InventoryError
    UserNotFound: InventoryError
end
declare WalletError: WalletErrorType

declare class WalletState
    earnedGold: number
    gold: number
end
declare class WalletStateType extends Type
end
declare WalletState: WalletStateType

declare class WorldInstanceInfo
    allowsSpectating: boolean
    creatorId: string
    isOwnedRoom: boolean
    isPrivate: boolean
    locale: string
    maxPlayers: number
    ownerId: string
    roomId: string
    worldId: string
end
declare class WorldInstanceInfoType extends Type
end
declare WorldInstanceInfo: WorldInstanceInfoType

declare class Angle extends ValueType
    unit: AngleUnit
    value: number
    function __eq(self, rhs: Angle): boolean
    function __tostring(self): string
    function Equals(self, other: Angle): boolean
    function ToDegrees(self): number
    function ToGradians(self): number
    function ToRadians(self): number
    function ToTurns(self): number
end
declare class AngleType extends ValueTypeType
    Degrees: ((value: number) -> Angle)
    Gradians: ((value: number) -> Angle)
    new: ((value: number) -> Angle)
    new: ((value: number, unit: AngleUnit) -> Angle)
    Radians: ((value: number) -> Angle)
    Turns: ((value: number) -> Angle)
end
declare Angle: AngleType

declare class AnimationCurve extends Object
    length: number
    function __tostring(self): string
    function AddKey(self, time: number, value: number): number
    function ClearKeys(self)
    function CopyFrom(self, other: AnimationCurve)
    function Equals(self, other: AnimationCurve): boolean
    function Evaluate(self, time: number): number
    function RemoveKey(self, index: number)
    function SmoothTangents(self, index: number, weight: number)
end
declare class AnimationCurveType extends ObjectType
    Constant: ((timeStart: number, timeEnd: number, value: number) -> AnimationCurve)
    EaseInOut: ((timeStart: number, valueStart: number, timeEnd: number, valueEnd: number) -> AnimationCurve)
    Linear: ((timeStart: number, valueStart: number, timeEnd: number, valueEnd: number) -> AnimationCurve)
end
declare AnimationCurve: AnimationCurveType

declare class AnimationEvent extends Object
    animatorStateInfo: AnimatorStateInfo
    floatParameter: number
    functionName: string
    intParameter: number
    isFiredByAnimator: boolean
    isFiredByLegacy: boolean
    objectReferenceParameter: Object
    stringParameter: string
    time: number
    function __tostring(self): string
end
declare class AnimationEventType extends ObjectType
end
declare AnimationEvent: AnimationEventType

declare class AnimatorStateInfo extends ValueType
    fullPathHash: number
    length: number
    loop: boolean
    normalizedTime: number
    shortNameHash: number
    speed: number
    speedMultiplier: number
    tagHash: number
    function __tostring(self): string
    function IsName(self, name: string): boolean
    function IsTag(self, tag: string): boolean
end
declare class AnimatorStateInfoType extends ValueTypeType
end
declare AnimatorStateInfo: AnimatorStateInfoType

declare class Audio extends Object
    isPlaying: boolean
    musicIntensity: number
    musicLength: number
    musicTime: number
    musicVolume: number
    function __tostring(self): string
    function DuckMusic(self, duration: number, duckOutDuration: number, duckInDuration: number)
    function GetMusicIntensity(self, low: number, high: number, normalizeVolume: boolean): number
    function PlayMusic(self, shader: AudioShader, volume: number)
    function PlayMusic(self, shader: AudioShader, volume: number, fadeIn: boolean)
    function PlayMusic(self, shader: AudioShader, volume: number, fadeIn: boolean, loop: boolean)
    function PlayMusicURL(self, url: string, volume: number)
    function PlayMusicURL(self, url: string, volume: number, fadeIn: boolean)
    function PlayShader(self, shader: AudioShader)
    function PlaySound(self, shader: AudioShader, gameObject: GameObject, volume: number, pitch: number, spatialize: boolean, loop: boolean): AudioSource
    function PlaySoundGlobal(self, shader: AudioShader, volume: number, pitch: number, loop: boolean): AudioSource
    function SetListenerPositionAndRotation(self, position: Vector3, rotation: Quaternion)
    function StopAudioSource(self, source: AudioSource)
    function StopMusic(self, fadeOut: boolean)
end
declare Audio: Audio

declare class AudioClip extends Object
    channels: number
    frequency: number
    length: number
    loadInBackground: boolean
    preloadAudioData: boolean
    samples: number
    function __tostring(self): string
    function LoadAudioData(self): boolean
    function UnloadAudioData(self): boolean
end
declare class AudioClipType extends ObjectType
end
declare AudioClip: AudioClipType

declare class BackgroundPosition extends ValueType
    keyword: BackgroundPositionKeyword
    offset: Length
    function __eq(self, style2: BackgroundPosition): boolean
    function __tostring(self): string
    function Equals(self, other: BackgroundPosition): boolean
end
declare class BackgroundPositionType extends ValueTypeType
    new: ((keyword: BackgroundPositionKeyword) -> BackgroundPosition)
    new: ((keyword: BackgroundPositionKeyword, offset: Length) -> BackgroundPosition)
end
declare BackgroundPosition: BackgroundPositionType

declare class BackgroundRepeat extends ValueType
    x: Repeat
    y: Repeat
    function __eq(self, style2: BackgroundRepeat): boolean
    function __tostring(self): string
    function Equals(self, other: BackgroundRepeat): boolean
end
declare class BackgroundRepeatType extends ValueTypeType
    new: ((repeatX: Repeat, repeatY: Repeat) -> BackgroundRepeat)
end
declare BackgroundRepeat: BackgroundRepeatType

declare class BackgroundSize extends ValueType
    sizeType: BackgroundSizeType
    x: Length
    y: Length
    function __eq(self, style2: BackgroundSize): boolean
    function __tostring(self): string
    function Equals(self, other: BackgroundSize): boolean
end
declare class BackgroundSizeType extends ValueTypeType
    new: ((sizeType: BackgroundSizeType) -> BackgroundSize)
    new: ((sizeX: Length, sizeY: Length) -> BackgroundSize)
end
declare BackgroundSize: BackgroundSizeType

declare class Bounds extends ValueType
    center: Vector3
    extents: Vector3
    max: Vector3
    min: Vector3
    size: Vector3
    function __eq(self, rhs: Bounds): boolean
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function ClosestPoint(self, point: Vector3): Vector3
    function Contains(self, point: Vector3): boolean
    function Encapsulate(self, bounds: Bounds)
    function Encapsulate(self, point: Vector3)
    function Equals(self, other: Bounds): boolean
    function Expand(self, amount: number)
    function Expand(self, amount: Vector3)
    function IntersectRay(self, ray: Ray): boolean
    function Intersects(self, bounds: Bounds): boolean
    function SetMinMax(self, min: Vector3, max: Vector3)
    function SqrDistance(self, point: Vector3): number
end
declare class BoundsType extends ValueTypeType
    new: ((center: Vector3, size: Vector3) -> Bounds)
end
declare Bounds: BoundsType

declare class Callback extends Object
end
declare class CallbackType extends ObjectType
end
declare Callback: CallbackType

declare class CallbackEventHandler extends Object
    function __tostring(self): string
    function HasBubbleUpHandlers(self): boolean
    function HasTrickleDownHandlers(self): boolean
    function SendEvent(self, e: EventBase)
end
declare class CallbackEventHandlerType extends ObjectType
end
declare CallbackEventHandler: CallbackEventHandlerType

declare class ChannelInfo extends Object
    activePlayers: {Player}
    allowsText: boolean
    allowsVoice: boolean
    channelId: number
    isActive: boolean
    isJoined: boolean
    isWhisperChannel: boolean
    maxVolumeDistance: number
    minVolumeDistance: number
    name: string
    players: {Player}
    priority: number
    proximityChatEnabled: boolean
    speakerFilter: (player: Player) -> boolean
    function DisableProximityChat(self)
    function EnableProximityChat(self, maxVolumeDistance: number, minVolumeDistance: number)
    function IsPlayerActiveChannel(self, player: Player): boolean
    function IsPlayerInChannel(self, player: Player): boolean
end
declare class ChannelInfoType extends ObjectType
end
declare ChannelInfo: ChannelInfoType

declare class CharacterAnimationEvent extends Object
    functionName: string
    name: string
end
declare class CharacterAnimationEventType extends ObjectType
end
declare CharacterAnimationEvent: CharacterAnimationEventType

declare class CharacterClothing extends Object
    color: number
    id: string
end
declare class CharacterClothingType extends ObjectType
    new: ((descriptorId: string) -> CharacterClothing)
    new: ((descriptorId: string, paletteId: number) -> CharacterClothing)
end
declare CharacterClothing: CharacterClothingType

declare class Chat extends Object
    activeChannel: ChannelInfo
    allChannels: {ChannelInfo}
    ChannelDestroyed: Event
    function AddPlayerToChannel(self, channelInfo: ChannelInfo, player: Player)
    function CreateChannel(self, channelName: string, allowsText: boolean, allowsVoice: boolean): ChannelInfo
    function CreateChannel(self, channelName: string, allowsText: boolean, allowsVoice: boolean, priority: number): ChannelInfo
    function DestroyChannel(self, channelInfo: ChannelInfo)
    function ReapplyFilters(self, player: Player)
    function RemovePlayerFromChannel(self, channelInfo: ChannelInfo, player: Player)
    function SetActiveChannel(self, channelInfo: ChannelInfo, player: Player)
    joinedChannels: {ChannelInfo}
    PlayerJoinedChannel: Event
    PlayerLeftChannel: Event
    TextMessageReceivedHandler: Event
    WhisperReceivedHandler: Event
    function ApplyVideoToSurface(self, userId: string, go: GameObject)
    function DisableVideo(self)
    function DisplayChatBubble(self, position: Transform, message: string)
    function DisplayChatBubble(self, position: Transform, message: string, name: string)
    function DisplayTextMessage(self, channel: ChannelInfo, from: Player, message: string, language: string)
    function EnableVideo(self)
    function GetChannel(self, channelName: string): ChannelInfo
end
declare Chat: Chat

declare class Collision extends Object
    body: Component
    collider: Collider
    contactCount: number
    contacts: {ContactPoint}
    gameObject: GameObject
    impulse: Vector3
    relativeVelocity: Vector3
    rigidbody: Rigidbody
    transform: Transform
    function __tostring(self): string
    function GetContact(self, index: number): ContactPoint
end
declare class CollisionType extends ObjectType
end
declare Collision: CollisionType

declare class Color extends ValueType
    a: number
    b: number
    g: number
    gamma: Color
    grayscale: number
    linear: Color
    maxColorComponent: number
    r: number
    function __add(self, b: Color): Color
    function __div(self, b: number): Color
    function __eq(self, rhs: Color): boolean
    function __mul(self, b: Color): Color
    function __mul(self, b: number): Color
    function __sub(self, b: Color): Color
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function Alpha(self, a: number): Color
    function Equals(self, other: Color): boolean
    function MultiplyAlpha(self, a: number): Color
    function ToHex(self): string
    function ToLuma(self): number
end
declare class ColorType extends ValueTypeType
    black: Color
    blue: Color
    clear: Color
    cyan: Color
    gray: Color
    green: Color
    grey: Color
    magenta: Color
    red: Color
    white: Color
    yellow: Color
    __mul: ((b: number, a: Color) -> Color)
    HSVToRGB: ((H: number, S: number, V: number) -> Color)
    HSVToRGB: ((H: number, S: number, V: number, hdr: boolean) -> Color)
    Lerp: ((a: Color, b: Color, t: number) -> Color)
    LerpUnclamped: ((a: Color, b: Color, t: number) -> Color)
    new: ((r: number, g: number, b: number) -> Color)
    new: ((r: number, g: number, b: number, a: number) -> Color)
    RGBToHSV: ((rgbColor: Color) -> (number, number, number))
end
declare Color: ColorType

declare class ColorUtility extends Object
    function __tostring(self): string
end
declare class ColorUtilityType extends ObjectType
    ToHtmlStringRGB: ((color: Color) -> string)
    ToHtmlStringRGBA: ((color: Color) -> string)
    TryParseHtmlString: ((htmlString: string) -> (boolean, Color))
end
declare ColorUtility: ColorUtilityType

declare class Component extends Object
    gameObject: GameObject
    tag: string
    transform: Transform
    function __tostring(self): string
    function CompareTag(self, tag: string): boolean
    function GetComponent(self, type: ComponentType): Component
    function GetComponentInChildren(self, t: ComponentType): Component
    function GetComponentInChildren(self, t: ComponentType, includeInactive: boolean): Component
    function GetComponentIndex(self): number
    function GetComponentInParent(self, t: ComponentType): Component
    function GetComponentInParent(self, t: ComponentType, includeInactive: boolean): Component
    function GetComponents(self, type: ComponentType): {Component}
    function GetComponentsInChildren(self, t: ComponentType): {Component}
    function GetComponentsInChildren(self, t: ComponentType, includeInactive: boolean): {Component}
    function GetComponentsInParent(self, t: ComponentType): {Component}
    function GetComponentsInParent(self, t: ComponentType, includeInactive: boolean): {Component}
    function SendMessage(self, methodName: string)
    function SendMessageUpwards(self, methodName: string)
end
declare class ComponentType extends ObjectType
end
declare Component: ComponentType

declare class ContactPoint extends ValueType
    impulse: Vector3
    normal: Vector3
    otherCollider: Collider
    point: Vector3
    separation: number
    thisCollider: Collider
    function __tostring(self): string
end
declare class ContactPointType extends ValueTypeType
end
declare ContactPoint: ContactPointType

declare class DragGestureBegan extends PanGestureEvent
    deltaPosition: Vector2
    eventTypeId: number
    position: Vector2
    screenPosition: Vector2
    screenStartPosition: Vector2
    startPosition: Vector2
    velocity: Vector2
    function __tostring(self): string
end
declare class DragGestureBeganType extends PanGestureEventType
end
declare DragGestureBegan: DragGestureBeganType

declare class DragGestureChanged extends PanGestureEvent
    deltaPosition: Vector2
    eventTypeId: number
    position: Vector2
    screenPosition: Vector2
    screenStartPosition: Vector2
    startPosition: Vector2
    velocity: Vector2
    function __tostring(self): string
end
declare class DragGestureChangedType extends PanGestureEventType
end
declare DragGestureChanged: DragGestureChangedType

declare class DragGestureEnded extends PanGestureEvent
    cancelled: boolean
    deltaPosition: Vector2
    eventTypeId: number
    position: Vector2
    screenPosition: Vector2
    screenStartPosition: Vector2
    startPosition: Vector2
    velocity: Vector2
    function __tostring(self): string
end
declare class DragGestureEndedType extends PanGestureEventType
end
declare DragGestureEnded: DragGestureEndedType

declare class Easing extends Object
end
declare class EasingType extends ObjectType
    Back: ((t: number, p: number) -> number)
    Bounce: ((t: number, bounces: number, bounciness: number) -> number)
    Circle: ((t: number) -> number)
    Cubic: ((t: number) -> number)
    CubicBezier: ((t: number, x1: number, y1: number, x2: number, y2: number) -> number)
    Elastic: ((t: number, oscillations: number, springiness: number) -> number)
    Exponential: ((t: number, p: number) -> number)
    Quadratic: ((t: number) -> number)
    Sine: ((t: number) -> number)
end
declare Easing: EasingType

declare class Enum extends ValueType
    function __tostring(self): string
    function __tostring(self, format: string): string
    function HasFlag(self, flag: Enum): boolean
end
declare class EnumType extends ValueTypeType
    GetNames: ((enumType: Type) -> {string})
    GetUnderlyingType: ((enumType: Type) -> Type)
end
declare Enum: EnumType

declare class EventBase extends Object
    bubbles: boolean
    currentTarget: IEventHandler
    dispatch: boolean
    eventTypeId: number
    isDefaultPrevented: boolean
    isImmediatePropagationStopped: boolean
    isPropagationStopped: boolean
    originalMousePosition: Vector2
    target: IEventHandler
    timestamp: number
    tricklesDown: boolean
    function __tostring(self): string
    function PreventDefault(self)
    function StopImmediatePropagation(self)
    function StopPropagation(self)
end
declare class EventBaseType extends ObjectType
end
declare EventBase: EventBaseType

declare class GameClient extends Object
    FocusGained: Event
    FocusLost: Event
    info: WorldInstanceInfo
    isEditor: boolean
    isoRoomContext: WorldRoomContext
    localPlayer: Player
    mainCamera: Camera
    PlayerConnected: Event
    playerCount: number
    PlayerDisconnected: Event
    players: {Player}
    Reset: Event
    worldBounds: Bounds
    function GetNetworkObject(self, networkId: number)
end
declare client: GameClient

declare class GameObject extends Object
    activeInHierarchy: boolean
    activeSelf: boolean
    gameObject: GameObject
    isStatic: boolean
    layer: number
    sceneCullingMask: number
    tag: string
    transform: Transform
    function __tostring(self): string
    function AddComponent(self, type: ComponentType): Component
    function AddScript(self, script: LuaScript): LuaBehaviour
    function CompareTag(self, tag: string): boolean
    function GetComponent(self, type: ComponentType): Component
    function GetComponentAtIndex(self, index: number): Component
    function GetComponentCount(self): number
    function GetComponentInChildren(self, type: ComponentType, includeInactive: boolean): Component
    function GetComponentIndex(self, component: Component): number
    function GetComponentInParent(self, type: ComponentType, includeInactive: boolean): Component
    function GetComponents(self, type: ComponentType): {Component}
    function GetComponentsInChildren(self, type: ComponentType, includeInactive: boolean): {Component}
    function GetComponentsInParent(self, type: ComponentType, includeInactive: boolean): {Component}
    function SetActive(self, value: boolean)
end
declare class GameObjectType extends ObjectType
    Find: ((name: string) -> GameObject)
    FindGameObjectsWithTag: ((tag: string) -> {GameObject})
    FindGameObjectWithTag: ((tag: string) -> GameObject)
    FindWithTag: ((tag: string) -> GameObject)
    new: (() -> GameObject)
    new: ((name: string) -> GameObject)
    new: ((name: string, components: {Type}) -> GameObject)
end
declare GameObject: GameObjectType

declare class Gesture extends Object
    target: VisualElement
end
declare class GestureType extends ObjectType
end
declare Gesture: GestureType

declare class Gradient extends Object
    function __tostring(self): string
    function Equals(self, other: Gradient): boolean
    function Evaluate(self, time: number): Color
end
declare class GradientType extends ObjectType
end
declare Gradient: GradientType

declare class Input extends Object
    client: GameClient
    inputPanel: IPanel
    isAltPressed: boolean
    isMouseInput: boolean
    LongPressBegan: Event
    LongPressContinue: Event
    LongPressEnded: Event
    MouseWheel: Event
    PinchOrDragBegan: Event
    PinchOrDragChanged: Event
    PinchOrDragEnded: Event
    Tapped: Event
    function __tostring(self): string
end
declare Input: Input

declare class InputAction extends Object
    actionMap: InputActionMap
    enabled: boolean
    expectedControlType: string
    inProgress: boolean
    interactions: string
    name: string
    processors: string
    triggered: boolean
    wantsInitialStateCheck: boolean
    function __tostring(self): string
    function Clone(self): InputAction
    function Disable(self)
    function Enable(self)
    function GetTimeoutCompletionPercentage(self): number
    function IsInProgress(self): boolean
    function IsPressed(self): boolean
    function ReadVector2(self): Vector2
    function Reset(self)
    function WasPerformedThisFrame(self): boolean
    function WasPressedThisFrame(self): boolean
    function WasReleasedThisFrame(self): boolean
end
declare class InputActionType extends ObjectType
    new: (() -> InputAction)
end
declare InputAction: InputActionType

declare class InputActionMap extends Object
    enabled: boolean
    name: string
    function __tostring(self): string
    function Clone(self): InputActionMap
    function Contains(self, action: InputAction): boolean
    function Disable(self)
    function Enable(self)
    function FindAction(self, actionNameOrId: string): InputAction
    function FindAction(self, actionNameOrId: string, throwIfNotFound: boolean): InputAction
    function OnAfterDeserialize(self)
    function OnBeforeSerialize(self)
    function ToJson(self): string
end
declare class InputActionMapType extends ObjectType
    FromJson: ((json: string) -> {InputActionMap})
    new: (() -> InputActionMap)
    new: ((name: string) -> InputActionMap)
end
declare InputActionMap: InputActionMapType

declare class InventoryManager extends Object
    inventoryChanged: Event
    function __tostring(self): string
end
declare class InventoryManagerType extends ObjectType
end
declare InventoryManager: InventoryManagerType

declare class LayerMask extends ValueType
    value: number
    function __tostring(self): string
end
declare class LayerMaskType extends ValueTypeType
    GetMask: ((layerNames: {string}) -> number)
    LayerToName: ((layer: number) -> string)
    NameToLayer: ((layerName: string) -> number)
end
declare LayerMask: LayerMaskType

declare class Length extends ValueType
    value: number
    function __eq(self, rhs: Length): boolean
    function __tostring(self): string
    function Equals(self, other: Length): boolean
    function IsAuto(self): boolean
    function IsNone(self): boolean
end
declare class LengthType extends ValueTypeType
    Auto: (() -> Length)
    new: ((value: number) -> Length)
    None: (() -> Length)
    Percent: ((value: number) -> Length)
end
declare Length: LengthType

declare class Localization extends Object
    function __tostring(self): string
end
declare class LocalizationType extends ObjectType
    TryGetString: ((key: string) -> (boolean, LocalizedString))
end
declare Localization: LocalizationType

declare class LocalizedString extends ValueType
    index: number
    function __tostring(self): string
    function Format(self): string
    function Format(self, param1: string): string
    function Format(self, param1: string, param2: string): string
    function Format(self, param1: string, param2: string, param3: string): string
    function Format(self, param1: string, param2: string, param3: string, param4: string): string
    function Format(self, param1: string, param2: string, param3: string, param4: string, param5: string): string
    function FormatPlural(self, count: number): string
    function FormatPlural(self, count: number, param2: string): string
    function FormatPlural(self, count: number, param2: string, param3: string): string
    function FormatPlural(self, count: number, param2: string, param3: string, param4: string): string
    function FormatPlural(self, count: number, param2: string, param3: string, param4: string, param5: string): string
end
declare class LocalizedStringType extends ValueTypeType
    none: LocalizedString
end
declare LocalizedString: LocalizedStringType

declare class LocalizedValue extends Object
    function __tostring(self): string
end
declare class LocalizedValueType extends ObjectType
    DayAndMonth: ((time: number) -> string)
    DayAndMonthAndFullYear: ((time: number) -> string)
    DayAndMonthAndYear: ((time: number) -> string)
    HoursMinutes: ((duration: number) -> string)
    HoursMinutesSeconds: ((duration: number) -> string)
    MonthAndYear: ((time: number) -> string)
    MonthAndYear: ((time: number, abbreviated: boolean) -> string)
    Numeric: ((value: number) -> string)
    Numeric: ((value: number, decimalPoints: number) -> string)
    Numeric: ((value: number, decimalPoints: number, abbreviated: boolean) -> string)
    TimeAgo: ((time: number) -> string)
    TimeAgo: ((time: number, shortForm: boolean) -> string)
    TimeIn: ((time: number) -> string)
    TimeIn: ((time: number, shortForm: boolean) -> string)
    TimeLeft: ((secondsLeft: number) -> string)
    TimeSpan: ((seconds: number) -> string)
end
declare LocalizedValue: LocalizedValueType

declare class Material extends Object
    color: Color
    doubleSidedGI: boolean
    enableInstancing: boolean
    mainTexture: Texture
    mainTextureOffset: Vector2
    mainTextureScale: Vector2
    passCount: number
    renderQueue: number
    shader: Shader
    shaderKeywords: {string}
    function __tostring(self): string
    function ComputeCRC(self): number
    function CopyMatchingPropertiesFromMaterial(self, mat: Material)
    function CopyPropertiesFromMaterial(self, mat: Material)
    function FindPass(self, passName: string): number
    function GetColor(self, name: string): Color
    function GetColor(self, nameID: number): Color
    function GetColorArray(self, name: string): {Color}
    function GetColorArray(self, nameID: number): {Color}
    function GetFloat(self, name: string): number
    function GetFloat(self, nameID: number): number
    function GetFloatArray(self, name: string): {number}
    function GetFloatArray(self, nameID: number): {number}
    function GetInt(self, name: string): number
    function GetInt(self, nameID: number): number
    function GetInteger(self, name: string): number
    function GetInteger(self, nameID: number): number
    function GetMatrix(self, name: string): Matrix4x4
    function GetMatrix(self, nameID: number): Matrix4x4
    function GetMatrixArray(self, name: string): {Matrix4x4}
    function GetMatrixArray(self, nameID: number): {Matrix4x4}
    function GetPassName(self, pass: number): string
    function GetShaderPassEnabled(self, passName: string): boolean
    function GetTag(self, tag: string, searchFallbacks: boolean): string
    function GetTag(self, tag: string, searchFallbacks: boolean, defaultValue: string): string
    function GetTexture(self, name: string): Texture
    function GetTexture(self, nameID: number): Texture
    function GetTextureOffset(self, name: string): Vector2
    function GetTextureOffset(self, nameID: number): Vector2
    function GetTexturePropertyNameIDs(self): {number}
    function GetTexturePropertyNames(self): {string}
    function GetTextureScale(self, name: string): Vector2
    function GetTextureScale(self, nameID: number): Vector2
    function GetVector(self, name: string): Vector4
    function GetVector(self, nameID: number): Vector4
    function GetVectorArray(self, name: string): {Vector4}
    function GetVectorArray(self, nameID: number): {Vector4}
    function HasBuffer(self, name: string): boolean
    function HasBuffer(self, nameID: number): boolean
    function HasColor(self, name: string): boolean
    function HasColor(self, nameID: number): boolean
    function HasConstantBuffer(self, name: string): boolean
    function HasConstantBuffer(self, nameID: number): boolean
    function HasFloat(self, name: string): boolean
    function HasFloat(self, nameID: number): boolean
    function HasInt(self, name: string): boolean
    function HasInt(self, nameID: number): boolean
    function HasInteger(self, name: string): boolean
    function HasInteger(self, nameID: number): boolean
    function HasMatrix(self, name: string): boolean
    function HasMatrix(self, nameID: number): boolean
    function HasProperty(self, name: string): boolean
    function HasProperty(self, nameID: number): boolean
    function HasTexture(self, name: string): boolean
    function HasTexture(self, nameID: number): boolean
    function HasVector(self, name: string): boolean
    function HasVector(self, nameID: number): boolean
    function Lerp(self, start: Material, _end: Material, t: number)
    function SetColor(self, name: string, value: Color)
    function SetColor(self, nameID: number, value: Color)
    function SetColorArray(self, name: string, values: {Color})
    function SetColorArray(self, nameID: number, values: {Color})
    function SetFloat(self, name: string, value: number)
    function SetFloat(self, nameID: number, value: number)
    function SetFloatArray(self, name: string, values: {number})
    function SetFloatArray(self, nameID: number, values: {number})
    function SetInt(self, name: string, value: number)
    function SetInt(self, nameID: number, value: number)
    function SetInteger(self, name: string, value: number)
    function SetInteger(self, nameID: number, value: number)
    function SetMatrix(self, name: string, value: Matrix4x4)
    function SetMatrix(self, nameID: number, value: Matrix4x4)
    function SetMatrixArray(self, name: string, values: {Matrix4x4})
    function SetMatrixArray(self, nameID: number, values: {Matrix4x4})
    function SetOverrideTag(self, tag: string, val: string)
    function SetPass(self, pass: number): boolean
    function SetShaderPassEnabled(self, passName: string, enabled: boolean)
    function SetTexture(self, name: string, value: Texture)
    function SetTexture(self, nameID: number, value: Texture)
    function SetTextureOffset(self, name: string, value: Vector2)
    function SetTextureOffset(self, nameID: number, value: Vector2)
    function SetTextureScale(self, name: string, value: Vector2)
    function SetTextureScale(self, nameID: number, value: Vector2)
    function SetVector(self, name: string, value: Vector4)
    function SetVector(self, nameID: number, value: Vector4)
    function SetVectorArray(self, name: string, values: {Vector4})
    function SetVectorArray(self, nameID: number, values: {Vector4})
end
declare class MaterialType extends ObjectType
    new: ((shader: Shader) -> Material)
    new: ((source: Material) -> Material)
end
declare Material: MaterialType

declare class MaterialPropertyBlock extends Object
    isEmpty: boolean
    function __tostring(self): string
    function Clear(self)
    function GetColor(self, name: string): Color
    function GetColor(self, nameID: number): Color
    function GetFloat(self, name: string): number
    function GetFloat(self, nameID: number): number
    function GetFloatArray(self, name: string): {number}
    function GetFloatArray(self, nameID: number): {number}
    function GetInt(self, name: string): number
    function GetInt(self, nameID: number): number
    function GetInteger(self, name: string): number
    function GetInteger(self, nameID: number): number
    function GetMatrix(self, name: string): Matrix4x4
    function GetMatrix(self, nameID: number): Matrix4x4
    function GetMatrixArray(self, name: string): {Matrix4x4}
    function GetMatrixArray(self, nameID: number): {Matrix4x4}
    function GetTexture(self, name: string): Texture
    function GetTexture(self, nameID: number): Texture
    function GetVector(self, name: string): Vector4
    function GetVector(self, nameID: number): Vector4
    function GetVectorArray(self, name: string): {Vector4}
    function GetVectorArray(self, nameID: number): {Vector4}
    function HasBuffer(self, name: string): boolean
    function HasBuffer(self, nameID: number): boolean
    function HasColor(self, name: string): boolean
    function HasColor(self, nameID: number): boolean
    function HasConstantBuffer(self, name: string): boolean
    function HasConstantBuffer(self, nameID: number): boolean
    function HasFloat(self, name: string): boolean
    function HasFloat(self, nameID: number): boolean
    function HasInt(self, name: string): boolean
    function HasInt(self, nameID: number): boolean
    function HasInteger(self, name: string): boolean
    function HasInteger(self, nameID: number): boolean
    function HasMatrix(self, name: string): boolean
    function HasMatrix(self, nameID: number): boolean
    function HasProperty(self, name: string): boolean
    function HasProperty(self, nameID: number): boolean
    function HasTexture(self, name: string): boolean
    function HasTexture(self, nameID: number): boolean
    function HasVector(self, name: string): boolean
    function HasVector(self, nameID: number): boolean
    function SetColor(self, name: string, value: Color)
    function SetColor(self, nameID: number, value: Color)
    function SetFloat(self, name: string, value: number)
    function SetFloat(self, nameID: number, value: number)
    function SetFloatArray(self, name: string, values: {number})
    function SetFloatArray(self, nameID: number, values: {number})
    function SetInt(self, name: string, value: number)
    function SetInt(self, nameID: number, value: number)
    function SetInteger(self, name: string, value: number)
    function SetInteger(self, nameID: number, value: number)
    function SetMatrix(self, name: string, value: Matrix4x4)
    function SetMatrix(self, nameID: number, value: Matrix4x4)
    function SetMatrixArray(self, name: string, values: {Matrix4x4})
    function SetMatrixArray(self, nameID: number, values: {Matrix4x4})
    function SetTexture(self, name: string, value: Texture)
    function SetTexture(self, nameID: number, value: Texture)
    function SetVector(self, name: string, value: Vector4)
    function SetVector(self, nameID: number, value: Vector4)
    function SetVectorArray(self, name: string, values: {Vector4})
    function SetVectorArray(self, nameID: number, values: {Vector4})
end
declare class MaterialPropertyBlockType extends ObjectType
    new: (() -> MaterialPropertyBlock)
end
declare MaterialPropertyBlock: MaterialPropertyBlockType

declare class Matrix4x4 extends ValueType
    determinant: number
    inverse: Matrix4x4
    isIdentity: boolean
    lossyScale: Vector3
    m00: number
    m01: number
    m02: number
    m03: number
    m10: number
    m11: number
    m12: number
    m13: number
    m20: number
    m21: number
    m22: number
    m23: number
    m30: number
    m31: number
    m32: number
    m33: number
    rotation: Quaternion
    transpose: Matrix4x4
    function __eq(self, rhs: Matrix4x4): boolean
    function __mul(self, rhs: Matrix4x4): Matrix4x4
    function __mul(self, vector: Vector4): Vector4
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function Equals(self, other: Matrix4x4): boolean
    function GetColumn(self, index: number): Vector4
    function GetPosition(self): Vector3
    function GetRow(self, index: number): Vector4
    function MultiplyPoint(self, point: Vector3): Vector3
    function MultiplyPoint3x4(self, point: Vector3): Vector3
    function MultiplyVector(self, vector: Vector3): Vector3
    function SetColumn(self, index: number, column: Vector4)
    function SetRow(self, index: number, row: Vector4)
    function SetTRS(self, pos: Vector3, q: Quaternion, s: Vector3)
    function TransformPlane(self, plane: Plane): Plane
    function ValidTRS(self): boolean
end
declare class Matrix4x4Type extends ValueTypeType
    identity: Matrix4x4
    zero: Matrix4x4
    Determinant: ((m: Matrix4x4) -> number)
    Frustum: ((left: number, right: number, bottom: number, top: number, zNear: number, zFar: number) -> Matrix4x4)
    Inverse: ((m: Matrix4x4) -> Matrix4x4)
    Inverse3DAffine: ((input: Matrix4x4, result: Matrix4x4) -> (boolean, Matrix4x4))
    LookAt: ((from: Vector3, to: Vector3, up: Vector3) -> Matrix4x4)
    new: ((column0: Vector4, column1: Vector4, column2: Vector4, column3: Vector4) -> Matrix4x4)
    Ortho: ((left: number, right: number, bottom: number, top: number, zNear: number, zFar: number) -> Matrix4x4)
    Perspective: ((fov: number, aspect: number, zNear: number, zFar: number) -> Matrix4x4)
    Rotate: ((q: Quaternion) -> Matrix4x4)
    Scale: ((vector: Vector3) -> Matrix4x4)
    Translate: ((vector: Vector3) -> Matrix4x4)
    Transpose: ((m: Matrix4x4) -> Matrix4x4)
    TRS: ((pos: Vector3, q: Quaternion, s: Vector3) -> Matrix4x4)
end
declare Matrix4x4: Matrix4x4Type

declare class Mesh extends Object
    bindposeCount: number
    bindposes: {Matrix4x4}
    blendShapeCount: number
    bounds: Bounds
    colors: {Color}
    isReadable: boolean
    normals: {Vector3}
    subMeshCount: number
    triangles: {number}
    uv: {Vector2}
    uv2: {Vector2}
    uv3: {Vector2}
    uv4: {Vector2}
    uv5: {Vector2}
    uv6: {Vector2}
    uv7: {Vector2}
    uv8: {Vector2}
    vertexAttributeCount: number
    vertexBufferCount: number
    vertexCount: number
    vertices: {Vector3}
    function __tostring(self): string
    function Clear(self)
    function Clear(self, keepVertexLayout: boolean)
    function ClearBlendShapes(self)
    function GetBaseVertex(self, submesh: number): number
    function GetBlendShapeFrameCount(self, shapeIndex: number): number
    function GetBlendShapeFrameWeight(self, shapeIndex: number, frameIndex: number): number
    function GetBlendShapeIndex(self, blendShapeName: string): number
    function GetBlendShapeName(self, shapeIndex: number): string
    function GetIndexCount(self, submesh: number): number
    function GetIndexStart(self, submesh: number): number
    function GetIndices(self, submesh: number): {number}
    function GetIndices(self, submesh: number, applyBaseVertex: boolean): {number}
    function GetTriangles(self, submesh: number): {number}
    function GetTriangles(self, submesh: number, applyBaseVertex: boolean): {number}
    function GetUVDistributionMetric(self, uvSetIndex: number): number
    function GetVertexBufferStride(self, stream: number): number
    function MarkDynamic(self)
    function MarkModified(self)
    function Optimize(self)
    function OptimizeIndexBuffers(self)
    function OptimizeReorderVertexBuffer(self)
    function RecalculateBounds(self)
    function RecalculateNormals(self)
    function RecalculateTangents(self)
    function RecalculateUVDistributionMetric(self, uvSetIndex: number)
    function RecalculateUVDistributionMetric(self, uvSetIndex: number, uvAreaThreshold: number)
    function RecalculateUVDistributionMetrics(self)
    function RecalculateUVDistributionMetrics(self, uvAreaThreshold: number)
    function UploadMeshData(self, markNoLongerReadable: boolean)
end
declare class MeshType extends ObjectType
    new: (() -> Mesh)
end
declare Mesh: MeshType

declare class Motion extends Object
    apparentSpeed: number
    averageAngularSpeed: number
    averageDuration: number
    averageSpeed: Vector3
    isHumanMotion: boolean
    isLooping: boolean
    legacy: boolean
    function __tostring(self): string
end
declare class MotionType extends ObjectType
end
declare Motion: MotionType

declare class NavMesh extends Object
end
declare class NavMeshType extends ObjectType
    allAreas: number
    avoidancePredictionTime: number
    onPreUpdate: () -> ()
    pathfindingIterationsPerFrame: number
    FindClosestEdge: ((sourcePosition: Vector3, areaMask: number) -> (boolean, NavMeshHit))
    GetAreaCost: ((areaIndex: number) -> number)
    GetAreaFromName: ((areaName: string) -> number)
    GetSettingsCount: (() -> number)
    GetSettingsNameFromID: ((agentTypeID: number) -> string)
    Raycast: ((sourcePosition: Vector3, targetPosition: Vector3, areaMask: number) -> (boolean, NavMeshHit))
    RemoveAllNavMeshData: (() -> ())
    RemoveSettings: ((agentTypeID: number) -> ())
    SamplePosition: ((sourcePosition: Vector3, maxDistance: number, areaMask: number) -> (boolean, NavMeshHit))
    SetAreaCost: ((areaIndex: number, cost: number) -> ())
end
declare NavMesh: NavMeshType

declare class NavMeshHit extends ValueType
    distance: number
    hit: boolean
    mask: number
    normal: Vector3
    position: Vector3
    function __tostring(self): string
end
declare class NavMeshHitType extends ValueTypeType
end
declare NavMeshHit: NavMeshHitType

declare class Payments extends Object
    AcknowledgePurchase: ((purchase: WorldProductPurchase, wasConsumed: boolean, callback: ((error: PaymentsError) -> ())?) -> ())
    GetProduct: ((productId: string, callback: (product: WorldProduct?, error: PaymentsError) -> ()) -> ())
    GetProducts: ((cursorId: string, callback: (products: {WorldProduct}, nextCursorId: string, error: PaymentsError) -> ()) -> ())
    GetPurchases: ((player: Player, productId: string?, limit: number, cursorId: string?, callback: (purchases: {WorldProductPurchase}, nextCursorId: string, error: PaymentsError) -> ()) -> ())
    PurchaseHandler: ((purchase: WorldProductPurchase, player: Player) -> ())?
    function __tostring(self): string
    function ClosePurchasePrompt(self)
    function PromptPurchase(self, productId: string, callback: (boolean) -> ())
end
declare Payments: Payments

declare class Pet extends Object
    character: Character
    id: string
    name: string
    owner: Player
    skeletonId: string
    function __tostring(self): string
end
declare class PetType extends ObjectType
end
declare Pet: PetType

declare class Physics extends Object
    function __tostring(self): string
end
declare class PhysicsType extends ObjectType
    allLayers: number
    autoSyncTransforms: boolean
    bounceThreshold: number
    clothGravity: Vector3
    defaultContactOffset: number
    defaultMaxAngularSpeed: number
    defaultMaxDepenetrationVelocity: number
    defaultRaycastLayers: number
    defaultSolverIterations: number
    defaultSolverVelocityIterations: number
    gravity: Vector3
    ignoreRaycastLayer: number
    improvedPatchFriction: boolean
    interCollisionDistance: number
    interCollisionSettingsToggle: boolean
    interCollisionStiffness: number
    invokeCollisionCallbacks: boolean
    queriesHitBackfaces: boolean
    queriesHitTriggers: boolean
    reuseCollisionCallbacks: boolean
    sleepThreshold: number
    BakeMesh: ((meshID: number, convex: boolean) -> ())
    BoxCast: ((center: Vector3, halfExtents: Vector3, direction: Vector3) -> (boolean, RaycastHit))
    BoxCast: ((center: Vector3, halfExtents: Vector3, direction: Vector3, orientation: Quaternion) -> (boolean, RaycastHit))
    BoxCast: ((center: Vector3, halfExtents: Vector3, direction: Vector3, orientation: Quaternion, maxDistance: number) -> (boolean, RaycastHit))
    BoxCast: ((center: Vector3, halfExtents: Vector3, direction: Vector3, orientation: Quaternion, maxDistance: number, layerMask: number) -> (boolean, RaycastHit))
    BoxCastAll: ((center: Vector3, halfExtents: Vector3, direction: Vector3) -> {RaycastHit})
    BoxCastAll: ((center: Vector3, halfExtents: Vector3, direction: Vector3, orientation: Quaternion) -> {RaycastHit})
    BoxCastAll: ((center: Vector3, halfExtents: Vector3, direction: Vector3, orientation: Quaternion, maxDistance: number) -> {RaycastHit})
    BoxCastAll: ((center: Vector3, halfExtents: Vector3, direction: Vector3, orientation: Quaternion, maxDistance: number, layerMask: number) -> {RaycastHit})
    CapsuleCast: ((point1: Vector3, point2: Vector3, radius: number, direction: Vector3) -> (boolean, RaycastHit))
    CapsuleCast: ((point1: Vector3, point2: Vector3, radius: number, direction: Vector3, maxDistance: number) -> (boolean, RaycastHit))
    CapsuleCast: ((point1: Vector3, point2: Vector3, radius: number, direction: Vector3, maxDistance: number, layerMask: number) -> (boolean, RaycastHit))
    CapsuleCastAll: ((point1: Vector3, point2: Vector3, radius: number, direction: Vector3) -> {RaycastHit})
    CapsuleCastAll: ((point1: Vector3, point2: Vector3, radius: number, direction: Vector3, maxDistance: number) -> {RaycastHit})
    CapsuleCastAll: ((point1: Vector3, point2: Vector3, radius: number, direction: Vector3, maxDistance: number, layerMask: number) -> {RaycastHit})
    CheckBox: ((center: Vector3, halfExtents: Vector3) -> boolean)
    CheckBox: ((center: Vector3, halfExtents: Vector3, orientation: Quaternion) -> boolean)
    CheckBox: ((center: Vector3, halfExtents: Vector3, orientation: Quaternion, layerMask: number) -> boolean)
    CheckCapsule: ((start: Vector3, _end: Vector3, radius: number) -> boolean)
    CheckCapsule: ((start: Vector3, _end: Vector3, radius: number, layerMask: number) -> boolean)
    CheckSphere: ((position: Vector3, radius: number) -> boolean)
    CheckSphere: ((position: Vector3, radius: number, layerMask: number) -> boolean)
    ClosestPoint: ((point: Vector3, collider: Collider, position: Vector3, rotation: Quaternion) -> Vector3)
    ComputePenetration: ((colliderA: Collider, positionA: Vector3, rotationA: Quaternion, colliderB: Collider, positionB: Vector3, rotationB: Quaternion) -> (boolean, Vector3, number))
    GetIgnoreCollision: ((collider1: Collider, collider2: Collider) -> boolean)
    GetIgnoreLayerCollision: ((layer1: number, layer2: number) -> boolean)
    IgnoreCollision: ((collider1: Collider, collider2: Collider) -> ())
    IgnoreCollision: ((collider1: Collider, collider2: Collider, ignore: boolean) -> ())
    IgnoreLayerCollision: ((layer1: number, layer2: number) -> ())
    IgnoreLayerCollision: ((layer1: number, layer2: number, ignore: boolean) -> ())
    Linecast: ((start: Vector3, _end: Vector3) -> (boolean, RaycastHit))
    Linecast: ((start: Vector3, _end: Vector3, layerMask: number) -> (boolean, RaycastHit))
    OverlapBox: ((center: Vector3, halfExtents: Vector3) -> {Collider})
    OverlapBox: ((center: Vector3, halfExtents: Vector3, orientation: Quaternion) -> {Collider})
    OverlapBox: ((center: Vector3, halfExtents: Vector3, orientation: Quaternion, layerMask: number) -> {Collider})
    OverlapCapsule: ((point0: Vector3, point1: Vector3, radius: number) -> {Collider})
    OverlapCapsule: ((point0: Vector3, point1: Vector3, radius: number, layerMask: number) -> {Collider})
    OverlapSphere: ((position: Vector3, radius: number) -> {Collider})
    OverlapSphere: ((position: Vector3, radius: number, layerMask: number) -> {Collider})
    Raycast: ((origin: Vector3, direction: Vector3) -> (boolean, RaycastHit))
    Raycast: ((origin: Vector3, direction: Vector3, maxDistance: number) -> (boolean, RaycastHit))
    Raycast: ((origin: Vector3, direction: Vector3, maxDistance: number, layerMask: number) -> (boolean, RaycastHit))
    Raycast: ((ray: Ray) -> (boolean, RaycastHit))
    Raycast: ((ray: Ray, maxDistance: number) -> (boolean, RaycastHit))
    Raycast: ((ray: Ray, maxDistance: number, layerMask: number) -> (boolean, RaycastHit))
    RaycastAll: ((origin: Vector3, direction: Vector3) -> {RaycastHit})
    RaycastAll: ((origin: Vector3, direction: Vector3, maxDistance: number) -> {RaycastHit})
    RaycastAll: ((origin: Vector3, direction: Vector3, maxDistance: number, layerMask: number) -> {RaycastHit})
    RaycastAll: ((ray: Ray) -> {RaycastHit})
    RaycastAll: ((ray: Ray, maxDistance: number) -> {RaycastHit})
    RaycastAll: ((ray: Ray, maxDistance: number, layerMask: number) -> {RaycastHit})
    Simulate: ((step: number) -> ())
    SphereCast: ((origin: Vector3, radius: number, direction: Vector3) -> (boolean, RaycastHit))
    SphereCast: ((origin: Vector3, radius: number, direction: Vector3, maxDistance: number) -> (boolean, RaycastHit))
    SphereCast: ((origin: Vector3, radius: number, direction: Vector3, maxDistance: number, layerMask: number) -> (boolean, RaycastHit))
    SphereCast: ((ray: Ray, radius: number) -> (boolean, RaycastHit))
    SphereCast: ((ray: Ray, radius: number, maxDistance: number) -> (boolean, RaycastHit))
    SphereCast: ((ray: Ray, radius: number, maxDistance: number, layerMask: number) -> (boolean, RaycastHit))
    SphereCastAll: ((origin: Vector3, radius: number, direction: Vector3) -> {RaycastHit})
    SphereCastAll: ((origin: Vector3, radius: number, direction: Vector3, maxDistance: number) -> {RaycastHit})
    SphereCastAll: ((origin: Vector3, radius: number, direction: Vector3, maxDistance: number, layerMask: number) -> {RaycastHit})
    SphereCastAll: ((ray: Ray, radius: number) -> {RaycastHit})
    SphereCastAll: ((ray: Ray, radius: number, maxDistance: number) -> {RaycastHit})
    SphereCastAll: ((ray: Ray, radius: number, maxDistance: number, layerMask: number) -> {RaycastHit})
    SyncTransforms: (() -> ())
end
declare Physics: PhysicsType

declare class Plane extends ValueType
    distance: number
    flipped: Plane
    normal: Vector3
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function ClosestPointOnPlane(self, point: Vector3): Vector3
    function Flip(self)
    function GetDistanceToPoint(self, point: Vector3): number
    function GetSide(self, point: Vector3): boolean
    function Raycast(self, ray: Ray): (boolean, number)
    function SameSide(self, inPt0: Vector3, inPt1: Vector3): boolean
    function Set3Points(self, a: Vector3, b: Vector3, c: Vector3)
    function SetNormalAndPosition(self, inNormal: Vector3, inPoint: Vector3)
    function Translate(self, translation: Vector3)
end
declare class PlaneType extends ValueTypeType
    new: ((a: Vector3, b: Vector3, c: Vector3) -> Plane)
    new: ((inNormal: Vector3, d: number) -> Plane)
    new: ((inNormal: Vector3, inPoint: Vector3) -> Plane)
    Translate: ((plane: Plane, translation: Vector3) -> Plane)
end
declare Plane: PlaneType

declare class Player extends Object
    activeChannel: ChannelInfo
    character: Character
    CharacterChanged: Event
    chatBubbleTransform: Transform
    hasPet: boolean
    id: number
    isAgeVerifiedAbove18: boolean
    isDestroyed: boolean
    isLocal: boolean
    isModerator: boolean
    isSubscriber: boolean
    name: string
    pet: Pet
    PetOutfitChanged: Event
    user: User
    voicePosition: Vector3
    function IsUsingPetType(self, petId: string): boolean
end
declare class PlayerType extends ObjectType
end
declare Player: PlayerType

declare class PlayerPrefs extends Object
    function __tostring(self): string
end
declare class PlayerPrefsType extends ObjectType
    DeleteKey: ((key: string) -> ())
    GetFloat: ((key: string) -> number)
    GetFloat: ((key: string, defaultValue: number) -> number)
    GetInt: ((key: string) -> number)
    GetInt: ((key: string, defaultValue: number) -> number)
    GetString: ((key: string) -> string)
    GetString: ((key: string, defaultValue: string) -> string)
    HasKey: ((key: string) -> boolean)
    SetFloat: ((key: string, value: number) -> ())
    SetInt: ((key: string, value: number) -> ())
    SetString: ((key: string, value: string) -> ())
end
declare PlayerPrefs: PlayerPrefsType

declare class Quaternion extends ValueType
    eulerAngles: Vector3
    normalized: Quaternion
    w: number
    x: number
    y: number
    z: number
    function __eq(self, rhs: Quaternion): boolean
    function __mul(self, point: Vector3): Vector3
    function __mul(self, rhs: Quaternion): Quaternion
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function Equals(self, other: Quaternion): boolean
    function Normalize(self)
    function Set(self, newX: number, newY: number, newZ: number, newW: number)
    function SetFromToRotation(self, fromDirection: Vector3, toDirection: Vector3)
    function SetLookRotation(self, view: Vector3)
    function SetLookRotation(self, view: Vector3, up: Vector3)
    function ToAngleAxis(self): (number, Vector3)
end
declare class QuaternionType extends ValueTypeType
    identity: Quaternion
    Angle: ((a: Quaternion, b: Quaternion) -> number)
    AngleAxis: ((angle: number, axis: Vector3) -> Quaternion)
    Dot: ((a: Quaternion, b: Quaternion) -> number)
    Euler: ((euler: Vector3) -> Quaternion)
    Euler: ((x: number, y: number, z: number) -> Quaternion)
    FromToRotation: ((fromDirection: Vector3, toDirection: Vector3) -> Quaternion)
    Inverse: ((rotation: Quaternion) -> Quaternion)
    Lerp: ((a: Quaternion, b: Quaternion, t: number) -> Quaternion)
    LerpUnclamped: ((a: Quaternion, b: Quaternion, t: number) -> Quaternion)
    LookRotation: ((forward: Vector3) -> Quaternion)
    LookRotation: ((forward: Vector3, upwards: Vector3) -> Quaternion)
    Multiply: ((lhs: Quaternion, rhs: Quaternion) -> Quaternion)
    new: ((x: number, y: number, z: number, w: number) -> Quaternion)
    Normalize: ((q: Quaternion) -> Quaternion)
    RotateTowards: ((from: Quaternion, to: Quaternion, maxDegreesDelta: number) -> Quaternion)
    Slerp: ((a: Quaternion, b: Quaternion, t: number) -> Quaternion)
    SlerpUnclamped: ((a: Quaternion, b: Quaternion, t: number) -> Quaternion)
end
declare Quaternion: QuaternionType

declare class Random extends Object
end
declare class RandomType extends ObjectType
    insideUnitCircle: Vector2
    insideUnitSphere: Vector3
    onUnitSphere: Vector3
    rotation: Quaternion
    rotationUniform: Quaternion
    value: number
    ColorHSV: (() -> Color)
    ColorHSV: ((hueMin: number, hueMax: number) -> Color)
    ColorHSV: ((hueMin: number, hueMax: number, saturationMin: number, saturationMax: number) -> Color)
    ColorHSV: ((hueMin: number, hueMax: number, saturationMin: number, saturationMax: number, valueMin: number, valueMax: number) -> Color)
    ColorHSV: ((hueMin: number, hueMax: number, saturationMin: number, saturationMax: number, valueMin: number, valueMax: number, alphaMin: number, alphaMax: number) -> Color)
    InitState: ((seed: number) -> ())
    Range: ((minInclusive: number, maxInclusive: number) -> number)
    RangeInt: ((minInclusive: number, maxExclusive: number) -> number)
end
declare Random: RandomType

declare class Ray extends ValueType
    direction: Vector3
    origin: Vector3
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function GetPoint(self, distance: number): Vector3
end
declare class RayType extends ValueTypeType
    new: ((origin: Vector3, direction: Vector3) -> Ray)
end
declare Ray: RayType

declare class RaycastHit extends ValueType
    barycentricCoordinate: Vector3
    collider: Collider
    colliderInstanceID: number
    distance: number
    lightmapCoord: Vector2
    normal: Vector3
    point: Vector3
    rigidbody: Rigidbody
    textureCoord: Vector2
    textureCoord2: Vector2
    transform: Transform
    triangleIndex: number
    function __tostring(self): string
end
declare class RaycastHitType extends ValueTypeType
end
declare RaycastHit: RaycastHitType

declare class Rect extends ValueType
    center: Vector2
    height: number
    max: Vector2
    min: Vector2
    position: Vector2
    size: Vector2
    width: number
    x: number
    xMax: number
    xMin: number
    y: number
    yMax: number
    yMin: number
    function __eq(self, rhs: Rect): boolean
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function Contains(self, point: Vector2): boolean
    function Contains(self, point: Vector3): boolean
    function Contains(self, point: Vector3, allowInverse: boolean): boolean
    function Equals(self, other: Rect): boolean
    function Overlaps(self, other: Rect): boolean
    function Overlaps(self, other: Rect, allowInverse: boolean): boolean
    function Set(self, x: number, y: number, width: number, height: number)
end
declare class RectType extends ValueTypeType
    zero: Rect
    MinMaxRect: ((xmin: number, ymin: number, xmax: number, ymax: number) -> Rect)
    new: ((position: Vector2, size: Vector2) -> Rect)
    new: ((source: Rect) -> Rect)
    new: ((x: number, y: number, width: number, height: number) -> Rect)
    NormalizedToPoint: ((rectangle: Rect, normalizedRectCoordinates: Vector2) -> Vector2)
    PointToNormalized: ((rectangle: Rect, point: Vector2) -> Vector2)
end
declare Rect: RectType

declare class RenderSettings extends Object
    ambientEquatorColor: Color
    ambientGroundColor: Color
    ambientIntensity: number
    ambientLight: Color
    ambientSkyColor: Color
    defaultReflectionResolution: number
    flareFadeSpeed: number
    flareStrength: number
    fog: boolean
    fogColor: Color
    fogDensity: number
    fogEndDistance: number
    fogStartDistance: number
    haloStrength: number
    reflectionBounces: number
    reflectionIntensity: number
    skybox: Material
    subtractiveShadowColor: Color
    function __tostring(self): string
end
declare class RenderSettingsType extends ObjectType
end
declare RenderSettings: RenderSettingsType

declare class Rotate extends ValueType
    angle: Angle
    function __eq(self, rhs: Rotate): boolean
    function __tostring(self): string
    function Equals(self, other: Rotate): boolean
end
declare class RotateType extends ValueTypeType
    new: ((angle: Angle) -> Rotate)
    None: (() -> Rotate)
end
declare Rotate: RotateType

declare class Scale extends ValueType
    value: Vector3
    function __eq(self, rhs: Scale): boolean
    function __tostring(self): string
    function Equals(self, other: Scale): boolean
end
declare class ScaleType extends ValueTypeType
    new: ((scale: Vector2) -> Scale)
    new: ((scale: Vector3) -> Scale)
    None: (() -> Scale)
end
declare Scale: ScaleType

declare class Screen extends Object
end
declare class ScreenType extends ObjectType
    brightness: number
    cutouts: {Rect}
    dpi: number
    fullScreen: boolean
    height: number
    safeArea: Rect
    sleepTimeout: number
    width: number
end
declare Screen: ScreenType

declare class ScriptableObject extends Object
    function __tostring(self): string
end
declare class ScriptableObjectType extends ObjectType
    CreateInstance: ((className: string) -> ScriptableObject)
    CreateInstance: ((type: Type) -> ScriptableObject)
end
declare ScriptableObject: ScriptableObjectType

declare class Shader extends Object
    isSupported: boolean
    maximumLOD: number
    passCount: number
    renderQueue: number
    subshaderCount: number
    function __tostring(self): string
    function FindPropertyIndex(self, propertyName: string): number
    function FindTextureStack(self, propertyIndex: number): (boolean, string, number)
    function GetDependency(self, name: string): Shader
    function GetPassCountInSubshader(self, subshaderIndex: number): number
    function GetPropertyAttributes(self, propertyIndex: number): {string}
    function GetPropertyCount(self): number
    function GetPropertyDefaultFloatValue(self, propertyIndex: number): number
    function GetPropertyDefaultIntValue(self, propertyIndex: number): number
    function GetPropertyDefaultVectorValue(self, propertyIndex: number): Vector4
    function GetPropertyDescription(self, propertyIndex: number): string
    function GetPropertyName(self, propertyIndex: number): string
    function GetPropertyNameId(self, propertyIndex: number): number
    function GetPropertyRangeLimits(self, propertyIndex: number): Vector2
    function GetPropertyTextureDefaultName(self, propertyIndex: number): string
end
declare class ShaderType extends ObjectType
    PropertyToID: ((name: string) -> number)
end
declare Shader: ShaderType

declare class Sprite extends Object
    associatedAlphaSplitTexture: Texture2D
    border: Vector4
    bounds: Bounds
    packed: boolean
    pivot: Vector2
    pixelsPerUnit: number
    rect: Rect
    spriteAtlasTextureScale: number
    texture: Texture2D
    textureRect: Rect
    textureRectOffset: Vector2
    triangles: {number}
    uv: {Vector2}
    vertices: {Vector2}
    function __tostring(self): string
    function GetPhysicsShapeCount(self): number
    function GetPhysicsShapePointCount(self, shapeIdx: number): number
    function GetSecondaryTextureCount(self): number
end
declare class SpriteType extends ObjectType
    Create: ((texture: Texture2D, rect: Rect, pivot: Vector2) -> Sprite)
    Create: ((texture: Texture2D, rect: Rect, pivot: Vector2, pixelsPerUnit: number) -> Sprite)
    Create: ((texture: Texture2D, rect: Rect, pivot: Vector2, pixelsPerUnit: number, extrude: number) -> Sprite)
end
declare Sprite: SpriteType

declare class Storage extends Object
    DeletePlayerValue: ((player: Player, key: string) -> ())
    DeletePlayerValue: ((player: Player, key: string, callback: (error: StorageError) -> ()?) -> ())
    DeleteValue: ((key: string) -> ())
    DeleteValue: ((key: string, callback: (error: StorageError) -> ()?) -> ())
    GetPlayerValue: ((player: Player, key: string, callback: (value: any?, error: StorageError) -> ()) -> ())
    GetValue: ((key: string, callback: (value: any?, error: StorageError) -> ()) -> ())
    IncrementPlayerValue: ((player: Player, key: string, amount: number) -> ())
    IncrementPlayerValue: ((player: Player, key: string, amount: number, callback: (error: StorageError) -> ()?) -> ())
    IncrementValue: ((key: string, amount: number) -> ())
    IncrementValue: ((key: string, amount: number, callback: (error: StorageError) -> ()?) -> ())
    SearchPlayerValue: ((player: Player, key: string, limit: number, cursorId: string?, callback: (values: any?, cursorId: string?, error: StorageError) -> ()) -> ())
    SearchValue: ((key: string, limit: number, cursorId: string?, callback: (values: any?, cursorId: string?, error: StorageError) -> ()) -> ())
    SetPlayerValue: ((player: Player, key: string, value: any) -> ())
    SetPlayerValue: ((player: Player, key: string, value: any, callback : (error: StorageError) -> ()?) -> ())
    SetValue: ((key: string, value: any) -> ())
    SetValue: ((key: string, value: any, callback : (error: StorageError) -> ()?) -> ())
    UpdatePlayerValue: ((player: Player, key: string, modifier: (value: any) -> (any?)) -> ())
    UpdatePlayerValue: ((player: Player, key: string, modifier: (value: any) -> (any?), callback: (error: StorageError) -> ()?) -> ())
    UpdateValue: ((key: string, modifier: (value: any) -> (any?)) -> ())
    UpdateValue: ((key: string, modifier: (value: any) -> (any?), callback: (error: StorageError) -> ()?) -> ())
end
declare Storage: Storage

declare class StudioRoomManager extends Object
end
declare class StudioRoomManagerType extends ObjectType
    Load: ((room: RoomAsset) -> ())
    Load: ((room: RoomAsset, roomWasLoaded: () -> ()) -> ())
end
declare StudioRoomManager: StudioRoomManagerType

declare class StyleBackgroundPosition extends ValueType
    keyword: StyleKeyword
    value: BackgroundPosition
    function __eq(self, rhs: StyleBackgroundPosition): boolean
    function __tostring(self): string
    function Equals(self, other: StyleBackgroundPosition): boolean
end
declare class StyleBackgroundPositionType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleBackgroundPosition)
    new: ((v: BackgroundPosition) -> StyleBackgroundPosition)
end
declare StyleBackgroundPosition: StyleBackgroundPositionType

declare class StyleBackgroundRepeat extends ValueType
    keyword: StyleKeyword
    value: BackgroundRepeat
    function __eq(self, rhs: StyleBackgroundRepeat): boolean
    function __tostring(self): string
    function Equals(self, other: StyleBackgroundRepeat): boolean
end
declare class StyleBackgroundRepeatType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleBackgroundRepeat)
    new: ((v: BackgroundRepeat) -> StyleBackgroundRepeat)
end
declare StyleBackgroundRepeat: StyleBackgroundRepeatType

declare class StyleBackgroundSize extends ValueType
    keyword: StyleKeyword
    value: BackgroundSize
    function __eq(self, rhs: StyleBackgroundSize): boolean
    function __tostring(self): string
    function Equals(self, other: StyleBackgroundSize): boolean
end
declare class StyleBackgroundSizeType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleBackgroundSize)
    new: ((v: BackgroundSize) -> StyleBackgroundSize)
end
declare StyleBackgroundSize: StyleBackgroundSizeType

declare class StyleColor extends ValueType
    keyword: StyleKeyword
    value: Color
    function __eq(self, rhs: Color): boolean
    function __eq(self, rhs: StyleColor): boolean
    function __tostring(self): string
    function Equals(self, other: StyleColor): boolean
end
declare class StyleColorType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleColor)
    new: ((v: Color) -> StyleColor)
end
declare StyleColor: StyleColorType

declare class StyleFloat extends ValueType
    keyword: StyleKeyword
    value: number
    function __eq(self, rhs: StyleFloat): boolean
    function __tostring(self): string
    function Equals(self, other: StyleFloat): boolean
end
declare class StyleFloatType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleFloat)
    new: ((v: number) -> StyleFloat)
end
declare StyleFloat: StyleFloatType

declare class StyleInt extends ValueType
    keyword: StyleKeyword
    value: number
    function __eq(self, rhs: StyleInt): boolean
    function __tostring(self): string
    function Equals(self, other: StyleInt): boolean
end
declare class StyleIntType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleInt)
    new: ((v: number) -> StyleInt)
end
declare StyleInt: StyleIntType

declare class StyleLength extends ValueType
    keyword: StyleKeyword
    value: Length
    function __eq(self, rhs: StyleLength): boolean
    function __tostring(self): string
    function Equals(self, other: StyleLength): boolean
end
declare class StyleLengthType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleLength)
    new: ((v: Length) -> StyleLength)
    new: ((v: number) -> StyleLength)
end
declare StyleLength: StyleLengthType

declare class StyleRotate extends ValueType
    keyword: StyleKeyword
    value: Rotate
    function __eq(self, rhs: StyleRotate): boolean
    function __tostring(self): string
    function Equals(self, other: StyleRotate): boolean
end
declare class StyleRotateType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleRotate)
    new: ((v: Rotate) -> StyleRotate)
end
declare StyleRotate: StyleRotateType

declare class StyleScale extends ValueType
    keyword: StyleKeyword
    value: Scale
    function __eq(self, rhs: StyleScale): boolean
    function __tostring(self): string
    function Equals(self, other: StyleScale): boolean
end
declare class StyleScaleType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleScale)
    new: ((scale: Vector2) -> StyleScale)
    new: ((v: Scale) -> StyleScale)
end
declare StyleScale: StyleScaleType

declare class StyleTextShadow extends ValueType
    keyword: StyleKeyword
    value: TextShadow
    function __eq(self, rhs: StyleTextShadow): boolean
    function __tostring(self): string
    function Equals(self, other: StyleTextShadow): boolean
end
declare class StyleTextShadowType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleTextShadow)
    new: ((v: TextShadow) -> StyleTextShadow)
end
declare StyleTextShadow: StyleTextShadowType

declare class StyleTransformOrigin extends ValueType
    keyword: StyleKeyword
    value: TransformOrigin
    function __eq(self, rhs: StyleTransformOrigin): boolean
    function __tostring(self): string
    function Equals(self, other: StyleTransformOrigin): boolean
end
declare class StyleTransformOriginType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleTransformOrigin)
    new: ((v: TransformOrigin) -> StyleTransformOrigin)
end
declare StyleTransformOrigin: StyleTransformOriginType

declare class StyleTranslate extends ValueType
    keyword: StyleKeyword
    value: Translate
    function __eq(self, rhs: StyleTranslate): boolean
    function __tostring(self): string
    function Equals(self, other: StyleTranslate): boolean
end
declare class StyleTranslateType extends ValueTypeType
    new: ((keyword: StyleKeyword) -> StyleTranslate)
    new: ((v: Translate) -> StyleTranslate)
end
declare StyleTranslate: StyleTranslateType

declare class TextAsset extends Object
    bytes: {Byte}
    dataSize: number
    text: string
    function __tostring(self): string
end
declare class TextAssetType extends ObjectType
end
declare TextAsset: TextAssetType

declare class TextShadow extends ValueType
    blurRadius: number
    color: Color
    offset: Vector2
    function __eq(self, style2: TextShadow): boolean
    function __tostring(self): string
    function Equals(self, other: TextShadow): boolean
end
declare class TextShadowType extends ValueTypeType
end
declare TextShadow: TextShadowType

declare class Texture extends Object
    anisoLevel: number
    height: number
    isDataSRGB: boolean
    isReadable: boolean
    mipMapBias: number
    mipmapCount: number
    texelSize: Vector2
    updateCount: number
    width: number
    function __tostring(self): string
    function IncrementUpdateCount(self)
end
declare class TextureType extends ObjectType
end
declare Texture: TextureType

declare class TransformOrigin extends ValueType
    x: Length
    y: Length
    z: number
    function __eq(self, rhs: TransformOrigin): boolean
    function __tostring(self): string
    function Equals(self, other: TransformOrigin): boolean
end
declare class TransformOriginType extends ValueTypeType
    Initial: (() -> TransformOrigin)
    new: ((x: Length, y: Length) -> TransformOrigin)
    new: ((x: Length, y: Length, z: number) -> TransformOrigin)
end
declare TransformOrigin: TransformOriginType

declare class Translate extends ValueType
    x: Length
    y: Length
    z: number
    function __eq(self, rhs: Translate): boolean
    function __tostring(self): string
    function Equals(self, other: Translate): boolean
end
declare class TranslateType extends ValueTypeType
    new: ((x: Length, y: Length) -> Translate)
    new: ((x: Length, y: Length, z: number) -> Translate)
    None: (() -> Translate)
end
declare Translate: TranslateType

declare class Tween extends ValueType
    duration: number
    isPaused: boolean
    isPlaying: boolean
    isValid: boolean
    normalizedTime: number
    time: number
    function __tostring(self): string
    function AddDelay(self, seconds: number): Tween
    function AutoStop(self): Tween
    function AutoStop(self, value: boolean): Tween
    function DeactivateOnStop(self): Tween
    function DeactivateOnStop(self, value: boolean): Tween
    function Delay(self, seconds: number): Tween
    function DestroyOnStop(self): Tween
    function DestroyOnStop(self, value: boolean): Tween
    function DisableOnStop(self): Tween
    function DisableOnStop(self, value: boolean): Tween
    function Duration(self, seconds: number): Tween
    function EaseIn(self, easeDelegate: (number, Vector4) -> (number)): Tween
    function EaseIn(self, easeDelegate: (number, Vector4) -> (number), param: Vector4): Tween
    function EaseInBack(self): Tween
    function EaseInBack(self, amplitude: number): Tween
    function EaseInBounce(self): Tween
    function EaseInBounce(self, oscillations: number): Tween
    function EaseInBounce(self, oscillations: number, springiness: number): Tween
    function EaseInCircle(self): Tween
    function EaseInCubic(self): Tween
    function EaseInCubicBezier(self, p0: number, p1: number, p2: number, p3: number): Tween
    function EaseInElastic(self): Tween
    function EaseInElastic(self, oscillations: number): Tween
    function EaseInElastic(self, oscillations: number, springiness: number): Tween
    function EaseInExponential(self): Tween
    function EaseInExponential(self, exponent: number): Tween
    function EaseInOutBack(self): Tween
    function EaseInOutBack(self, amplitude: number): Tween
    function EaseInOutBounce(self): Tween
    function EaseInOutBounce(self, oscillations: number): Tween
    function EaseInOutBounce(self, oscillations: number, springiness: number): Tween
    function EaseInOutCircle(self): Tween
    function EaseInOutCubic(self): Tween
    function EaseInOutCubicBezier(self, p0: number, p1: number, p2: number, p3: number): Tween
    function EaseInOutElastic(self): Tween
    function EaseInOutElastic(self, oscillations: number): Tween
    function EaseInOutElastic(self, oscillations: number, springiness: number): Tween
    function EaseInOutExponential(self): Tween
    function EaseInOutExponential(self, exponent: number): Tween
    function EaseInOutQuadratic(self): Tween
    function EaseInOutSine(self): Tween
    function EaseInQuadratic(self): Tween
    function EaseInSine(self): Tween
    function EaseOut(self, easeDelegate: (number, Vector4) -> (number)): Tween
    function EaseOut(self, easeDelegate: (number, Vector4) -> (number), easeParams: Vector4): Tween
    function EaseOutBack(self): Tween
    function EaseOutBack(self, amplitude: number): Tween
    function EaseOutBounce(self): Tween
    function EaseOutBounce(self, oscillations: number): Tween
    function EaseOutBounce(self, oscillations: number, springiness: number): Tween
    function EaseOutCircle(self): Tween
    function EaseOutCubic(self): Tween
    function EaseOutCubicBezier(self, p0: number, p1: number, p2: number, p3: number): Tween
    function EaseOutElastic(self): Tween
    function EaseOutElastic(self, oscillations: number): Tween
    function EaseOutElastic(self, oscillations: number, springiness: number): Tween
    function EaseOutExponential(self): Tween
    function EaseOutExponential(self, exponent: number): Tween
    function EaseOutQuadratic(self): Tween
    function EaseOutSine(self): Tween
    function Element(self, element: Tween): Tween
    function From(self): Tween
    function Id(self, id: number): Tween
    function Loop(self): Tween
    function Loop(self, count: number): Tween
    function OnPlay(self, callback: () -> ()): Tween
    function OnStop(self, callback: () -> ()): Tween
    function Pause(self)
    function PingPong(self): Tween
    function PingPong(self, value: boolean): Tween
    function Play(self): Tween
    function Priority(self, priority: number): Tween
    function Stop(self)
    function Stop(self, executeCallbacks: boolean)
    function UnscaledTime(self): Tween
    function UnscaledTime(self, unscaled: boolean): Tween
    function Update(self, deltaTime: number): boolean
end
declare class TweenType extends ValueTypeType
    isAnyTweenAnimating: boolean
    Reset: (() -> ())
    Stop: ((id: number) -> ())
    Stop: ((id: number, executeCallbacks: boolean) -> ())
    StopAll: (() -> ())
    StopAll: ((executeCallbacks: boolean) -> ())
end
declare Tween: TweenType

declare class UI extends Object
    aboveChat: VisualElement
    EmotesClosed: Event
    EmoteSelected: Event
    EmotesOpened: Event
    hud: VisualElement
    popupRoot: VisualElement
    function __tostring(self): string
    function CloseCloset(self)
    function ExecuteDeepLink(self, url: string)
    function OpenCloset(self, player: Player)
    function OpenCloset(self, player: Player, outfitSaved: (CharacterOutfit) -> ())
    function OpenCloset(self, player: Player, outfitSaved: (CharacterOutfit) -> (), title: string)
    function OpenCloset(self, player: Player, outfitSaved: (CharacterOutfit) -> (), title: string, contents: ClothingCollection)
    function OpenCloset(self, player: Player, outfitSaved: (CharacterOutfit) -> (), title: string, contents: ClothingCollection, showPlayerInventory: boolean)
    function OpenCloset(self, player: Player, outfitSaved: (CharacterOutfit) -> (), title: string, contents: ClothingCollection, showPlayerInventory: boolean, defaultOutfit: CharacterOutfit)
    function OpenCloset(self, player: Player, outfitSaved: (CharacterOutfit) -> (), title: string, contents: ClothingCollection, showPlayerInventory: boolean, defaultOutfit: CharacterOutfit, saveButtonText: string)
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> ())
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> (), contents: {CharacterClothing})
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> (), contents: {CharacterClothing}, showPlayerInventory: boolean)
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> (), contents: {CharacterClothing}, showPlayerInventory: boolean, defaultOutfit: CharacterOutfit)
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> (), contents: {CharacterClothing}, showPlayerInventory: boolean, defaultOutfit: CharacterOutfit, saveButtonText: string)
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> (), contents: {CharacterClothing}, showPlayerInventory: boolean, defaultOutfit: CharacterOutfit, saveButtonText: string, defaultToFirstTab: boolean)
    function OpenCloset(self, player: Player, title: string, outfitSaved: (CharacterOutfit) -> (), contents: {CharacterClothing}, showPlayerInventory: boolean, defaultOutfit: CharacterOutfit, saveButtonText: string, defaultToFirstTab: boolean, closedWithoutSaving: () -> ())
    function OpenMiniProfile(self, player: Player)
    function OpenMiniProfile(self, userId: string)
    function OpenPopup(self, ve: UIView): number
    function TakeRoomSnapshot(self)
    function TakeRoomSnapshot(self, snapshotClosed: () -> ())
end
declare UI: UI

declare class UICollectionDelegateAsyncRequest extends Object
    isCancelled: boolean
    resultOffset: number
    function __tostring(self): string
    function CompleteRequest(self, results: {LuaObject})
end
declare class UICollectionDelegateAsyncRequestType extends ObjectType
end
declare UICollectionDelegateAsyncRequest: UICollectionDelegateAsyncRequestType

declare class UICollectionGridLayout extends Object
    count: number
    function __tostring(self): string
    function Dispose(self)
    function EnforceColumnCount(self, count: number)
    function GetCellOffset(self, index: number): number
    function GetVisibleCell(self, index: number): UIView
    function Insert(self, index: number, count: number)
    function InvalidateAllItemSizes(self)
    function Rebuild(self)
    function RecycleAllItems(self)
    function Remove(self, index: number, count: number)
    function RemoveAll(self)
    function Update(self, min: number, max: number): number
    function UpdateSize(self, index: number, count: number)
end
declare class UICollectionGridLayoutType extends ObjectType
    new: (() -> UICollectionGridLayout)
    new: ((spacing: number) -> UICollectionGridLayout)
    new: ((spacing: number, columnCount: number) -> UICollectionGridLayout)
    new: ((spacing: number, columnCount: number, fixedHeight: boolean) -> UICollectionGridLayout)
    new: ((spacing: number, columnCount: number, fixedHeight: boolean, centerContent: boolean) -> UICollectionGridLayout)
    new: ((spacing: number, columnCount: number, fixedHeight: boolean, centerContent: boolean, cellAspectRatio: number) -> UICollectionGridLayout)
end
declare UICollectionGridLayout: UICollectionGridLayoutType

declare class UICollectionProvider extends Object
    cells: UICollectionCells
    function __tostring(self): string
    function BindCell(self, cell: UIView, index: number)
    function CellForIndex(self, index: number): UIView
    function Dispose(self)
    function EstimatedSizeForIndex(self, index: number): number
    function TypeForIndex(self, index: number): number
end
declare class UICollectionProviderType extends ObjectType
end
declare UICollectionProvider: UICollectionProviderType

declare class UICollectionStackLayout extends Object
    count: number
    estimatedItemSize: number
    spacing: number
    function __tostring(self): string
    function Dispose(self)
    function GetCellOffset(self, index: number): number
    function GetVisibleCell(self, index: number): UIView
    function Insert(self, index: number, count: number)
    function InvalidateAllItemSizes(self)
    function Rebuild(self)
    function RecycleAllItems(self)
    function Remove(self, index: number, count: number)
    function RemoveAll(self)
    function Update(self, min: number, max: number): number
    function UpdateSize(self, index: number, count: number)
end
declare class UICollectionStackLayoutType extends ObjectType
    new: (() -> UICollectionStackLayout)
    new: ((estimatedItemSize: number) -> UICollectionStackLayout)
    new: ((estimatedItemSize: number, spacing: number) -> UICollectionStackLayout)
    new: ((estimatedItemSize: number, spacing: number, windowInset: number) -> UICollectionStackLayout)
end
declare UICollectionStackLayout: UICollectionStackLayoutType

declare class Vector2 extends ValueType
    magnitude: number
    normalized: Vector2
    sqrMagnitude: number
    x: number
    y: number
    function __add(self, b: Vector2): Vector2
    function __div(self, b: Vector2): Vector2
    function __div(self, d: number): Vector2
    function __eq(self, rhs: Vector2): boolean
    function __mul(self, b: Vector2): Vector2
    function __mul(self, d: number): Vector2
    function __sub(self, b: Vector2): Vector2
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function __unm(self): Vector2
    function Equals(self, other: Vector2): boolean
    function Normalize(self)
    function Scale(self, scale: Vector2)
    function Set(self, newX: number, newY: number)
    function SqrMagnitude(self): number
end
declare class Vector2Type extends ValueTypeType
    down: Vector2
    left: Vector2
    negativeInfinity: Vector2
    one: Vector2
    positiveInfinity: Vector2
    right: Vector2
    up: Vector2
    zero: Vector2
    __mul: ((d: number, a: Vector2) -> Vector2)
    Angle: ((from: Vector2, to: Vector2) -> number)
    ClampMagnitude: ((vector: Vector2, maxLength: number) -> Vector2)
    Distance: ((a: Vector2, b: Vector2) -> number)
    Dot: ((lhs: Vector2, rhs: Vector2) -> number)
    Lerp: ((a: Vector2, b: Vector2, t: number) -> Vector2)
    LerpUnclamped: ((a: Vector2, b: Vector2, t: number) -> Vector2)
    Max: ((lhs: Vector2, rhs: Vector2) -> Vector2)
    Min: ((lhs: Vector2, rhs: Vector2) -> Vector2)
    MoveTowards: ((current: Vector2, target: Vector2, maxDistanceDelta: number) -> Vector2)
    new: ((x: number, y: number) -> Vector2)
    Perpendicular: ((inDirection: Vector2) -> Vector2)
    Reflect: ((inDirection: Vector2, inNormal: Vector2) -> Vector2)
    Scale: ((a: Vector2, b: Vector2) -> Vector2)
    SignedAngle: ((from: Vector2, to: Vector2) -> number)
    SmoothDamp: ((current: Vector2, target: Vector2, currentVelocity: Vector2, smoothTime: number) -> (Vector2, Vector2))
    SmoothDamp: ((current: Vector2, target: Vector2, currentVelocity: Vector2, smoothTime: number, maxSpeed: number) -> (Vector2, Vector2))
    SmoothDamp: ((current: Vector2, target: Vector2, currentVelocity: Vector2, smoothTime: number, maxSpeed: number, deltaTime: number) -> (Vector2, Vector2))
    SqrMagnitude: ((a: Vector2) -> number)
end
declare Vector2: Vector2Type

declare class Vector3 extends ValueType
    magnitude: number
    normalized: Vector3
    sqrMagnitude: number
    x: number
    y: number
    z: number
    function __add(self, b: Vector3): Vector3
    function __div(self, d: number): Vector3
    function __eq(self, rhs: Vector3): boolean
    function __mul(self, b: number): Vector3
    function __sub(self, b: Vector3): Vector3
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function __unm(self): Vector3
    function Equals(self, other: Vector3): boolean
    function Normalize(self)
    function Scale(self, scale: Vector3)
    function Set(self, newX: number, newY: number, newZ: number)
end
declare class Vector3Type extends ValueTypeType
    back: Vector3
    down: Vector3
    forward: Vector3
    left: Vector3
    negativeInfinity: Vector3
    one: Vector3
    positiveInfinity: Vector3
    right: Vector3
    up: Vector3
    zero: Vector3
    __mul: ((d: number, a: Vector3) -> Vector3)
    Angle: ((from: Vector3, to: Vector3) -> number)
    ClampMagnitude: ((vector: Vector3, maxLength: number) -> Vector3)
    Cross: ((lhs: Vector3, rhs: Vector3) -> Vector3)
    Distance: ((a: Vector3, b: Vector3) -> number)
    Dot: ((lhs: Vector3, rhs: Vector3) -> number)
    Lerp: ((a: Vector3, b: Vector3, t: number) -> Vector3)
    LerpUnclamped: ((a: Vector3, b: Vector3, t: number) -> Vector3)
    Magnitude: ((vector: Vector3) -> number)
    Max: ((lhs: Vector3, rhs: Vector3) -> Vector3)
    Min: ((lhs: Vector3, rhs: Vector3) -> Vector3)
    MoveTowards: ((current: Vector3, target: Vector3, maxDistanceDelta: number) -> Vector3)
    new: ((x: number, y: number) -> Vector3)
    new: ((x: number, y: number, z: number) -> Vector3)
    Normalize: ((value: Vector3) -> Vector3)
    OrthoNormalize: ((normal: Vector3, tangent: Vector3) -> (Vector3, Vector3))
    OrthoNormalize: ((normal: Vector3, tangent: Vector3, binormal: Vector3) -> (Vector3, Vector3, Vector3))
    Project: ((vector: Vector3, onNormal: Vector3) -> Vector3)
    ProjectOnPlane: ((vector: Vector3, planeNormal: Vector3) -> Vector3)
    Reflect: ((inDirection: Vector3, inNormal: Vector3) -> Vector3)
    RotateTowards: ((current: Vector3, target: Vector3, maxRadiansDelta: number, maxMagnitudeDelta: number) -> Vector3)
    Scale: ((a: Vector3, b: Vector3) -> Vector3)
    SignedAngle: ((from: Vector3, to: Vector3, axis: Vector3) -> number)
    Slerp: ((a: Vector3, b: Vector3, t: number) -> Vector3)
    SlerpUnclamped: ((a: Vector3, b: Vector3, t: number) -> Vector3)
    SmoothDamp: ((current: Vector3, target: Vector3, currentVelocity: Vector3, smoothTime: number) -> (Vector3, Vector3))
    SmoothDamp: ((current: Vector3, target: Vector3, currentVelocity: Vector3, smoothTime: number, maxSpeed: number) -> (Vector3, Vector3))
    SmoothDamp: ((current: Vector3, target: Vector3, currentVelocity: Vector3, smoothTime: number, maxSpeed: number, deltaTime: number) -> (Vector3, Vector3))
    SqrMagnitude: ((vector: Vector3) -> number)
end
declare Vector3: Vector3Type

declare class Vector4 extends ValueType
    magnitude: number
    normalized: Vector4
    sqrMagnitude: number
    w: number
    x: number
    y: number
    z: number
    function __add(self, b: Vector4): Vector4
    function __div(self, d: number): Vector4
    function __eq(self, rhs: Vector4): boolean
    function __mul(self, b: number): Vector4
    function __sub(self, b: Vector4): Vector4
    function __tostring(self): string
    function __tostring(self, format: string): string
    function __tostring(self, format: string, formatProvider: IFormatProvider): string
    function __unm(self): Vector4
    function Equals(self, other: Vector4): boolean
    function Normalize(self)
    function Scale(self, scale: Vector4)
    function Set(self, newX: number, newY: number, newZ: number, newW: number)
    function SqrMagnitude(self): number
end
declare class Vector4Type extends ValueTypeType
    kEpsilon: number
    negativeInfinity: Vector4
    one: Vector4
    positiveInfinity: Vector4
    zero: Vector4
    __mul: ((d: number, a: Vector4) -> Vector4)
    Distance: ((a: Vector4, b: Vector4) -> number)
    Dot: ((a: Vector4, b: Vector4) -> number)
    Lerp: ((a: Vector4, b: Vector4, t: number) -> Vector4)
    LerpUnclamped: ((a: Vector4, b: Vector4, t: number) -> Vector4)
    Magnitude: ((a: Vector4) -> number)
    Max: ((lhs: Vector4, rhs: Vector4) -> Vector4)
    Min: ((lhs: Vector4, rhs: Vector4) -> Vector4)
    MoveTowards: ((current: Vector4, target: Vector4, maxDistanceDelta: number) -> Vector4)
    new: ((x: number, y: number) -> Vector4)
    new: ((x: number, y: number, z: number) -> Vector4)
    new: ((x: number, y: number, z: number, w: number) -> Vector4)
    Normalize: ((a: Vector4) -> Vector4)
    Project: ((a: Vector4, b: Vector4) -> Vector4)
    Scale: ((a: Vector4, b: Vector4) -> Vector4)
    SqrMagnitude: ((a: Vector4) -> number)
end
declare Vector4: Vector4Type

declare class VisualElementFactory extends Object
end
declare class VisualElementFactoryType extends ObjectType
    new: (() -> VisualElementFactory)
end
declare VisualElementFactory: VisualElementFactoryType

declare class WorldProduct extends Object
    description: string
    id: string
    name: string
    price: number
end
declare class WorldProductType extends ObjectType
end
declare WorldProduct: WorldProductType

declare class WorldProductPurchase extends Object
    id: string
    product_id: string
    purchase_date: number
    user_id: string
end
declare class WorldProductPurchaseType extends ObjectType
end
declare WorldProductPurchase: WorldProductPurchaseType

declare class WorldWheelEvent extends Object
    delta: Vector2
    position: Vector2
    function __tostring(self): string
end
declare class WorldWheelEventType extends ObjectType
end
declare WorldWheelEvent: WorldWheelEventType

declare class Align extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class AlignType extends EnumType
    Auto: Align
    Center: Align
    FlexEnd: Align
    FlexStart: Align
    Stretch: Align
end
declare Align: AlignType

declare class AngleUnit extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class AngleUnitType extends EnumType
    Degree: AngleUnit
    Gradian: AngleUnit
    Radian: AngleUnit
    Turn: AngleUnit
end
declare AngleUnit: AngleUnitType

declare class AnimationClip extends Motion
    empty: boolean
    events: {AnimationEvent}
    frameRate: number
    hasGenericRootTransform: boolean
    hasMotionCurves: boolean
    hasMotionFloatCurves: boolean
    hasRootCurves: boolean
    humanMotion: boolean
    legacy: boolean
    length: number
    localBounds: Bounds
    function __tostring(self): string
    function AddEvent(self, evt: AnimationEvent)
    function ClearCurves(self)
    function EnsureQuaternionContinuity(self)
    function SampleAnimation(self, go: GameObject, time: number)
    function SetCurve(self, relativePath: string, type: Type, propertyName: string, curve: AnimationCurve)
end
declare class AnimationClipType extends MotionType
end
declare AnimationClip: AnimationClipType

declare class AsyncScriptableObject extends ScriptableObject
end
declare class AsyncScriptableObjectType extends ScriptableObjectType
end
declare AsyncScriptableObject: AsyncScriptableObjectType

declare class AudioShader extends ScriptableObject
    clips: {AudioClip}
    isMuted: boolean
    pitch: number
    randomPitch: number
    randomVolume: number
    spatialRange: number
    volume: number
    function __tostring(self): string
    function GetRandomClip(self): AudioClip
    function Play(self)
    function PlayWithVolume(self, v: number)
    function PlayWithVolumeAndPitch(self, volume: number, pitch: number)
end
declare class AudioShaderType extends ScriptableObjectType
    new: ((clip: AudioClip) -> AudioShader)
end
declare AudioShader: AudioShaderType

declare class BackgroundPositionKeyword extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class BackgroundPositionKeywordType extends EnumType
    Bottom: BackgroundPositionKeyword
    Center: BackgroundPositionKeyword
    Left: BackgroundPositionKeyword
    Right: BackgroundPositionKeyword
    Top: BackgroundPositionKeyword
end
declare BackgroundPositionKeyword: BackgroundPositionKeywordType

declare class BackgroundSizeType extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class BackgroundSizeTypeType extends EnumType
    Contain: BackgroundSizeType
    Cover: BackgroundSizeType
    Length: BackgroundSizeType
end
declare BackgroundSizeType: BackgroundSizeTypeType

declare class Behaviour extends Component
    enabled: boolean
    isActiveAndEnabled: boolean
    function __tostring(self): string
end
declare class BehaviourType extends ComponentType
end
declare Behaviour: BehaviourType

declare class ChangeEvent extends EventBase
end
declare class ChangeEventType extends EventBaseType
end
declare ChangeEvent: ChangeEventType

declare class CharacterOutfit extends ScriptableObject
    clothing: {CharacterClothing}
end
declare class CharacterOutfitType extends ScriptableObjectType
    CreateInstance: ((clothing: {CharacterClothing}) -> CharacterOutfit)
    CreateInstance: ((ids: {string}, skeletonId: string) -> CharacterOutfit)
end
declare CharacterOutfit: CharacterOutfitType

declare class CharacterState extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class CharacterStateType extends EnumType
    Custom: CharacterState
    Emote: CharacterState
    Idle: CharacterState
    Jumping: CharacterState
    None: CharacterState
    Running: CharacterState
    Walking: CharacterState
end
declare CharacterState: CharacterStateType

declare class ClothingCollection extends ScriptableObject
    clothing: {CharacterClothing}
end
declare class ClothingCollectionType extends ScriptableObjectType
end
declare ClothingCollection: ClothingCollectionType

declare class Collider extends Component
    attachedRigidbody: Rigidbody
    bounds: Bounds
    contactOffset: number
    enabled: boolean
    excludeLayers: LayerMask
    hasModifiableContacts: boolean
    includeLayers: LayerMask
    isTrigger: boolean
    layerOverridePriority: number
    providesContacts: boolean
    function __tostring(self): string
    function ClosestPoint(self, position: Vector3): Vector3
    function ClosestPointOnBounds(self, position: Vector3): Vector3
    function Raycast(self, ray: Ray, maxDistance: number): (boolean, RaycastHit)
end
declare class ColliderType extends ComponentType
end
declare Collider: ColliderType

declare class CustomStyleResolvedEvent extends EventBase
    customStyle: ICustomStyle
    eventTypeId: number
    function __tostring(self): string
end
declare class CustomStyleResolvedEventType extends EventBaseType
end
declare CustomStyleResolvedEvent: CustomStyleResolvedEventType

declare class DisplayStyle extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class DisplayStyleType extends EnumType
    Flex: DisplayStyle
    None: DisplayStyle
end
declare DisplayStyle: DisplayStyleType

declare class DoubleClickEvent extends EventBase
    eventTypeId: number
    function __tostring(self): string
end
declare class DoubleClickEventType extends EventBaseType
end
declare DoubleClickEvent: DoubleClickEventType

declare class DragGesture extends Gesture
    function __tostring(self): string
    function Custom(self, directionLimit: Vector2, isBidirectional: boolean, directionRecognitionDegs: number): DragGesture
    function HasReachedDuration(self, duration: number): boolean
    function HasReachedMinDistance(self, position: Vector2): boolean
    function Horizontal(self): DragGesture
    function Vertical(self): DragGesture
end
declare class DragGestureType extends GestureType
    new: (() -> DragGesture)
    new: ((helper: IDragGestureHelper) -> DragGesture)
    new: ((helper: IDragGestureHelper, minDistance: number) -> DragGesture)
    new: ((minDistance: number) -> DragGesture)
end
declare DragGesture: DragGestureType

declare class FingerCountBegin extends EventBase
    count: number
    eventTypeId: number
    function __tostring(self): string
end
declare class FingerCountBeginType extends EventBaseType
end
declare FingerCountBegin: FingerCountBeginType

declare class FingerCountEnd extends EventBase
    count: number
    eventTypeId: number
    function __tostring(self): string
end
declare class FingerCountEndType extends EventBaseType
end
declare FingerCountEnd: FingerCountEndType

declare class FlexDirection extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class FlexDirectionType extends EnumType
    Column: FlexDirection
    ColumnReverse: FlexDirection
    Row: FlexDirection
    RowReverse: FlexDirection
end
declare FlexDirection: FlexDirectionType

declare class FocusEventBase extends EventBase
end
declare class FocusEventBaseType extends EventBaseType
end
declare FocusEventBase: FocusEventBaseType

declare class Focusable extends CallbackEventHandler
    canGrabFocus: boolean
    delegatesFocus: boolean
    focusable: boolean
    tabIndex: number
    function __tostring(self): string
    function Blur(self)
    function Focus(self)
end
declare class FocusableType extends CallbackEventHandlerType
end
declare Focusable: FocusableType

declare class FontStyle extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class FontStyleType extends EnumType
    Bold: FontStyle
    BoldAndItalic: FontStyle
    Italic: FontStyle
    Normal: FontStyle
end
declare FontStyle: FontStyleType

declare class ForceMode extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class ForceModeType extends EnumType
    Acceleration: ForceMode
    Force: ForceMode
    Impulse: ForceMode
    VelocityChange: ForceMode
end
declare ForceMode: ForceModeType

declare class GeometryChangedEvent extends EventBase
    eventTypeId: number
    newRect: Rect
    oldRect: Rect
    function __tostring(self): string
end
declare class GeometryChangedEventType extends EventBaseType
    GetPooled: ((oldRect: Rect, newRect: Rect) -> GeometryChangedEvent)
end
declare GeometryChangedEvent: GeometryChangedEventType

declare class InputActionReference extends ScriptableObject
    action: InputAction
    function __tostring(self): string
    function Set(self, action: InputAction)
    function ToInputAction(self): InputAction
end
declare class InputActionReferenceType extends ScriptableObjectType
    Create: ((action: InputAction) -> InputActionReference)
    new: (() -> InputActionReference)
end
declare InputActionReference: InputActionReferenceType

declare class InputEvent extends EventBase
    eventTypeId: number
    newData: string
    previousData: string
    function __tostring(self): string
end
declare class InputEventType extends EventBaseType
    GetPooled: ((previousData: string, newData: string) -> InputEvent)
end
declare InputEvent: InputEventType

declare class JoystickCharacterController extends Component
    movementEnabled: boolean
    SetLocalPlayerPosition: (position: Vector3) -> ()
end
declare class JoystickCharacterControllerType extends ComponentType
end
declare JoystickCharacterController: JoystickCharacterControllerType

declare class Justify extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class JustifyType extends EnumType
    Center: Justify
    FlexEnd: Justify
    FlexStart: Justify
    SpaceAround: Justify
    SpaceBetween: Justify
end
declare Justify: JustifyType

declare class KeyboardContainerStateChangeEvent extends EventBase
    duration: number
    eventTypeId: number
    from: number
    isKeyboardVisible: boolean
    to: number
    function __tostring(self): string
    function Init(self, isKeyboardVisible: boolean, from: number, to: number, duration: number)
end
declare class KeyboardContainerStateChangeEventType extends EventBaseType
    GetPooled: ((isKeyboardVisible: boolean, from: number, to: number, duration: number) -> KeyboardContainerStateChangeEvent)
end
declare KeyboardContainerStateChangeEvent: KeyboardContainerStateChangeEventType

declare class LongPressBeganEvent extends EventBase
    eventTypeId: number
    position: Vector2
    screenPosition: Vector2
    startTime: number
    successDuration: number
    function __tostring(self): string
    function CloneInto(self, clone: LongPressBeganEvent): LongPressBeganEvent
end
declare class LongPressBeganEventType extends EventBaseType
end
declare LongPressBeganEvent: LongPressBeganEventType

declare class LongPressContinueEvent extends EventBase
    eventTypeId: number
    position: Vector2
    progress: number
    screenPosition: Vector2
    startTime: number
    function __tostring(self): string
    function CloneInto(self, clone: LongPressContinueEvent): LongPressContinueEvent
end
declare class LongPressContinueEventType extends EventBaseType
end
declare LongPressContinueEvent: LongPressContinueEventType

declare class LongPressEndedEvent extends EventBase
    cancelled: boolean
    eventTypeId: number
    position: Vector2
    progress: number
    screenPosition: Vector2
    function __tostring(self): string
    function CloneInto(self, clone: LongPressEndedEvent): LongPressEndedEvent
end
declare class LongPressEndedEventType extends EventBaseType
end
declare LongPressEndedEvent: LongPressEndedEventType

declare class LongPressGesture extends Gesture
    function __tostring(self): string
end
declare class LongPressGestureType extends GestureType
    defaultCancelThreshold: number
    defaultDurationThreshold: number
end
declare LongPressGesture: LongPressGestureType

declare class LuaScript extends ScriptableObject
    fullName: string
    namespace: string
    propertyCount: number
    runsOnClient: boolean
    runsOnClientAndServer: boolean
    runsOnServer: boolean
    typeCode: number
    function __tostring(self): string
end
declare class LuaScriptType extends ScriptableObjectType
end
declare LuaScript: LuaScriptType

declare class MeshFilter extends Component
    mesh: Mesh
    sharedMesh: Mesh
    function __tostring(self): string
end
declare class MeshFilterType extends ComponentType
end
declare MeshFilter: MeshFilterType

declare class MouseEventBase extends EventBase
end
declare class MouseEventBaseType extends EventBaseType
end
declare MouseEventBase: MouseEventBaseType

declare class Overflow extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class OverflowType extends EnumType
    Hidden: Overflow
    Visible: Overflow
end
declare Overflow: OverflowType

declare class OverflowClipBox extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class OverflowClipBoxType extends EnumType
    ContentBox: OverflowClipBox
    PaddingBox: OverflowClipBox
end
declare OverflowClipBox: OverflowClipBoxType

declare class PageChanged extends EventBase
    eventTypeId: number
    newPage: number
    oldPage: number
    function __tostring(self): string
end
declare class PageChangedType extends EventBaseType
end
declare PageChanged: PageChangedType

declare class PageDidChange extends EventBase
    eventTypeId: number
    function __tostring(self): string
end
declare class PageDidChangeType extends EventBaseType
end
declare PageDidChange: PageDidChangeType

declare class PageReset extends EventBase
    eventTypeId: number
    page: number
    function __tostring(self): string
end
declare class PageResetType extends EventBaseType
end
declare PageReset: PageResetType

declare class PanelChangedEventBase extends EventBase
end
declare class PanelChangedEventBaseType extends EventBaseType
end
declare PanelChangedEventBase: PanelChangedEventBaseType

declare class ParticleSystem extends Component
    has3DParticleRotations: boolean
    hasNonUniformParticleSizes: boolean
    isEmitting: boolean
    isPaused: boolean
    isPlaying: boolean
    isStopped: boolean
    particleCount: number
    proceduralSimulationSupported: boolean
    randomSeed: number
    time: number
    totalTime: number
    useAutoRandomSeed: boolean
    function __tostring(self): string
    function Clear(self)
    function Clear(self, withChildren: boolean)
    function Emit(self, count: number)
    function IsAlive(self): boolean
    function IsAlive(self, withChildren: boolean): boolean
    function Pause(self)
    function Pause(self, withChildren: boolean)
    function Play(self)
    function Play(self, withChildren: boolean)
    function Simulate(self, t: number)
    function Simulate(self, t: number, withChildren: boolean)
    function Simulate(self, t: number, withChildren: boolean, restart: boolean)
    function Simulate(self, t: number, withChildren: boolean, restart: boolean, fixedTimeStep: boolean)
    function Stop(self)
    function Stop(self, withChildren: boolean)
    function TriggerSubEmitter(self, subEmitterIndex: number)
end
declare class ParticleSystemType extends ComponentType
end
declare ParticleSystem: ParticleSystemType

declare class PickingMode extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class PickingModeType extends EnumType
    Ignore: PickingMode
    Position: PickingMode
end
declare PickingMode: PickingModeType

declare class PinchGestureBegan extends EventBase
    deltaPosition: Vector2
    direction: Vector2
    distance: number
    eventTypeId: number
    isPinching: boolean
    position: Vector2
    scale: number
    screenPosition: Vector2
    screenStartPosition: Vector2
    startPosition: Vector2
    function __tostring(self): string
end
declare class PinchGestureBeganType extends EventBaseType
end
declare PinchGestureBegan: PinchGestureBeganType

declare class PinchGestureChanged extends EventBase
    deltaPosition: Vector2
    direction: Vector2
    distance: number
    eventTypeId: number
    isPinching: boolean
    position: Vector2
    scale: number
    screenPosition: Vector2
    screenStartPosition: Vector2
    startPosition: Vector2
    function __tostring(self): string
end
declare class PinchGestureChangedType extends EventBaseType
end
declare PinchGestureChanged: PinchGestureChangedType

declare class PinchGestureEnded extends EventBase
    deltaPosition: Vector2
    distance: number
    eventTypeId: number
    position: Vector2
    scale: number
    screenPosition: Vector2
    screenStartPosition: Vector2
    startPosition: Vector2
    velocity: Vector2
    function __tostring(self): string
end
declare class PinchGestureEndedType extends EventBaseType
end
declare PinchGestureEnded: PinchGestureEndedType

declare class PlayerCharacterController extends Component
    options: { enabled: boolean, tapToMoveEnabled: boolean, tapHandlersEnabled: boolean, enableLongPress: boolean, tapMask: number, characterLongPress: { height: number, bounceDuration: number } }
end
declare class PlayerCharacterControllerType extends ComponentType
end
declare PlayerCharacterController: PlayerCharacterControllerType

declare class PointerEventBase extends EventBase
end
declare class PointerEventBaseType extends EventBaseType
end
declare PointerEventBase: PointerEventBaseType

declare class Position extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class PositionType extends EnumType
    Absolute: Position
    Relative: Position
end
declare Position: PositionType

declare class PressEffect extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class PressEffectType extends EnumType
    Highlight: PressEffect
    NONE: PressEffect
    Press: PressEffect
end
declare PressEffect: PressEffectType

declare class PressEvent extends EventBase
    eventTypeId: number
    position: Vector2
    screenPosition: Vector2
    function __tostring(self): string
end
declare class PressEventType extends EventBaseType
end
declare PressEvent: PressEventType

declare class PressGesture extends Gesture
    function __tostring(self): string
end
declare class PressGestureType extends GestureType
end
declare PressGesture: PressGestureType

declare class Renderer extends Component
    allowOcclusionWhenDynamic: boolean
    bounds: Bounds
    enabled: boolean
    forceRenderingOff: boolean
    isPartOfStaticBatch: boolean
    isVisible: boolean
    lightmapIndex: number
    lightmapScaleOffset: Vector4
    lightProbeProxyVolumeOverride: GameObject
    localBounds: Bounds
    localToWorldMatrix: Matrix4x4
    material: Material
    materials: {Material}
    probeAnchor: Transform
    realtimeLightmapIndex: number
    realtimeLightmapScaleOffset: Vector4
    receiveShadows: boolean
    rendererPriority: number
    renderingLayerMask: number
    sharedMaterial: Material
    sharedMaterials: {Material}
    sortingLayerID: number
    sortingLayerName: string
    sortingOrder: number
    staticShadowCaster: boolean
    worldToLocalMatrix: Matrix4x4
    function __tostring(self): string
    function HasPropertyBlock(self): boolean
    function ResetBounds(self)
    function ResetLocalBounds(self)
    function SetMaterials(self, materials: {Material})
    function SetPropertyBlock(self, properties: MaterialPropertyBlock)
    function SetPropertyBlock(self, properties: MaterialPropertyBlock, materialIndex: number)
    function SetSharedMaterials(self, materials: {Material})
end
declare class RendererType extends ComponentType
end
declare Renderer: RendererType

declare class Repeat extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class RepeatType extends EnumType
    NoRepeat: Repeat
    Repeat: Repeat
    Round: Repeat
    Space: Repeat
end
declare Repeat: RepeatType

declare class Rigidbody extends Component
    angularDrag: number
    angularVelocity: Vector3
    automaticCenterOfMass: boolean
    automaticInertiaTensor: boolean
    centerOfMass: Vector3
    detectCollisions: boolean
    drag: number
    excludeLayers: LayerMask
    freezeRotation: boolean
    includeLayers: LayerMask
    inertiaTensor: Vector3
    inertiaTensorRotation: Quaternion
    isKinematic: boolean
    mass: number
    maxAngularVelocity: number
    maxDepenetrationVelocity: number
    maxLinearVelocity: number
    position: Vector3
    rotation: Quaternion
    sleepThreshold: number
    solverIterations: number
    solverVelocityIterations: number
    useGravity: boolean
    velocity: Vector3
    worldCenterOfMass: Vector3
    function __tostring(self): string
    function AddExplosionForce(self, explosionForce: number, explosionPosition: Vector3, explosionRadius: number)
    function AddExplosionForce(self, explosionForce: number, explosionPosition: Vector3, explosionRadius: number, upwardsModifier: number)
    function AddExplosionForce(self, explosionForce: number, explosionPosition: Vector3, explosionRadius: number, upwardsModifier: number, mode: ForceMode)
    function AddForce(self, force: Vector3)
    function AddForce(self, force: Vector3, mode: ForceMode)
    function AddForce(self, x: number, y: number, z: number)
    function AddForce(self, x: number, y: number, z: number, mode: ForceMode)
    function AddForceAtPosition(self, force: Vector3, position: Vector3)
    function AddForceAtPosition(self, force: Vector3, position: Vector3, mode: ForceMode)
    function AddRelativeForce(self, force: Vector3)
    function AddRelativeForce(self, force: Vector3, mode: ForceMode)
    function AddRelativeForce(self, x: number, y: number, z: number)
    function AddRelativeForce(self, x: number, y: number, z: number, mode: ForceMode)
    function AddRelativeTorque(self, torque: Vector3)
    function AddRelativeTorque(self, torque: Vector3, mode: ForceMode)
    function AddRelativeTorque(self, x: number, y: number, z: number)
    function AddRelativeTorque(self, x: number, y: number, z: number, mode: ForceMode)
    function AddTorque(self, torque: Vector3)
    function AddTorque(self, torque: Vector3, mode: ForceMode)
    function AddTorque(self, x: number, y: number, z: number)
    function AddTorque(self, x: number, y: number, z: number, mode: ForceMode)
    function ClosestPointOnBounds(self, position: Vector3): Vector3
    function GetAccumulatedForce(self): Vector3
    function GetAccumulatedForce(self, step: number): Vector3
    function GetAccumulatedTorque(self): Vector3
    function GetAccumulatedTorque(self, step: number): Vector3
    function GetPointVelocity(self, worldPoint: Vector3): Vector3
    function GetRelativePointVelocity(self, relativePoint: Vector3): Vector3
    function IsSleeping(self): boolean
    function Move(self, position: Vector3, rotation: Quaternion)
    function MovePosition(self, position: Vector3)
    function MoveRotation(self, rot: Quaternion)
    function ResetCenterOfMass(self)
    function ResetInertiaTensor(self)
    function SetDensity(self, density: number)
    function Sleep(self)
    function SweepTest(self, direction: Vector3): (boolean, RaycastHit)
    function SweepTest(self, direction: Vector3, maxDistance: number): (boolean, RaycastHit)
    function SweepTestAll(self, direction: Vector3): {RaycastHit}
    function SweepTestAll(self, direction: Vector3, maxDistance: number): {RaycastHit}
    function WakeUp(self)
end
declare class RigidbodyType extends ComponentType
end
declare Rigidbody: RigidbodyType

declare class RoomAsset extends ScriptableObject
    function __tostring(self): string
end
declare class RoomAssetType extends ScriptableObjectType
    new: (() -> RoomAsset)
end
declare RoomAsset: RoomAssetType

declare class SingleClickEvent extends EventBase
    eventTypeId: number
    function __tostring(self): string
end
declare class SingleClickEventType extends EventBaseType
end
declare SingleClickEvent: SingleClickEventType

declare class Space extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class SpaceType extends EnumType
    Self: Space
    World: Space
end
declare Space: SpaceType

declare class StyleKeyword extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class StyleKeywordType extends EnumType
    Auto: StyleKeyword
    Initial: StyleKeyword
    None: StyleKeyword
    Null: StyleKeyword
    Undefined: StyleKeyword
end
declare StyleKeyword: StyleKeywordType

declare class SwipeEvent extends EventBase
    eventTypeId: number
    velocity: number
    function __tostring(self): string
end
declare class SwipeEventType extends EventBaseType
end
declare SwipeEvent: SwipeEventType

declare class SwipeFromEdgeBegan extends EventBase
    dragDistance: number
    eventTypeId: number
    function __tostring(self): string
end
declare class SwipeFromEdgeBeganType extends EventBaseType
end
declare SwipeFromEdgeBegan: SwipeFromEdgeBeganType

declare class SwipeFromEdgeCanceled extends EventBase
    dragDistance: number
    eventTypeId: number
    velocity: number
    function __tostring(self): string
end
declare class SwipeFromEdgeCanceledType extends EventBaseType
end
declare SwipeFromEdgeCanceled: SwipeFromEdgeCanceledType

declare class SwipeFromEdgeChanged extends EventBase
    dragDistance: number
    eventTypeId: number
    function __tostring(self): string
end
declare class SwipeFromEdgeChangedType extends EventBaseType
end
declare SwipeFromEdgeChanged: SwipeFromEdgeChangedType

declare class SwipeFromEdgeEnded extends EventBase
    dragDistance: number
    eventTypeId: number
    velocity: number
    function __tostring(self): string
end
declare class SwipeFromEdgeEndedType extends EventBaseType
end
declare SwipeFromEdgeEnded: SwipeFromEdgeEndedType

declare class TapEvent extends EventBase
    eventTypeId: number
    position: Vector2
    screenPosition: Vector2
    startFrame: number
    function __tostring(self): string
    function CloneInto(self, clone: TapEvent): TapEvent
end
declare class TapEventType extends EventBaseType
end
declare TapEvent: TapEventType

declare class TapGesture extends Gesture
    function __tostring(self): string
end
declare class TapGestureType extends GestureType
    cancelThreshold: number
    durationThreshold: number
end
declare TapGesture: TapGestureType

declare class TextAnchor extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class TextAnchorType extends EnumType
    LowerCenter: TextAnchor
    LowerLeft: TextAnchor
    LowerRight: TextAnchor
    MiddleCenter: TextAnchor
    MiddleLeft: TextAnchor
    MiddleRight: TextAnchor
    UpperCenter: TextAnchor
    UpperLeft: TextAnchor
    UpperRight: TextAnchor
end
declare TextAnchor: TextAnchorType

declare class TextOverflow extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class TextOverflowType extends EnumType
    Clip: TextOverflow
    Ellipsis: TextOverflow
end
declare TextOverflow: TextOverflowType

declare class TextOverflowPosition extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class TextOverflowPositionType extends EnumType
    End: TextOverflowPosition
    Middle: TextOverflowPosition
    Start: TextOverflowPosition
end
declare TextOverflowPosition: TextOverflowPositionType

declare class Texture2D extends Texture
    activeMipmapLimit: number
    calculatedMipmapLevel: number
    desiredMipmapLevel: number
    ignoreMipmapLimit: boolean
    isReadable: boolean
    loadedMipmapLevel: number
    loadingMipmapLevel: number
    minimumMipmapLevel: number
    mipmapLimitGroup: string
    requestedMipmapLevel: number
    streamingMipmaps: boolean
    streamingMipmapsPriority: number
    vtOnly: boolean
    function __tostring(self): string
    function Apply(self)
    function Apply(self, updateMipmaps: boolean)
    function Apply(self, updateMipmaps: boolean, makeNoLongerReadable: boolean)
    function ClearMinimumMipmapLevel(self)
    function ClearRequestedMipmapLevel(self)
    function Compress(self, highQuality: boolean)
    function GetPixel(self, x: number, y: number): Color
    function GetPixel(self, x: number, y: number, mipLevel: number): Color
    function GetPixelBilinear(self, u: number, v: number): Color
    function GetPixelBilinear(self, u: number, v: number, mipLevel: number): Color
    function GetPixels(self): {Color}
    function GetPixels(self, miplevel: number): {Color}
    function GetPixels(self, x: number, y: number, blockWidth: number, blockHeight: number): {Color}
    function GetPixels(self, x: number, y: number, blockWidth: number, blockHeight: number, miplevel: number): {Color}
    function IsRequestedMipmapLevelLoaded(self): boolean
    function ReadPixels(self, source: Rect, destX: number, destY: number)
    function ReadPixels(self, source: Rect, destX: number, destY: number, recalculateMipMaps: boolean)
    function Reinitialize(self, width: number, height: number): boolean
    function SetPixel(self, x: number, y: number, color: Color)
    function SetPixel(self, x: number, y: number, color: Color, mipLevel: number)
end
declare class Texture2DType extends TextureType
    blackTexture: Texture2D
    grayTexture: Texture2D
    linearGrayTexture: Texture2D
    normalTexture: Texture2D
    redTexture: Texture2D
    whiteTexture: Texture2D
    new: ((width: number, height: number) -> Texture2D)
end
declare Texture2D: Texture2DType

declare class Texture3D extends Texture
    depth: number
    isReadable: boolean
    function __tostring(self): string
    function Apply(self)
    function Apply(self, updateMipmaps: boolean)
    function Apply(self, updateMipmaps: boolean, makeNoLongerReadable: boolean)
    function GetPixel(self, x: number, y: number, z: number): Color
    function GetPixel(self, x: number, y: number, z: number, mipLevel: number): Color
    function GetPixelBilinear(self, u: number, v: number, w: number): Color
    function GetPixelBilinear(self, u: number, v: number, w: number, mipLevel: number): Color
    function GetPixels(self): {Color}
    function GetPixels(self, miplevel: number): {Color}
    function SetPixel(self, x: number, y: number, z: number, color: Color)
    function SetPixel(self, x: number, y: number, z: number, color: Color, mipLevel: number)
end
declare class Texture3DType extends TextureType
end
declare Texture3D: Texture3DType

declare class Transform extends Component
    childCount: number
    eulerAngles: Vector3
    forward: Vector3
    hasChanged: boolean
    hierarchyCapacity: number
    hierarchyCount: number
    localEulerAngles: Vector3
    localPosition: Vector3
    localRotation: Quaternion
    localScale: Vector3
    localToWorldMatrix: Matrix4x4
    lossyScale: Vector3
    parent: Transform
    position: Vector3
    right: Vector3
    root: Transform
    rotation: Quaternion
    up: Vector3
    worldToLocalMatrix: Matrix4x4
    function __tostring(self): string
    function DetachChildren(self)
    function Find(self, n: string): Transform
    function GetChild(self, index: number): Transform
    function GetLocalPositionAndRotation(self): (Vector3, Quaternion)
    function GetPositionAndRotation(self): (Vector3, Quaternion)
    function GetSiblingIndex(self): number
    function InverseTransformDirection(self, direction: Vector3): Vector3
    function InverseTransformPoint(self, position: Vector3): Vector3
    function InverseTransformVector(self, vector: Vector3): Vector3
    function IsChildOf(self, parent: Transform): boolean
    function LookAt(self, target: Transform)
    function LookAt(self, target: Transform, worldUp: Vector3)
    function LookAt(self, target: Vector3)
    function LookAt(self, worldPosition: Vector3, worldUp: Vector3)
    function Rotate(self, axis: Vector3, angle: number)
    function Rotate(self, axis: Vector3, angle: number, relativeTo: Space)
    function Rotate(self, eulers: Vector3)
    function Rotate(self, eulers: Vector3, relativeTo: Space)
    function Rotate(self, xAngle: number, yAngle: number, zAngle: number)
    function Rotate(self, xAngle: number, yAngle: number, zAngle: number, relativeTo: Space)
    function RotateAround(self, point: Vector3, axis: Vector3, angle: number)
    function SetAsFirstSibling(self)
    function SetAsLastSibling(self)
    function SetLocalPositionAndRotation(self, localPosition: Vector3, localRotation: Quaternion)
    function SetParent(self, parent: Transform)
    function SetParent(self, parent: Transform, worldPositionStays: boolean)
    function SetPositionAndRotation(self, position: Vector3, rotation: Quaternion)
    function SetSiblingIndex(self, index: number)
    function TransformDirection(self, direction: Vector3): Vector3
    function TransformPoint(self, position: Vector3): Vector3
    function TransformVector(self, vector: Vector3): Vector3
    function Translate(self, translation: Vector3)
    function Translate(self, translation: Vector3, relativeTo: Space)
    function Translate(self, translation: Vector3, relativeTo: Transform)
    function Translate(self, x: number, y: number, z: number)
    function Translate(self, x: number, y: number, z: number, relativeTo: Space)
    function Translate(self, x: number, y: number, z: number, relativeTo: Transform)
    function TweenLocalPosition(self, from: Vector3, to: Vector3): Tween
    function TweenLocalPositionTo(self, to: Vector3): Tween
    function TweenLocalScale(self, from: Vector3, to: Vector3): Tween
    function TweenLocalScaleTo(self, to: Vector3): Tween
    function TweenPosition(self, from: Vector3, to: Vector3): Tween
    function TweenPositionTo(self, to: Vector3): Tween
end
declare class TransformType extends ComponentType
end
declare Transform: TransformType

declare class TransitionEventBase extends EventBase
end
declare class TransitionEventBaseType extends EventBaseType
end
declare TransitionEventBase: TransitionEventBaseType

declare class TrickleDown extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class TrickleDownType extends EnumType
    NoTrickleDown: TrickleDown
    TrickleDown: TrickleDown
end
declare TrickleDown: TrickleDownType

declare class UICollectionDelegateProvider extends UICollectionProvider
    function __tostring(self): string
    function BindCell(self, cell: UIView, index: number)
    function CellForIndex(self, index: number): UIView
    function Dispose(self)
end
declare class UICollectionDelegateProviderType extends UICollectionProviderType
    new: ((cellFromIndex: (number) -> (UIView)) -> UICollectionDelegateProvider)
    new: ((cellFromIndex: (number) -> (UIView), bindCell: (UIView, number) -> ()) -> UICollectionDelegateProvider)
end
declare UICollectionDelegateProvider: UICollectionDelegateProviderType

declare class Visibility extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class VisibilityType extends EnumType
    Hidden: Visibility
    Visible: Visibility
end
declare Visibility: VisibilityType

declare class VisualTreeAsset extends ScriptableObject
    contentHash: number
    importedWithErrors: boolean
    importedWithWarnings: boolean
    templateDependencies: {VisualTreeAsset}
    function __tostring(self): string
    function CloneTree(self, target: VisualElement)
end
declare class VisualTreeAssetType extends ScriptableObjectType
end
declare VisualTreeAsset: VisualTreeAssetType

declare class WhiteSpace extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class WhiteSpaceType extends EnumType
    Normal: WhiteSpace
    NoWrap: WhiteSpace
end
declare WhiteSpace: WhiteSpaceType

declare class Wrap extends Enum
    function __tostring(self): string
    function __tostring(self, format: string): string
end
declare class WrapType extends EnumType
    NoWrap: Wrap
    Wrap: Wrap
    WrapReverse: Wrap
end
declare Wrap: WrapType

declare class Animator extends Behaviour
    angularVelocity: Vector3
    applyRootMotion: boolean
    avatarRoot: Transform
    bodyPosition: Vector3
    bodyRotation: Quaternion
    deltaPosition: Vector3
    deltaRotation: Quaternion
    feetPivotActive: number
    fireEvents: boolean
    gravityWeight: number
    hasBoundPlayables: boolean
    hasRootMotion: boolean
    hasTransformHierarchy: boolean
    humanScale: number
    isHuman: boolean
    isInitialized: boolean
    isMatchingTarget: boolean
    isOptimizable: boolean
    keepAnimatorStateOnDisable: boolean
    layerCount: number
    layersAffectMassCenter: boolean
    leftFeetBottomHeight: number
    logWarnings: boolean
    parameterCount: number
    pivotPosition: Vector3
    pivotWeight: number
    playbackTime: number
    recorderStartTime: number
    recorderStopTime: number
    rightFeetBottomHeight: number
    rootPosition: Vector3
    rootRotation: Quaternion
    speed: number
    stabilizeFeet: boolean
    targetPosition: Vector3
    targetRotation: Quaternion
    velocity: Vector3
    writeDefaultValuesOnDisable: boolean
    function __tostring(self): string
    function ApplyBuiltinRootMotion(self)
    function CrossFade(self, stateHashName: number, normalizedTransitionDuration: number)
    function CrossFade(self, stateHashName: number, normalizedTransitionDuration: number, layer: number)
    function CrossFade(self, stateHashName: number, normalizedTransitionDuration: number, layer: number, normalizedTimeOffset: number)
    function CrossFade(self, stateHashName: number, normalizedTransitionDuration: number, layer: number, normalizedTimeOffset: number, normalizedTransitionTime: number)
    function CrossFade(self, stateName: string, normalizedTransitionDuration: number)
    function CrossFade(self, stateName: string, normalizedTransitionDuration: number, layer: number)
    function CrossFade(self, stateName: string, normalizedTransitionDuration: number, layer: number, normalizedTimeOffset: number)
    function CrossFade(self, stateName: string, normalizedTransitionDuration: number, layer: number, normalizedTimeOffset: number, normalizedTransitionTime: number)
    function CrossFadeInFixedTime(self, stateHashName: number, fixedTransitionDuration: number)
    function CrossFadeInFixedTime(self, stateHashName: number, fixedTransitionDuration: number, layer: number)
    function CrossFadeInFixedTime(self, stateHashName: number, fixedTransitionDuration: number, layer: number, fixedTimeOffset: number)
    function CrossFadeInFixedTime(self, stateHashName: number, fixedTransitionDuration: number, layer: number, fixedTimeOffset: number, normalizedTransitionTime: number)
    function CrossFadeInFixedTime(self, stateName: string, fixedTransitionDuration: number)
    function CrossFadeInFixedTime(self, stateName: string, fixedTransitionDuration: number, layer: number)
    function CrossFadeInFixedTime(self, stateName: string, fixedTransitionDuration: number, layer: number, fixedTimeOffset: number)
    function CrossFadeInFixedTime(self, stateName: string, fixedTransitionDuration: number, layer: number, fixedTimeOffset: number, normalizedTransitionTime: number)
    function GetBool(self, id: number): boolean
    function GetBool(self, name: string): boolean
    function GetCurrentAnimatorClipInfoCount(self, layerIndex: number): number
    function GetCurrentAnimatorStateInfo(self, layerIndex: number): AnimatorStateInfo
    function GetFloat(self, id: number): number
    function GetFloat(self, name: string): number
    function GetInteger(self, id: number): number
    function GetInteger(self, name: string): number
    function GetLayerIndex(self, layerName: string): number
    function GetLayerName(self, layerIndex: number): string
    function GetLayerWeight(self, layerIndex: number): number
    function GetNextAnimatorClipInfoCount(self, layerIndex: number): number
    function GetNextAnimatorStateInfo(self, layerIndex: number): AnimatorStateInfo
    function HasState(self, layerIndex: number, stateID: number): boolean
    function InterruptMatchTarget(self)
    function InterruptMatchTarget(self, completeMatch: boolean)
    function IsInTransition(self, layerIndex: number): boolean
    function IsParameterControlledByCurve(self, id: number): boolean
    function IsParameterControlledByCurve(self, name: string): boolean
    function Play(self, stateName: string)
    function Play(self, stateName: string, layer: number)
    function Play(self, stateName: string, layer: number, normalizedTime: number)
    function Play(self, stateNameHash: number)
    function Play(self, stateNameHash: number, layer: number)
    function Play(self, stateNameHash: number, layer: number, normalizedTime: number)
    function PlayInFixedTime(self, stateName: string)
    function PlayInFixedTime(self, stateName: string, layer: number)
    function PlayInFixedTime(self, stateName: string, layer: number, fixedTime: number)
    function PlayInFixedTime(self, stateNameHash: number)
    function PlayInFixedTime(self, stateNameHash: number, layer: number)
    function PlayInFixedTime(self, stateNameHash: number, layer: number, fixedTime: number)
    function Rebind(self)
    function ResetTrigger(self, id: number)
    function ResetTrigger(self, name: string)
    function SetBool(self, id: number, value: boolean)
    function SetBool(self, name: string, value: boolean)
    function SetFloat(self, id: number, value: number)
    function SetFloat(self, id: number, value: number, dampTime: number, deltaTime: number)
    function SetFloat(self, name: string, value: number)
    function SetFloat(self, name: string, value: number, dampTime: number, deltaTime: number)
    function SetInteger(self, id: number, value: number)
    function SetInteger(self, name: string, value: number)
    function SetLayerWeight(self, layerIndex: number, weight: number)
    function SetLookAtPosition(self, lookAtPosition: Vector3)
    function SetLookAtWeight(self, weight: number)
    function SetLookAtWeight(self, weight: number, bodyWeight: number)
    function SetLookAtWeight(self, weight: number, bodyWeight: number, headWeight: number)
    function SetLookAtWeight(self, weight: number, bodyWeight: number, headWeight: number, eyesWeight: number)
    function SetLookAtWeight(self, weight: number, bodyWeight: number, headWeight: number, eyesWeight: number, clampWeight: number)
    function SetTrigger(self, id: number)
    function SetTrigger(self, name: string)
    function StartPlayback(self)
    function StartRecording(self, frameCount: number)
    function StopPlayback(self)
    function StopRecording(self)
    function Update(self, deltaTime: number)
    function WriteDefaultValues(self)
end
declare class AnimatorType extends BehaviourType
    StringToHash: ((name: string) -> number)
end
declare Animator: AnimatorType

declare class Asset extends AsyncScriptableObject
end
declare class AssetType extends AsyncScriptableObjectType
end
declare Asset: AssetType

declare class AttachToPanelEvent extends PanelChangedEventBase
    destinationPanel: IPanel
    eventTypeId: number
    originPanel: IPanel
    function __tostring(self): string
end
declare class AttachToPanelEventType extends PanelChangedEventBaseType
end
declare AttachToPanelEvent: AttachToPanelEventType

declare class AudioBehaviour extends Behaviour
    function __tostring(self): string
end
declare class AudioBehaviourType extends BehaviourType
end
declare AudioBehaviour: AudioBehaviourType

declare class BlurEvent extends FocusEventBase
    eventTypeId: number
    relatedTarget: Focusable
    function __tostring(self): string
end
declare class BlurEventType extends FocusEventBaseType
end
declare BlurEvent: BlurEventType

declare class BoxCollider extends Collider
    center: Vector3
    size: Vector3
    function __tostring(self): string
end
declare class BoxColliderType extends ColliderType
end
declare BoxCollider: BoxColliderType

declare class Camera extends Behaviour
    allowDynamicResolution: boolean
    allowHDR: boolean
    allowMSAA: boolean
    anamorphism: number
    aperture: number
    aspect: number
    backgroundColor: Color
    barrelClipping: number
    bladeCount: number
    cameraToWorldMatrix: Matrix4x4
    clearStencilAfterLightingPass: boolean
    cullingMask: number
    cullingMatrix: Matrix4x4
    curvature: Vector2
    depth: number
    eventMask: number
    farClipPlane: number
    fieldOfView: number
    focalLength: number
    focusDistance: number
    forceIntoRenderTexture: boolean
    iso: number
    layerCullSpherical: boolean
    lensShift: Vector2
    nearClipPlane: number
    nonJitteredProjectionMatrix: Matrix4x4
    orthographic: boolean
    orthographicSize: number
    overrideSceneCullingMask: number
    pixelHeight: number
    pixelRect: Rect
    pixelWidth: number
    previousViewProjectionMatrix: Matrix4x4
    projectionMatrix: Matrix4x4
    rect: Rect
    scaledPixelHeight: number
    scaledPixelWidth: number
    sensorSize: Vector2
    shutterSpeed: number
    transparencySortAxis: Vector3
    useJitteredProjectionMatrixForTransparentRendering: boolean
    useOcclusionCulling: boolean
    usePhysicalProperties: boolean
    velocity: Vector3
    worldToCameraMatrix: Matrix4x4
    function __tostring(self): string
    function CalculateObliqueMatrix(self, clipPlane: Vector4): Matrix4x4
    function CopyFrom(self, other: Camera)
    function GetGateFittedFieldOfView(self): number
    function GetGateFittedLensShift(self): Vector2
    function Render(self)
    function RenderWithShader(self, shader: Shader, replacementTag: string)
    function Reset(self)
    function ResetAspect(self)
    function ResetCullingMatrix(self)
    function ResetProjectionMatrix(self)
    function ResetReplacementShader(self)
    function ResetTransparencySortSettings(self)
    function ResetWorldToCameraMatrix(self)
    function ScreenPointToRay(self, point: Vector2): Ray
    function ScreenPointToRay(self, point: Vector3): Ray
    function ScreenToViewportPoint(self, position: Vector3): Vector3
    function ScreenToWorldPoint(self, point: Vector3): Vector3
    function SetReplacementShader(self, shader: Shader, replacementTag: string)
    function ViewportPointToRay(self, pos: Vector3): Ray
    function ViewportToScreenPoint(self, position: Vector3): Vector3
    function ViewportToWorldPoint(self, position: Vector3): Vector3
    function WorldToScreenPoint(self, point: Vector3): Vector3
    function WorldToViewportPoint(self, position: Vector3): Vector3
end
declare class CameraType extends BehaviourType
    allCameras: {Camera}
    allCamerasCount: number
    current: Camera
    kMaxAperture: number
    kMaxBladeCount: number
    kMinAperture: number
    kMinBladeCount: number
    main: Camera
    CalculateProjectionMatrixFromPhysicalProperties: ((focalLength: number, sensorSize: Vector2, lensShift: Vector2, nearClip: number, farClip: number) -> Matrix4x4)
    FieldOfViewToFocalLength: ((fieldOfView: number, sensorSize: number) -> number)
    FocalLengthToFieldOfView: ((focalLength: number, sensorSize: number) -> number)
    HorizontalToVerticalFieldOfView: ((horizontalFieldOfView: number, aspectRatio: number) -> number)
    VerticalToHorizontalFieldOfView: ((verticalFieldOfView: number, aspectRatio: number) -> number)
end
declare Camera: CameraType

declare class CapsuleCollider extends Collider
    center: Vector3
    direction: number
    height: number
    radius: number
    function __tostring(self): string
end
declare class CapsuleColliderType extends ColliderType
end
declare CapsuleCollider: CapsuleColliderType

declare class DetachFromPanelEvent extends PanelChangedEventBase
    destinationPanel: IPanel
    eventTypeId: number
    originPanel: IPanel
    function __tostring(self): string
end
declare class DetachFromPanelEventType extends PanelChangedEventBaseType
end
declare DetachFromPanelEvent: DetachFromPanelEventType

declare class FocusEvent extends FocusEventBase
    eventTypeId: number
    relatedTarget: Focusable
    function __tostring(self): string
end
declare class FocusEventType extends FocusEventBaseType
end
declare FocusEvent: FocusEventType

declare class FocusInEvent extends FocusEventBase
    eventTypeId: number
    relatedTarget: Focusable
    function __tostring(self): string
end
declare class FocusInEventType extends FocusEventBaseType
end
declare FocusInEvent: FocusInEventType

declare class FocusOutEvent extends FocusEventBase
    eventTypeId: number
    relatedTarget: Focusable
    function __tostring(self): string
end
declare class FocusOutEventType extends FocusEventBaseType
end
declare FocusOutEvent: FocusOutEventType

declare class LineRenderer extends Renderer
    colorGradient: Gradient
    endColor: Color
    endWidth: number
    generateLightingData: boolean
    loop: boolean
    numCapVertices: number
    numCornerVertices: number
    positionCount: number
    shadowBias: number
    startColor: Color
    startWidth: number
    textureScale: Vector2
    useWorldSpace: boolean
    widthCurve: AnimationCurve
    widthMultiplier: number
    function __tostring(self): string
    function BakeMesh(self, mesh: Mesh)
    function BakeMesh(self, mesh: Mesh, camera: Camera)
    function BakeMesh(self, mesh: Mesh, camera: Camera, useTransform: boolean)
    function BakeMesh(self, mesh: Mesh, useTransform: boolean)
    function GetPosition(self, index: number): Vector3
    function SetPosition(self, index: number, position: Vector3)
    function SetPositions(self, positions: {Vector3})
    function Simplify(self, tolerance: number)
end
declare class LineRendererType extends RendererType
end
declare LineRenderer: LineRendererType

declare class LuaChangeEvent extends ChangeEvent
end
declare class LuaChangeEventType extends ChangeEventType
end
declare LuaChangeEvent: LuaChangeEventType

declare class MeshCollider extends Collider
    convex: boolean
    sharedMesh: Mesh
    function __tostring(self): string
end
declare class MeshColliderType extends ColliderType
end
declare MeshCollider: MeshColliderType

declare class MeshRenderer extends Renderer
    subMeshStartIndex: number
    function __tostring(self): string
end
declare class MeshRendererType extends RendererType
end
declare MeshRenderer: MeshRendererType

declare class MonoBehaviour extends Behaviour
    function __tostring(self): string
end
declare class MonoBehaviourType extends BehaviourType
end
declare MonoBehaviour: MonoBehaviourType

declare class NavMeshAgent extends Behaviour
    acceleration: number
    agentTypeID: number
    angularSpeed: number
    areaMask: number
    autoBraking: boolean
    autoRepath: boolean
    autoTraverseOffMeshLink: boolean
    avoidancePriority: number
    baseOffset: number
    desiredVelocity: Vector3
    destination: Vector3
    hasPath: boolean
    height: number
    isOnNavMesh: boolean
    isOnOffMeshLink: boolean
    isPathStale: boolean
    isStopped: boolean
    navMeshOwner: Object
    nextPosition: Vector3
    pathEndPosition: Vector3
    pathPending: boolean
    radius: number
    remainingDistance: number
    speed: number
    steeringTarget: Vector3
    stoppingDistance: number
    updatePosition: boolean
    updateRotation: boolean
    updateUpAxis: boolean
    velocity: Vector3
    function __tostring(self): string
    function ActivateCurrentOffMeshLink(self, activated: boolean)
    function CompleteOffMeshLink(self)
    function FindClosestEdge(self): (boolean, NavMeshHit)
    function GetAreaCost(self, areaIndex: number): number
    function Move(self, offset: Vector3)
    function Raycast(self, targetPosition: Vector3): (boolean, NavMeshHit)
    function ResetPath(self)
    function SamplePathPosition(self, areaMask: number, maxDistance: number): (boolean, NavMeshHit)
    function SetAreaCost(self, areaIndex: number, areaCost: number)
    function SetDestination(self, target: Vector3): boolean
    function Warp(self, newPosition: Vector3): boolean
end
declare class NavMeshAgentType extends BehaviourType
end
declare NavMeshAgent: NavMeshAgentType

declare class NavMeshObstacle extends Behaviour
    carveOnlyStationary: boolean
    carving: boolean
    carvingMoveThreshold: number
    carvingTimeToStationary: number
    center: Vector3
    height: number
    radius: number
    size: Vector3
    velocity: Vector3
    function __tostring(self): string
end
declare class NavMeshObstacleType extends BehaviourType
end
declare NavMeshObstacle: NavMeshObstacleType

declare class OffMeshLink extends Behaviour
    activated: boolean
    area: number
    autoUpdatePositions: boolean
    biDirectional: boolean
    costOverride: number
    endTransform: Transform
    occupied: boolean
    startTransform: Transform
    function __tostring(self): string
    function UpdatePositions(self)
end
declare class OffMeshLinkType extends BehaviourType
end
declare OffMeshLink: OffMeshLinkType

declare class ParticleSystemForceField extends Behaviour
    endRange: number
    gravityFocus: number
    length: number
    multiplyDragByParticleSize: boolean
    multiplyDragByParticleVelocity: boolean
    rotationRandomness: Vector2
    startRange: number
    vectorField: Texture3D
    function __tostring(self): string
end
declare class ParticleSystemForceFieldType extends BehaviourType
end
declare ParticleSystemForceField: ParticleSystemForceFieldType

declare class PointerDownEvent extends PointerEventBase
    actionKey: boolean
    altitudeAngle: number
    altKey: boolean
    azimuthAngle: number
    button: number
    clickCount: number
    commandKey: boolean
    ctrlKey: boolean
    currentTarget: IEventHandler
    deltaPosition: Vector3
    deltaTime: number
    eventTypeId: number
    isPrimary: boolean
    localPosition: Vector3
    pointerId: number
    pointerType: string
    position: Vector3
    pressedButtons: number
    pressure: number
    radius: Vector2
    radiusVariance: Vector2
    shiftKey: boolean
    tangentialPressure: number
    tilt: Vector2
    twist: number
    function __tostring(self): string
end
declare class PointerDownEventType extends PointerEventBaseType
end
declare PointerDownEvent: PointerDownEventType

declare class PointerMoveEvent extends PointerEventBase
    actionKey: boolean
    altitudeAngle: number
    altKey: boolean
    azimuthAngle: number
    button: number
    clickCount: number
    commandKey: boolean
    ctrlKey: boolean
    currentTarget: IEventHandler
    deltaPosition: Vector3
    deltaTime: number
    eventTypeId: number
    isPrimary: boolean
    localPosition: Vector3
    pointerId: number
    pointerType: string
    position: Vector3
    pressedButtons: number
    pressure: number
    radius: Vector2
    radiusVariance: Vector2
    shiftKey: boolean
    tangentialPressure: number
    tilt: Vector2
    twist: number
    function __tostring(self): string
end
declare class PointerMoveEventType extends PointerEventBaseType
end
declare PointerMoveEvent: PointerMoveEventType

declare class PointerUpEvent extends PointerEventBase
    actionKey: boolean
    altitudeAngle: number
    altKey: boolean
    azimuthAngle: number
    button: number
    clickCount: number
    commandKey: boolean
    ctrlKey: boolean
    currentTarget: IEventHandler
    deltaPosition: Vector3
    deltaTime: number
    eventTypeId: number
    isPrimary: boolean
    localPosition: Vector3
    pointerId: number
    pointerType: string
    position: Vector3
    pressedButtons: number
    pressure: number
    radius: Vector2
    radiusVariance: Vector2
    shiftKey: boolean
    tangentialPressure: number
    tilt: Vector2
    twist: number
    function __tostring(self): string
end
declare class PointerUpEventType extends PointerEventBaseType
end
declare PointerUpEvent: PointerUpEventType

declare class SkinnedMeshRenderer extends Renderer
    bones: {Transform}
    forceMatrixRecalculationPerRender: boolean
    rootBone: Transform
    sharedMesh: Mesh
    skinnedMotionVectors: boolean
    updateWhenOffscreen: boolean
    function __tostring(self): string
    function BakeMesh(self, mesh: Mesh)
    function BakeMesh(self, mesh: Mesh, useScale: boolean)
    function GetBlendShapeWeight(self, index: number): number
    function SetBlendShapeWeight(self, index: number, value: number)
end
declare class SkinnedMeshRendererType extends RendererType
end
declare SkinnedMeshRenderer: SkinnedMeshRendererType

declare class SphereCollider extends Collider
    center: Vector3
    radius: number
    function __tostring(self): string
end
declare class SphereColliderType extends ColliderType
end
declare SphereCollider: SphereColliderType

declare class SpriteRenderer extends Renderer
    adaptiveModeThreshold: number
    color: Color
    flipX: boolean
    flipY: boolean
    size: Vector2
    sprite: Sprite
    function __tostring(self): string
    function RegisterSpriteChangeCallback(self, callback: (SpriteRenderer) -> ())
    function UnregisterSpriteChangeCallback(self, callback: (SpriteRenderer) -> ())
end
declare class SpriteRendererType extends RendererType
end
declare SpriteRenderer: SpriteRendererType

declare class TerrainCollider extends Collider
    function __tostring(self): string
end
declare class TerrainColliderType extends ColliderType
end
declare TerrainCollider: TerrainColliderType

declare class TrailRenderer extends Renderer
    autodestruct: boolean
    colorGradient: Gradient
    emitting: boolean
    endColor: Color
    endWidth: number
    generateLightingData: boolean
    minVertexDistance: number
    numCapVertices: number
    numCornerVertices: number
    positionCount: number
    shadowBias: number
    startColor: Color
    startWidth: number
    textureScale: Vector2
    time: number
    widthCurve: AnimationCurve
    widthMultiplier: number
    function __tostring(self): string
    function AddPosition(self, position: Vector3)
    function AddPositions(self, positions: {Vector3})
    function BakeMesh(self, mesh: Mesh)
    function BakeMesh(self, mesh: Mesh, camera: Camera)
    function BakeMesh(self, mesh: Mesh, camera: Camera, useTransform: boolean)
    function BakeMesh(self, mesh: Mesh, useTransform: boolean)
    function Clear(self)
    function GetPosition(self, index: number): Vector3
    function SetPosition(self, index: number, position: Vector3)
    function SetPositions(self, positions: {Vector3})
end
declare class TrailRendererType extends RendererType
end
declare TrailRenderer: TrailRendererType

declare class TransitionCancelEvent extends TransitionEventBase
    elapsedTime: number
    eventTypeId: number
    function __tostring(self): string
end
declare class TransitionCancelEventType extends TransitionEventBaseType
end
declare TransitionCancelEvent: TransitionCancelEventType

declare class TransitionEndEvent extends TransitionEventBase
    elapsedTime: number
    eventTypeId: number
    function __tostring(self): string
end
declare class TransitionEndEventType extends TransitionEventBaseType
end
declare TransitionEndEvent: TransitionEndEventType

declare class TransitionRunEvent extends TransitionEventBase
    elapsedTime: number
    eventTypeId: number
    function __tostring(self): string
end
declare class TransitionRunEventType extends TransitionEventBaseType
end
declare TransitionRunEvent: TransitionRunEventType

declare class TransitionStartEvent extends TransitionEventBase
    elapsedTime: number
    eventTypeId: number
    function __tostring(self): string
end
declare class TransitionStartEventType extends TransitionEventBaseType
end
declare TransitionStartEvent: TransitionStartEventType

declare class VisualElement extends Focusable
    canGrabFocus: boolean
    childCount: number
    contentContainer: VisualElement
    contentRect: Rect
    customStyle: ICustomStyle
    enabledInHierarchy: boolean
    enabledSelf: boolean
    experimental: IExperimentalFeatures
    layout: Rect
    localBound: Rect
    name: string
    panel: IPanel
    parent: VisualElement
    pickingMode: PickingMode
    resolvedStyle: IResolvedStyle
    schedule: IVisualElementScheduler
    style: IStyle
    tooltip: string
    transform: ITransform
    viewDataKey: string
    visible: boolean
    visualTreeAssetSource: VisualTreeAsset
    worldBound: Rect
    worldTransform: Matrix4x4
    function __tostring(self): string
    function Add(self, child: VisualElement)
    function AddToClassList(self, className: string)
    function BringToFront(self)
    function Children(self): {VisualElement}
    function ClassListContains(self, cls: string): boolean
    function Clear(self)
    function ClearClassList(self)
    function Contains(self, child: VisualElement): boolean
    function ContainsPoint(self, localPoint: Vector2): boolean
    function ElementAt(self, index: number): VisualElement
    function EnableInClassList(self, className: string, enable: boolean)
    function FindCommonAncestor(self, other: VisualElement): VisualElement
    function Focus(self)
    function GetClasses(self): {string}
    function GetResolvedStyleSize(self): Vector2
    function IndexOf(self, element: VisualElement): number
    function Insert(self, index: number, element: VisualElement)
    function IsDisplayed(self): boolean
    function LocalToWorld(self, point: Vector2): Vector2
    function LocalToWorld(self, rect: Rect): Rect
    function MarkDirtyRepaint(self)
    function Overlaps(self, rectangle: Rect): boolean
    function PlaceBehind(self, sibling: VisualElement)
    function PlaceInFront(self, sibling: VisualElement)
    function Q(self): VisualElement
    function Q(self, name: string): VisualElement
    function Q(self, name: string, className: string): VisualElement
    function RegisterCallback(self, type: Type, action: (...any) -> (...any)): Callback
    function RegisterCallback(self, type: Type, action: (...any) -> (...any), phase: TrickleDown): Callback
    function RegisterGesture(self, gesture: Gesture)
    function RegisterLongPressCallback(self, action: (...any) -> (...any)): Callback
    function RegisterLongPressCallback(self, action: (...any) -> (...any), pressEffect: PressEffect): Callback
    function RegisterLongPressCallback(self, action: (...any) -> (...any), pressEffect: PressEffect, sound: boolean): Callback
    function RegisterLongPressCallback(self, action: (...any) -> (...any), pressEffect: PressEffect, sound: boolean, haptic: boolean): Callback
    function RegisterPressCallback(self, action: (...any) -> (...any)): Callback
    function RegisterPressCallback(self, action: (...any) -> (...any), pressEffect: PressEffect): Callback
    function RegisterPressCallback(self, action: (...any) -> (...any), pressEffect: PressEffect, sound: boolean): Callback
    function RegisterPressCallback(self, action: (...any) -> (...any), pressEffect: PressEffect, sound: boolean, haptic: boolean): Callback
    function Remove(self, element: VisualElement)
    function RemoveAt(self, index: number)
    function RemoveFromClassList(self, className: string)
    function RemoveFromHierarchy(self)
    function SendEvent(self, e: EventBase)
    function SendToBack(self)
    function SetDisplay(self, display: boolean)
    function SetEnabled(self, value: boolean)
    function Sort(self, comp: (VisualElement, VisualElement) -> (number))
    function ToggleInClassList(self, className: string)
    function UnregisterCallback(self, callback: Callback)
    function WorldToLocal(self, point: Vector2): Vector2
    function WorldToLocal(self, rect: Rect): Rect
end
declare class VisualElementType extends FocusableType
    disabledUssClassName: string
    new: (() -> VisualElement)
end
declare VisualElement: VisualElementType

declare class WheelEvent extends MouseEventBase
    actionKey: boolean
    altKey: boolean
    button: number
    clickCount: number
    commandKey: boolean
    ctrlKey: boolean
    currentTarget: IEventHandler
    delta: Vector3
    eventTypeId: number
    localMousePosition: Vector2
    mouseDelta: Vector2
    mousePosition: Vector2
    pressedButtons: number
    shiftKey: boolean
    function __tostring(self): string
end
declare class WheelEventType extends MouseEventBaseType
end
declare WheelEvent: WheelEventType

declare class AudioListener extends AudioBehaviour
    function __tostring(self): string
end
declare class AudioListenerType extends AudioBehaviourType
end
declare AudioListener: AudioListenerType

declare class AudioSource extends AudioBehaviour
    bypassEffects: boolean
    bypassListenerEffects: boolean
    bypassReverbZones: boolean
    clip: AudioClip
    dopplerLevel: number
    ignoreListenerPause: boolean
    ignoreListenerVolume: boolean
    isPlaying: boolean
    isVirtual: boolean
    loop: boolean
    maxDistance: number
    minDistance: number
    mute: boolean
    panStereo: number
    pitch: number
    playOnAwake: boolean
    priority: number
    reverbZoneMix: number
    spatialBlend: number
    spatialize: boolean
    spatializePostEffects: boolean
    spread: number
    time: number
    timeSamples: number
    volume: number
    function __tostring(self): string
    function GetSpatializerFloat(self, index: number): (boolean, number)
    function Pause(self)
    function Play(self)
    function Play(self, delay: number)
    function PlayDelayed(self, delay: number)
    function PlayOneShot(self, clip: AudioClip)
    function PlayOneShot(self, clip: AudioClip, volumeScale: number)
    function PlayScheduled(self, time: number)
    function SetScheduledEndTime(self, time: number)
    function SetScheduledStartTime(self, time: number)
    function SetSpatializerFloat(self, index: number, value: number): boolean
    function Stop(self)
    function UnPause(self)
end
declare class AudioSourceType extends AudioBehaviourType
    PlayClipAtPoint: ((clip: AudioClip, position: Vector3) -> ())
    PlayClipAtPoint: ((clip: AudioClip, position: Vector3, volume: number) -> ())
end
declare AudioSource: AudioSourceType

declare class BindableElement extends VisualElement
    binding: IBinding
    bindingPath: string
    function __tostring(self): string
end
declare class BindableElementType extends VisualElementType
    new: (() -> BindableElement)
end
declare BindableElement: BindableElementType

declare class BoolChangeEvent extends LuaChangeEvent
    eventTypeId: number
    newValue: boolean
    previousValue: boolean
    function __tostring(self): string
end
declare class BoolChangeEventType extends LuaChangeEventType
end
declare BoolChangeEvent: BoolChangeEventType

declare class CharacterAnimation extends Asset
    back: AnimationClip
    front: AnimationClip
end
declare class CharacterAnimationType extends AssetType
end
declare CharacterAnimation: CharacterAnimationType

declare class FloatChangeEvent extends LuaChangeEvent
    eventTypeId: number
    newValue: number
    previousValue: number
    function __tostring(self): string
    function Dispose(self)
end
declare class FloatChangeEventType extends LuaChangeEventType
end
declare FloatChangeEvent: FloatChangeEventType

declare class Image extends VisualElement
    image: Texture
    sourceRect: Rect
    sprite: Sprite
    tintColor: Color
    uv: Rect
    function __tostring(self): string
end
declare class ImageType extends VisualElementType
    ussClassName: string
    new: (() -> Image)
end
declare Image: ImageType

declare class IntChangeEvent extends LuaChangeEvent
    eventTypeId: number
    newValue: number
    previousValue: number
    function __tostring(self): string
    function Dispose(self)
end
declare class IntChangeEventType extends LuaChangeEventType
end
declare IntChangeEvent: IntChangeEventType

declare class NavMeshSurface extends MonoBehaviour
    agentTypeID: number
    buildHeightMesh: boolean
    center: Vector3
    defaultArea: number
    ignoreNavMeshAgent: boolean
    ignoreNavMeshObstacle: boolean
    layerMask: LayerMask
    minRegionArea: number
    overrideTileSize: boolean
    overrideVoxelSize: boolean
    size: Vector3
    tileSize: number
    voxelSize: number
    function __tostring(self): string
    function AddData(self)
    function BuildNavMesh(self)
    function RemoveData(self)
end
declare class NavMeshSurfaceType extends MonoBehaviourType
    activeSurfaces: {NavMeshSurface}
end
declare NavMeshSurface: NavMeshSurfaceType

declare class OffMeshLinkHandler extends MonoBehaviour
    heightMultiplier: number
    speedMultiplier: number
    function __tostring(self): string
end
declare class OffMeshLinkHandlerType extends MonoBehaviourType
end
declare OffMeshLinkHandler: OffMeshLinkHandlerType

declare class Scene extends MonoBehaviour
    id: number
    mainCamera: Camera
    name: string
    playerCount: number
    PlayerJoined: Event
    PlayerLeft: Event
    players: {Player}
    renderSettings: RenderSettings
    Instantiate: <T>(self: Scene, original: T, position: Vector3?, rotation: Quaternion?) -> T
end
declare scene: Scene

declare class StringChangeEvent extends LuaChangeEvent
    eventTypeId: number
    newValue: string
    previousValue: string
    function __tostring(self): string
end
declare class StringChangeEventType extends LuaChangeEventType
end
declare StringChangeEvent: StringChangeEventType

declare class UIButton extends VisualElement
    contentContainer: VisualElement
    function __tostring(self): string
end
declare class UIButtonType extends VisualElementType
    new: (() -> UIButton)
end
declare UIButton: UIButtonType

declare class UICollectionCells extends VisualElement
    cellCount: number
    collection: UICollection
    hasLayout: boolean
    loading: boolean
    provider: UICollectionProvider
    section: UICollectionSection
    selection: {number}
    selectionCount: number
    visibleCells: {UIView}
    function __tostring(self): string
    function AddCell(self)
    function AddCells(self, count: number)
    function Deselect(self, cell: UIView)
    function Deselect(self, cellIndex: number)
    function DeselectAll(self)
    function Dispose(self)
    function EnumerateVisibleCells(self, enumerate: (UIView, number, boolean) -> (boolean))
    function GetVisibleCell(self, cellIndex: number): UIView
    function IndexOf(self, cell: UIView): number
    function InsertCell(self, index: number)
    function InsertCells(self, index: number, count: number)
    function InstantiateCell(self, cellIndex: number): UIView
    function IsSelected(self, cell: UIView): boolean
    function IsSelected(self, cellIndex: number): boolean
    function ItemSizeChanged(self, itemIndex: number, itemPosition: number, delta: number)
    function RecycleAllCells(self)
    function RecycleCell(self, index: number, cell: UIView)
    function RemoveAllCells(self)
    function RemoveCell(self, index: number)
    function RemoveCells(self, index: number, count: number)
    function ScrollTo(self, cellIndex: number)
    function ScrollTo(self, cellIndex: number, additionalOffset: number)
    function Select(self, cell: UIView)
    function Select(self, cell: UIView, add: boolean)
    function Select(self, cellIndex: number)
    function Select(self, cellIndex: number, add: boolean)
    function SelectionIndexOf(self, cellIndex: number): number
    function SetLayout(self, layout: UICollectionGridLayout)
    function SetLayout(self, layout: UICollectionStackLayout)
    function Toggle(self, cell: UIView)
    function Toggle(self, cell: UIView, add: boolean)
    function Toggle(self, cellIndex: number)
    function Toggle(self, cellIndex: number, add: boolean)
    function UpdateCell(self, index: number)
    function UpdateCells(self, index: number, count: number)
    function UpdateLayout(self, min: number, max: number): number
end
declare class UICollectionCellsType extends VisualElementType
    new: (() -> UICollectionCells)
end
declare UICollectionCells: UICollectionCellsType

declare class UICollectionSection extends VisualElement
    cells: UICollectionCells
    collection: UICollection
    function __tostring(self): string
    function InvalidateLayout(self)
    function Rebuild(self)
    function UpdateLayout(self, min: number, max: number): number
end
declare class UICollectionSectionType extends VisualElementType
    new: (() -> UICollectionSection)
    new: ((cells: UICollectionCells) -> UICollectionSection)
end
declare UICollectionSection: UICollectionSectionType

declare class UIProgressBar extends VisualElement
    value: number
    function __tostring(self): string
end
declare class UIProgressBarType extends VisualElementType
    new: (() -> UIProgressBar)
end
declare UIProgressBar: UIProgressBarType

declare class UIScrollBar extends VisualElement
    isReversed: boolean
    max: number
    min: number
    value: number
    function __tostring(self): string
    function SetValueWithoutNotify(self, newValue: number)
end
declare class UIScrollBarType extends VisualElementType
    new: (() -> UIScrollBar)
end
declare UIScrollBar: UIScrollBarType

declare class UIScrollView extends VisualElement
    contentContainer: VisualElement
    contentSize: number
    contentViewport: VisualElement
    hasInertia: boolean
    isAtEnd: boolean
    isInertiaEnabled: boolean
    isScrolling: boolean
    onScrollEnd: () -> ()
    scrollableSize: number
    value: number
    viewportSize: number
    worldBound: Rect
    function __tostring(self): string
    function AdjustScrollOffset(self, delta: number)
    function AdjustScrollOffsetForNewContent(self)
    function CancelAnimation(self)
    function Dispose(self)
    function ScrollTo(self, child: VisualElement)
    function ScrollToBeginning(self)
    function ScrollToBeginning(self, animationDuration: number)
    function ScrollToElement(self, element: VisualElement)
    function ScrollToElement(self, element: VisualElement, animationDuration: number)
    function ScrollToEnd(self)
    function ScrollToEnd(self, animationDuration: number)
    function ScrollToOffset(self, offset: number)
    function ScrollToOffset(self, offset: number, animationDuration: number)
    function ScrollToOffset(self, offset: number, animationDuration: number, propagateAnimation: boolean)
    function SetValueWithoutNotify(self, newValue: number)
end
declare class UIScrollViewType extends VisualElementType
    defaultScrollDecelerationRate: number
    fastScrollDecelerationRate: number
    isClamped: boolean
    isElastic: boolean
    minInertiaVelocity: number
    scrollDecelerationRate: number
    scrollWheelRate: number
    ussScrollView: string
    ussScrollViewContent: string
    ussScrollViewFadeEdges: string
    ussScrollViewGradients: string
    ussScrollViewGradientsBottom: string
    ussScrollViewGradientsTop: string
    ussScrollViewHorizontal: string
    ussScrollViewVertical: string
    ussScrollViewViewport: string
    new: (() -> UIScrollView)
end
declare UIScrollView: UIScrollViewType

declare class UISwitchToggle extends VisualElement
    value: boolean
    function __tostring(self): string
    function SetValueWithoutNotify(self, newValue: boolean)
end
declare class UISwitchToggleType extends VisualElementType
    new: (() -> UISwitchToggle)
end
declare UISwitchToggle: UISwitchToggleType

declare class UIView extends VisualElement
    isDisplayed: boolean
    function __tostring(self): string
    function Dispose(self)
    function RegisterBackCallback(self, handler: () -> (boolean))
    function Reset(self)
    function UnregisterBackCallback(self)
end
declare class UIViewType extends VisualElementType
    displayBegin: (UIView) -> ()
    displayEnd: (UIView) -> ()
    BindHierarchy: ((element: VisualElement) -> ())
    ClearAndDisposeChildren: ((element: VisualElement) -> ())
    DisposeChildren: ((element: VisualElement) -> ())
    new: (() -> UIView)
end
declare UIView: UIViewType

declare class WorldBehaviour extends MonoBehaviour
    scene: Scene
    function __tostring(self): string
end
declare class WorldBehaviourType extends MonoBehaviourType
end
declare WorldBehaviour: WorldBehaviourType

declare class WorldRoomContext extends MonoBehaviour
    function Raycast(self, ray: Ray, layerMask: number): (boolean, RaycastHit)
end
declare class WorldRoomContextType extends MonoBehaviourType
end
declare WorldRoomContext: WorldRoomContextType

declare class AbstractProgressBar extends BindableElement
    highValue: number
    lowValue: number
    title: string
    value: number
    function __tostring(self): string
    function SetValueWithoutNotify(self, newValue: number)
end
declare class AbstractProgressBarType extends BindableElementType
    backgroundUssClassName: string
    containerUssClassName: string
    progressUssClassName: string
    titleContainerUssClassName: string
    titleUssClassName: string
    ussClassName: string
end
declare AbstractProgressBar: AbstractProgressBarType

declare class AnimationEventHandler extends WorldBehaviour
    StateEnter: Event
    StateExit: Event
    StateIK: Event
    StateMove: Event
    StateUpdate: Event
end
declare class AnimationEventHandlerType extends WorldBehaviourType
end
declare AnimationEventHandler: AnimationEventHandlerType

declare class BaseField extends BindableElement
end
declare class BaseFieldType extends BindableElementType
end
declare BaseField: BaseFieldType

declare class DeepLinkExecutor extends WorldBehaviour
    function __tostring(self): string
end
declare class DeepLinkExecutorType extends WorldBehaviourType
end
declare DeepLinkExecutor: DeepLinkExecutorType

declare class EmoteAsset extends CharacterAnimation
end
declare class EmoteAssetType extends CharacterAnimationType
end
declare EmoteAsset: EmoteAssetType

declare class NetworkBehaviour extends WorldBehaviour
    function __tostring(self): string
end
declare class NetworkBehaviourType extends WorldBehaviourType
end
declare NetworkBehaviour: NetworkBehaviourType

declare class TapHandler extends WorldBehaviour
    distance: number
    hasAnchors: boolean
    moveTarget: Vector3
    moveTo: boolean
    Tapped: Event
    function __tostring(self): string
    function GetClosestAnchor(self, position: Vector3): Anchor
    function Perform(self, position: Vector3)
end
declare class TapHandlerType extends WorldBehaviourType
end
declare TapHandler: TapHandlerType

declare class TextElement extends BindableElement
    displayTooltipWhenElided: boolean
    enableRichText: boolean
    experimental: ITextElementExperimentalFeatures
    isElided: boolean
    parseEscapeSequences: boolean
    selection: ITextSelection
    text: string
    function __tostring(self): string
end
declare class TextElementType extends BindableElementType
    ussClassName: string
    new: (() -> TextElement)
end
declare TextElement: TextElementType

declare class UICollection extends UIView
    contentContainer: VisualElement
    isPerformingUpdates: boolean
    isReversed: boolean
    recycleOnHide: boolean
    scrollView: IScrollView
    function __tostring(self): string
    function InitializeSections(self)
    function PerformUpdates(self, updates: () -> ())
    function Rebuild(self)
    function ScrollTo(self, cells: UICollectionCells, cellIndex: number)
    function ScrollTo(self, cells: UICollectionCells, cellIndex: number, padding: number)
    function ScrollToBeginning(self)
    function ScrollToBeginning(self, animationDuration: number)
    function ScrollToEnd(self)
end
declare class UICollectionType extends UIViewType
    new: (() -> UICollection)
    new: ((scrollView: IScrollView) -> UICollection)
end
declare UICollection: UICollectionType

declare class UIImage extends Image
    function __tostring(self): string
    function Dispose(self)
    function LoadFromCdnUrl(self, url: string)
    function LoadItemPreview(self, category: string, id: string)
    function LoadItemPreview(self, category: string, id: string, clothingPaletteId: number)
    function ShowLoadingIndicator(self, show: boolean)
end
declare class UIImageType extends ImageType
    new: (() -> UIImage)
end
declare UIImage: UIImageType

declare class UILocalizedButton extends UIButton
    function __tostring(self): string
end
declare class UILocalizedButtonType extends UIButtonType
    new: (() -> UILocalizedButton)
    new: ((text: LocalizedString) -> UILocalizedButton)
end
declare UILocalizedButton: UILocalizedButtonType

declare class UILuaView extends UIView
    function __tostring(self): string
end
declare view: UILuaView

declare class UISlider extends UIView
    highValue: number
    lowValue: number
    value: number
    function __tostring(self): string
    function SetValueWithoutNotify(self, newValue: number)
end
declare class UISliderType extends UIViewType
    Instantiate: (() -> UISlider)
    new: (() -> UISlider)
end
declare UISlider: UISliderType

declare class UIThumbstick extends UIView
    container: VisualElement
    isAnchored: boolean
    knob: VisualElement
    movementDirection: Vector2
    preventDragging: boolean
    function __tostring(self): string
end
declare class UIThumbstickType extends UIViewType
    new: (() -> UIThumbstick)
end
declare UIThumbstick: UIThumbstickType

declare class UIUserThumbnail extends UIView
    showOnlineIndicator: boolean
    function __tostring(self): string
    function Load(self, player: Player)
    function Load(self, userId: string)
    function Unload(self)
end
declare class UIUserThumbnailType extends UIViewType
    new: (() -> UIUserThumbnail)
end
declare UIUserThumbnail: UIUserThumbnailType

declare class Anchor extends NetworkBehaviour
    Entered: Event
    enterFrom: Transform
    enterFromPosition: Vector3
    Exited: Event
    exitTo: Transform
    exitToPosition: Vector3
    isOccupied: boolean
    isTappable: boolean
    occupant: Character
    function __tostring(self): string
end
declare class AnchorType extends NetworkBehaviourType
end
declare Anchor: AnchorType

declare class Button extends TextElement
    function __tostring(self): string
end
declare class ButtonType extends TextElementType
    ussClassName: string
    new: (() -> Button)
    new: ((clickEvent: () -> ()) -> Button)
end
declare Button: ButtonType

declare class Character extends NetworkBehaviour
    anchor: Anchor
    AnchorChanged: Event
    AnimationEvent: Event
    chatBubbleTransform: Transform
    defaultOutfits: {CharacterOutfit}
    destination: Vector3
    distanceToDestination: number
    hasOutfit: boolean
    isAnchored: boolean
    isIdle: boolean
    isMoving: boolean
    MoveFinished: Event
    MoveStarted: Event
    OutfitChanged: Event
    outfits: {CharacterOutfit}
    pet: Pet
    player: Player
    renderLayer: number
    renderMaterial: Material
    renderPosition: Vector3
    renderRotation: Quaternion
    renderScale: Vector3
    renderShadow: boolean
    speed: number
    state: CharacterState
    StateChanged: Event
    usePathfinding: boolean
    function __tostring(self): string
    function AddOutfit(self, outfit: CharacterOutfit)
    function CopyOutfit(self, character: Character)
    function JumpTo(self, position: Vector3): boolean
    function JumpTo(self, position: Vector3, jumpSpeedMultiplier: number, jumpHeightMultiplier: number): boolean
    function JumpTo(self, position: Vector3, jumpSpeedMultiplier: number, jumpHeightMultiplier: number, taskCompleteCallback: (...any) -> (...any)): boolean
    function JumpTo(self, position: Vector3, taskCompleteCallback: (...any) -> (...any)): boolean
    function MoveTo(self, position: Vector3): boolean
    function MoveTo(self, position: Vector3, areaMask: number): boolean
    function MoveTo(self, position: Vector3, areaMask: number, callback: (...any) -> (...any)): boolean
    function MoveTo(self, position: Vector3, areaMask: number, callback: (...any) -> (...any), targetSearchDistance: number): boolean
    function MoveToAnchor(self, anchor: Anchor): boolean
    function MoveToAnchor(self, anchor: Anchor, areaMask: number): boolean
    function MoveToAnchor(self, anchor: Anchor, areaMask: number, callback: (...any) -> (...any)): boolean
    function MoveWithinRangeOf(self, destination: Vector3, stopDistance: number): boolean
    function MoveWithinRangeOf(self, destination: Vector3, stopDistance: number, areaMask: number): boolean
    function MoveWithinRangeOf(self, destination: Vector3, stopDistance: number, areaMask: number, callback: (...any) -> (...any)): boolean
    function MoveWithinRangeOf(self, destination: Vector3, stopDistance: number, areaMask: number, callback: (...any) -> (...any), targetSearchDistance: number): boolean
    function PlayAnimation(self, anim: CharacterAnimation): boolean
    function PlayAnimation(self, anim: CharacterAnimation, speed: number): boolean
    function PlayAnimation(self, anim: CharacterAnimation, speed: number, loop: boolean): boolean
    function PlayAnimation(self, anim: CharacterAnimation, speed: number, loop: boolean, callback: (...any) -> (...any)): boolean
    function PlayEmote(self, emoteName: string): boolean
    function PlayEmote(self, emoteName: string, loop: boolean): boolean
    function PlayEmote(self, emoteName: string, loop: boolean, callback: (...any) -> (...any)): boolean
    function PlayEmote(self, emoteName: string, speed: number): boolean
    function PlayEmote(self, emoteName: string, speed: number, loop: boolean): boolean
    function PlayEmote(self, emoteName: string, speed: number, loop: boolean, callback: (...any) -> (...any)): boolean
    function PlaySpeakingAnimation(self)
    function RemoveOutfit(self, outfit: CharacterOutfit)
    function ResetOutfit(self)
    function SetIdle(self)
    function SetOutfit(self, outfit: CharacterOutfit)
    function StopEmote(self)
    function Teleport(self, position: Vector3): boolean
    function Teleport(self, position: Vector3, taskCompleteCallback: (...any) -> (...any)): boolean
    function TeleportToAnchor(self, anchor: Anchor): boolean
    function TeleportToNearestNavMeshPosition(self)
    function TweenRenderPosition(self, from: Vector3, to: Vector3): Tween
    function TweenRenderPositionTo(self, to: Vector3): Tween
end
declare class CharacterType extends NetworkBehaviourType
end
declare Character: CharacterType

declare class Label extends TextElement
    function __tostring(self): string
end
declare class LabelType extends TextElementType
    ussClassName: string
    new: (() -> Label)
    new: ((text: string) -> Label)
end
declare Label: LabelType

declare class LuaBehaviour extends NetworkBehaviour
end
declare class LuaBehaviourType extends NetworkBehaviourType
end
declare LuaBehaviour: LuaBehaviourType

declare class ProgressBar extends AbstractProgressBar
    function __tostring(self): string
end
declare class ProgressBarType extends AbstractProgressBarType
    new: (() -> ProgressBar)
end
declare ProgressBar: ProgressBarType

declare class TextInputBaseField extends BaseField
end
declare class TextInputBaseFieldType extends BaseFieldType
end
declare TextInputBaseField: TextInputBaseFieldType

declare class UILabel extends TextElement
    autoSizingFontSize: number
    minFontSize: number
    onLinkPress: (string) -> ()
    text: string
    titlecase: boolean
    uppercase: boolean
    function __tostring(self): string
    function AdjustFontSize(self)
    function CancelPendingDecoratedLinksFetch(self)
    function Dispose(self)
    function SetEmojiPrelocalizedText(self, value: string)
    function SetEmojiPrelocalizedText(self, value: string, skipValidation: boolean)
    function SetPrelocalizedText(self, value: string)
    function SetPrelocalizedText(self, value: string, skipRtlValidation: boolean)
    function SetSocialEmojiText(self, value: string)
    function SetSocialText(self, value: string)
end
declare class UILabelType extends TextElementType
    EmojiPrelocalized: ((text: string) -> UILabel)
    EmojiPrelocalized: ((text: string, skipValidation: boolean) -> UILabel)
    EmojiPrelocalized: ((text: string, skipValidation: boolean, skipRtlValidation: boolean) -> UILabel)
    new: (() -> UILabel)
    PreLocalized: ((text: string) -> UILabel)
    PreLocalized: ((text: string, skipValidation: boolean) -> UILabel)
    PreLocalized: ((text: string, skipValidation: boolean, skipRtlValidation: boolean) -> UILabel)
end
declare UILabel: UILabelType

declare class UIOutlinedLabel extends TextElement
    hasShadow: boolean
    text: string
    uppercase: boolean
    function __tostring(self): string
    function AdjustFontSize(self)
    function Dispose(self)
    function SetPrelocalizedText(self, value: string)
    function SetPrelocalizedText(self, value: string, skipRtlValidation: boolean)
end
declare class UIOutlinedLabelType extends TextElementType
    ussOutlinedLabel: string
    new: (() -> UIOutlinedLabel)
end
declare UIOutlinedLabel: UIOutlinedLabelType

declare class Self extends LuaBehaviour
    function Awake(self)
    function ClientAwake(self)
    function ClientFixedUpdate(self)
    function ClientLateUpdate(self)
    function ClientOnDestroy(self)
    function ClientOnDisable(self)
    function ClientOnEnable(self)
    function ClientStart(self)
    function ClientUpdate(self)
    function FixedUpdate(self)
    function LateUpdate(self)
    function OnCollisionEnter(self, hit: Collision)
    function OnCollisionExit(self, hit: Collision)
    function OnCollisionStay(self, hit: Collision)
    function OnDestroy(self)
    function OnDisable(self)
    function OnEnable(self)
    function OnTriggerEnter(self, collider: Collider)
    function OnTriggerExit(self, collider: Collider)
    function OnTriggerStay(self, collider: Collider)
    function ServerAwake(self)
    function ServerFixedUpdate(self)
    function ServerLateUpdate(self)
    function ServerOnDestroy(self)
    function ServerOnDisable(self)
    function ServerOnEnable(self)
    function ServerStart(self)
    function ServerUpdate(self)
    function Start(self)
    function Update(self)
end
declare self: Self

declare class UILocalizedLabel extends UILabel
    function __tostring(self): string
    function SetPluralText(self, localizedString: LocalizedString, count: number)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string, param3: string)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string, param3: string, param4: string)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string, param3: string, param4: string, param5: string)
    function SetText(self, localizedString: LocalizedString)
    function SetText(self, localizedString: LocalizedString, param1: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string, param3: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string, param5: string)
end
declare class UILocalizedLabelType extends UILabelType
    new: (() -> UILocalizedLabel)
    new: ((localizedString: LocalizedString) -> UILocalizedLabel)
    new: ((localizedString: LocalizedString, param1: string) -> UILocalizedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string) -> UILocalizedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string, param3: string) -> UILocalizedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string) -> UILocalizedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string, param5: string) -> UILocalizedLabel)
end
declare UILocalizedLabel: UILocalizedLabelType

declare class UILocalizedOutlinedLabel extends UIOutlinedLabel
    function __tostring(self): string
    function SetPluralText(self, localizedString: LocalizedString, count: number)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string, param3: string)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string, param3: string, param4: string)
    function SetPluralText(self, localizedString: LocalizedString, count: number, param2: string, param3: string, param4: string, param5: string)
    function SetText(self, localizedString: LocalizedString)
    function SetText(self, localizedString: LocalizedString, param1: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string, param3: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string)
    function SetText(self, localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string, param5: string)
end
declare class UILocalizedOutlinedLabelType extends UIOutlinedLabelType
    new: (() -> UILocalizedOutlinedLabel)
    new: ((localizedString: LocalizedString) -> UILocalizedOutlinedLabel)
    new: ((localizedString: LocalizedString, param1: string) -> UILocalizedOutlinedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string) -> UILocalizedOutlinedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string, param3: string) -> UILocalizedOutlinedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string) -> UILocalizedOutlinedLabel)
    new: ((localizedString: LocalizedString, param1: string, param2: string, param3: string, param4: string, param5: string) -> UILocalizedOutlinedLabel)
end
declare UILocalizedOutlinedLabel: UILocalizedOutlinedLabelType

declare class UITextFieldBase extends TextInputBaseField
    autoCorrection: boolean
    cursorColor: Color
    cursorIndex: number
    cursorPosition: Vector2
    doubleClickSelectsWord: boolean
    fontStyle: FontStyle
    hideMobileInput: boolean
    inputPattern: string
    isDelayed: boolean
    isPasswordField: boolean
    isReadOnly: boolean
    isShiftReturnModeEnabled: boolean
    label: string
    labelElement: Label
    maskChar: Char
    maxLength: number
    multiline: boolean
    originalValue: string
    selectAllOnFocus: boolean
    selectAllOnMouseUp: boolean
    selectIndex: number
    selectionColor: Color
    showMixedValue: boolean
    text: string
    textAlign: TextAnchor
    textEdition: ITextEdition
    textElement: TextElement
    textSelection: ITextSelection
    tripleClickSelectsLine: boolean
    value: string
    function __tostring(self): string
    function ReplaceSelection(self, value: string)
    function SelectAll(self)
    function SelectNone(self)
    function SelectRange(self, cursorIndex: number, selectionIndex: number)
    function SelectTextEnd(self)
    function SetValueWithoutNotify(self, newValue: string)
end
declare class UITextFieldBaseType extends TextInputBaseFieldType
    emojiParser: IEmojiParser
    fixRightToLeft: (string, TextElement) -> (string)
    inputUssClassName: string
    labelUssClassName: string
    ussClassName: string
    new: (() -> UITextFieldBase)
    new: ((label: string) -> UITextFieldBase)
    new: ((label: string, maxLength: number, multiline: boolean, isPasswordField: boolean, maskChar: Char) -> UITextFieldBase)
    new: ((maxLength: number, multiline: boolean, isPasswordField: boolean, maskChar: Char) -> UITextFieldBase)
end
declare UITextFieldBase: UITextFieldBaseType

declare class UITextField extends UITextFieldBase
    autoCorrection: boolean
    cursorColor: Color
    cursorIndex: number
    cursorPosition: Vector2
    disableAutocorrection: boolean
    doubleClickSelectsWord: boolean
    enableMarkup: boolean
    hideMobileInput: boolean
    inputLengthLimit: number
    isDelayed: boolean
    isPasswordField: boolean
    isReadOnly: boolean
    label: string
    labelElement: Label
    maskChar: Char
    maxLength: number
    selectAllOnFocus: boolean
    selectAllOnMouseUp: boolean
    selectIndex: number
    selectionColor: Color
    showClearButton: boolean
    showMixedValue: boolean
    showPlaceholderOnEmptyFocus: boolean
    showSearchIcon: boolean
    text: string
    textEdition: ITextEdition
    textSelection: ITextSelection
    tripleClickSelectsLine: boolean
    function __tostring(self): string
    function BlurOnReturn(self)
    function Dispose(self)
    function LeftTextMargin(self): number
    function MeasureTextHeight(self): number
    function SelectAll(self)
    function SelectNone(self)
    function SelectRange(self, cursorIndex: number, selectionIndex: number)
    function SetDecoratedValueWithoutNotify(self, value: string)
    function SetPlaceholderText(self, str: string)
    function SetValueWithoutNotify(self, newValue: string)
end
declare class UITextFieldType extends UITextFieldBaseType
    FocusedTextField: (() -> UITextField)
    IsTextFieldFocused: (() -> boolean)
    new: (() -> UITextField)
end
declare UITextField: UITextFieldType

declare class UILocalizedTextField extends UITextField
    autoCorrection: boolean
    cursorColor: Color
    cursorIndex: number
    cursorPosition: Vector2
    doubleClickSelectsWord: boolean
    hideMobileInput: boolean
    isDelayed: boolean
    isPasswordField: boolean
    isReadOnly: boolean
    label: string
    labelElement: Label
    maskChar: Char
    maxLength: number
    selectAllOnFocus: boolean
    selectAllOnMouseUp: boolean
    selectIndex: number
    selectionColor: Color
    showMixedValue: boolean
    text: string
    textEdition: ITextEdition
    textSelection: ITextSelection
    tripleClickSelectsLine: boolean
    function __tostring(self): string
    function SelectAll(self)
    function SelectNone(self)
    function SelectRange(self, cursorIndex: number, selectionIndex: number)
    function SetPlaceholderText(self, localizedString: LocalizedString)
end
declare class UILocalizedTextFieldType extends UITextFieldType
    new: (() -> UILocalizedTextField)
end
declare UILocalizedTextField: UILocalizedTextFieldType

declare defer: ((...any) -> any) -> ()
