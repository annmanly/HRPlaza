--!AddComponentMenu("")

-- ChannelInfo
type ChannelInfo =
{
    activePlayers: {Player},
    allowsText: boolean,
    allowsVoice: boolean,
    channelId: number,
    isWhisperChannel: boolean,
    maxVolumeDistance: number,
    minVolumeDistance: number,
    name: string,
    players: {Player},
    priority: number,
    proximityChatEnabled: boolean,
    isActive: boolean,
    isJoined: boolean,
    IsPlayerActiveChannel: (player: Player) -> boolean,
    IsPlayerInChannel: (player: Player) -> boolean,
}

-- ChannelInfoType
type ChannelInfoType =
{
}

if not _G.ChannelInfo then
    local ChannelInfoType_instance : ChannelInfoType = {}
    _G.ChannelInfo = ChannelInfoType_instance;
end
