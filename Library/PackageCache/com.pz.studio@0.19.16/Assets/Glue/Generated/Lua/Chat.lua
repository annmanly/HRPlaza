--!AddComponentMenu("")

-- Chat
type Chat =
{
    ChannelDestroyed: LuaEvent,
    PlayerJoinedChannel: LuaEvent,
    PlayerLeftChannel: LuaEvent,
    TextMessageReceivedHandler: LuaEvent,
    WhisperReceivedHandler: LuaEvent,
    activeChannel: ChannelInfo,
    allChannels: {ChannelInfo},
    joinedChannels: {ChannelInfo},
    ApplyVideoToSurface: (userId: string , go: GameObject) -> (),
    DisableVideo: () -> (),
    DisplayChatBubble: (position: Transform , message: string , name: string?) -> (),
    DisplayTextMessage: (channel: ChannelInfo , from: Player , message: string , language: string) -> (),
    EnableVideo: () -> (),
    GetChannel: (channelName: string) -> ChannelInfo,
}

-- ChatType
type ChatType =
{
    allJoinedChannels: () -> {ChannelInfo},
}

if not _G.Chat then
    local ChatType_instance : ChatType = {}
    _G.Chat = ChatType_instance;
end
